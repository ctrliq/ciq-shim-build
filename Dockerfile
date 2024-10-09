# Container to build CIQ's patched shim in a reproducible way
#
# It inserts a static repo for buildtime deps, then performs the rpmbuild/compilation, then outputs a comparison of binaries
# 
# Build and tag locally with:   docker build --tag ciq-shim-review:8 ./
#

FROM --platform=linux/arm64 rockylinux/rockylinux:8.8.20230518 AS arm64

ENV shim_release 15.8-0.el8

# Copy and extract src rpm and macros, modify setarch in spec file because 32-bit mod is not allowed inside containers:
COPY rpmmacros  /root/.rpmmacros
COPY shim-unsigned-aarch64-$shim_release.src.rpm /root
RUN rpm -ivh /root/shim-unsigned-aarch64-$shim_release.src.rpm

# already-built shim binaries for comparison:
COPY shimaa64.efi /

# Remove all repos, and point *only* to our static one with the necessary BuildRequires
# We don't want to contaminate the build with anything different - it must be reproducible
RUN rm -f /etc/yum.repos.d/*.repo
COPY ciq_static_shim.repo  /etc/yum.repos.d/

# Install necessary packages, and run the build:
RUN dnf -y install dnf-plugins-core rpm-build;  dnf -y  builddep /builddir/build/SPECS/shim-unsigned-aarch64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-aarch64.spec


# Put resulting RPM in a temp folder (optionally mounted on host system for extraction)
RUN mkdir -p /shim_result
RUN rpm2cpio /builddir/build/RPMS/aarch64/shim-unsigned-aarch64-$shim_release.aarch64.rpm | cpio -diu -D /shim_result



# Insert shim-compare.sh script and run
COPY shim-compare.sh  /root
RUN chmod 0755 /root/shim-compare.sh;  /root/shim-compare.sh



