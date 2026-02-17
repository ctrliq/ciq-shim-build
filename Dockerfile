# Multi-platform CIQ shim build for x86_64 (with ia32) and aarch64
# Following proven reproducibility verification pattern
#
# Build with: docker buildx build --platform linux/amd64 --tag ciq-shim-review:16.1 --load .

# Stage 1: Build x64 + ia32 on AMD64 platform
FROM --platform=linux/amd64 rockylinux:9.6 AS amd64
ARG SHIM_VERSION=16.1-0.el9

# Copy build configuration
COPY rpmmacros /root/.rpmmacros
COPY shim-unsigned-x64-16.1-0.el9.src.rpm /root/shim-unsigned-x64-${SHIM_VERSION}.src.rpm
RUN rpm -ivh /root/shim-unsigned-x64-${SHIM_VERSION}.src.rpm

# Fix spec file for container builds
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec

# Copy control binaries to root (proven location)
COPY shimx64.efi /

# Remove default repos and add static repo
RUN rm -f /etc/yum.repos.d/*.repo
COPY ciq_static_shim.repo /etc/yum.repos.d/

# Install and build
RUN dnf -y install dnf-plugins-core rpm-build cpio &&     dnf -y builddep /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec

# Extract built RPMs to /shim_result (proven pattern)
RUN mkdir -p /shim_result
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-${SHIM_VERSION}.x86_64.rpm | cpio -diu -D /shim_result

# Stage 2: Build aa64 on ARM64 platform
FROM --platform=linux/arm64 rockylinux:9.6 AS arm64
ARG SHIM_VERSION=16.1-0.el9

# Copy build configuration
COPY rpmmacros /root/.rpmmacros
COPY shim-unsigned-aarch64-16.1-0.el9.src.rpm /root/shim-unsigned-aarch64-${SHIM_VERSION}.src.rpm
RUN rpm -ivh /root/shim-unsigned-aarch64-${SHIM_VERSION}.src.rpm

# Copy control binary to root
COPY shimaa64.efi /

# Remove default repos and add static aa64 repo (required for reproducible builds)
RUN rm -f /etc/yum.repos.d/*.repo
COPY ciq_static_shim_aa64.repo /etc/yum.repos.d/

# Install and build
RUN dnf -y install dnf-plugins-core rpm-build cpio &&     dnf -y builddep /builddir/build/SPECS/shim-unsigned-aarch64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-aarch64.spec

# Extract built RPM to /shim_result
RUN mkdir -p /shim_result
RUN rpm2cpio /builddir/build/RPMS/aarch64/shim-unsigned-aarch64-${SHIM_VERSION}.aarch64.rpm | cpio -diu -D /shim_result

# Final Stage: Aggregate and run reproducibility verification
FROM --platform=linux/amd64 rockylinux:9.6
ARG SHIM_VERSION=16.1-0.el9

# Install pesign and diffutils for verification (diffutils provides cmp command)
RUN dnf install -y pesign diffutils

# Copy control binaries from build context
COPY shimx64.efi /
COPY shimaa64.efi /

# Copy built binaries from both stages to /shim_result
COPY --from=amd64 /shim_result/ /shim_result/
COPY --from=arm64 /shim_result/ /shim_result/

# Copy and run comparison script (proven verification)
COPY shim-compare.sh /root/
RUN chmod 0755 /root/shim-compare.sh && /root/shim-compare.sh
