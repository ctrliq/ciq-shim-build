# Container to build CIQ's patched shim in a reproducible way
#
# It inserts a static repo for buildtime deps, then performs the rpmbuild/compilation, then outputs a comparison of binaries
# 
# Build and tag locally with:   docker build --tag ciq-shim-review:8 ./
#

FROM rockylinux:8.8.20230518

ENV shim_release 15.7-3.el8

# Copy and extract src rpm and macros, modify setarch in spec file because 32-bit mod is not allowed inside containers:
COPY rpmmacros  /root/.rpmmacros
COPY shim-unsigned-x64-$shim_release.src.rpm  /root
RUN rpm -ivh /root/shim-unsigned-x64-$shim_release.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec


# already-built shim binaries for comparison:
COPY shimx64.efi  /
COPY shimia32.efi  /


# Remove all repos, and point *only* to our static one with the necessary BuildRequires
# We don't want to contaminate the build with anything different - it must be reproducible
RUN rm -f /etc/yum.repos.d/*.repo
COPY ciq_static_shim.repo  /etc/yum.repos.d/

# Install necessary packages, and run the build:
RUN dnf -y install dnf-plugins-core rpm-build;  dnf -y  builddep /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec


# Put resulting RPM in a temp folder (optionally mounted on host system for extraction)
RUN mkdir -p /shim_result
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-$shim_release.x86_64.rpm | cpio -diu -D /shim_result
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-$shim_release.x86_64.rpm | cpio -diu -D /shim_result



# Insert shim-compare.sh script and run
COPY shim-compare.sh  /root
RUN chmod 0755 /root/shim-compare.sh;  /root/shim-compare.sh



