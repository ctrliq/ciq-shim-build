This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)  
- edit the template below  
- add the shim.efi to be signed  
- add build logs  
- add any additional binaries/certificates/SHA256 hashes that may be needed  
- commit all of that  
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"  
- push it to GitHub  
- file an issue at [https://github.com/rhboot/shim-review/issues](https://github.com/rhboot/shim-review/issues) with a link to your tag  
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so asking us to endorse anything else for signing is going to require some convincing on your part.

As of 20 October 2025, shims sent to Microsoft will be signed with the 2011 and 2023 keys. For each shim you submit, you will receive two copies back, each signed by a different key. Here is the latest information from Microsoft: [https://techcommunity.microsoft.com/blog/hardware-dev-center/signing-with-the-new-2023-microsoft-uefi-certificates-what-submitters-need-to-kn/4455787](https://techcommunity.microsoft.com/blog/hardware-dev-center/signing-with-the-new-2023-microsoft-uefi-certificates-what-submitters-need-to-kn/4455787)

New signing requirements have also taken effect, and are available here: [https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916](https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916) Please note that undergoing this shim review exempts you from yearly security audits, as long as your shim only hands off to open source boot loaders.

Hint: check the [docs](http://./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

---

### What organization or people are asking to have this signed?

---

CIQ Inc. ( https://ciq.com ) 

---

### What's the legal data that proves the organization's genuineness?

The reviewers should be able to easily verify that your organization is a legal entity, to prevent abuse. Provide the information, which can prove the genuineness with certainty.

---

Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)

Legal Entity Verification Information for CIQ Shim Submission Company/Tax Register Information

(Ctrl IQ, Inc.) is registered as a corporation in Nevada.

**Company Registration:**

* **Legal Name:** Ctrl IQ, Inc. (DBA CIQ)  
* **Jurisdiction:** Nevada, United States  
* **Physical Address:** 560 Mill St Ste 302, Reno, NV 89502-1195  
* **Registration Link:** You'll need to search Nevada SOS database at: [https://esos.nv.gov/EntitySearch/OnlineEntitySearch](https://esos.nv.gov/EntitySearch/OnlineEntitySearch)  
  * Search for "Ctrl IQ Inc"   
  * Search results will return a single result click link to see CIQ’s company information  
  * Gregory Kurtzer CIQ’s founder and CEO is listed in the Officer information

```shell
Issuer: CN=Sectigo Public Code Signing CA EV R36,O=Sectigo Limited,C=GB
Subject: CN=Ctrl IQ, Inc.,O=Ctrl IQ, Inc.,ST=Nevada,C=US,businessCategory=Private Organization,jurisdictionOfIncorporationStateOrProvinceName=Nevada,jurisdictionOfIncorporationCountryName=US,serialNumber=E22202592022-1
```

---

### What product or service is this for?

---

CIQ provides support for Extending Rocky Linux for our customers and the community, this includes extended kernel modifications for security and feature enhancements to Rockly Linux and Linus Stable/LT kernels.  In addition we compile 3rd party drivers so they can remain signed and tightly integrated to the kernels we ship.  
---

### What's the justification that this really does need to be signed for the whole world to be able to boot it?

---

Our customers use a variety of hardware platforms. Many of them have policies in place, or are contractually obligated in some way to use the default EFI firmware with no customized secureboot/MOK key injection. At the same time, many customers require security backports for their workload.

---

### Why are you unable to reuse shim from another distro that is already signed?

---

We need these customized kernels to boot properly on stock hardware. This is not possible with the default Rocky Linux (or RHEL) shim binary. 

---

### Who is the primary contact for security updates, etc.?

The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words. You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.

---

- Name: Jason Rodriguez  
- Position: Sr Principal Software Engineer  
- Email address: [jrodriguez@ciq.com](mailto:jrodriguez@ciq.com)  
- PGP key fingerprint: 0310 CFD4 0447 4D14 5072 D3E1 EAFF ECB3 C3AB C924  
- PGP key URL: [https://keys.openpgp.org/vks/v1/by-fingerprint/0310CFD404474D145072D3E1EAFFECB3C3ABC924](https://keys.openpgp.org/vks/v1/by-fingerprint/0310CFD404474D145072D3E1EAFFECB3C3ABC924)

(Key should be signed by the other security contacts, pushed to a keyserver like keyserver.ubuntu.com, and preferably have signatures that are reasonably well known in the Linux community.)

---

### Who is the secondary contact for security updates, etc.?

---

Name: Andrew Jorgensen
Position: Senior Principal Linux Engineer
Email address: ajorgens@ciq.com
PGP key fingerprint: 6EEF B810 8DF1 6EF5 729E C8C9 8120 157A 1402 D875
PGP key URL: https://keyserver.ubuntu.com/pks/lookup?search=8120157A1402D875&fingerprint=on&op=index

Name: Skip Grube
Position: Senior Systems Engineer
Email address: sgrube@ciq.com
PGP key fingerprint: F58E D7A0 91B6 E50D E7CA EB07 D391 F839 3BEA 6D9C
PGP key URL: https://keyserver.ubuntu.com/pks/lookup?search=Skip+Grube&fingerprint=on&op=index

(Key should be signed by the other security contacts, pushed to a keyserver like keyserver.ubuntu.com, and preferably have signatures that are reasonably well known in the Linux community.)

---

### Were these binaries created from the 16.1 shim release tar?

Please create your shim binaries starting with the 16.1 shim release tar file: [https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2)

This matches [https://github.com/rhboot/shim/releases/tag/16.1](https://github.com/rhboot/shim/releases/tag/16.1) and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum (SHA256, SHA512) with the following ones:

```
46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2
ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb  shim-16.1.tar.bz2
```

Make sure that you've verified that your build process uses that file as a source of truth (excluding external patches) and its checksum matches. You can also further validate the release by checking the PGP signature: there's [a detached signature](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2.asc)

The release is signed by the maintainer Peter Jones \- his master key has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the signing sub-key in the signature here has the fingerprint `02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key is included here for reference: [pjones.asc](https://github.com/rhboot/shim-review/blob/main/pjones.asc)

Once you're sure that the tarball you are using is correct and authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](http://./docs/) directory.

---

Yes this is the base source tarball we use to build the shim, no additional patches are applied to our builds.

---

### URL for a repo that contains the exact code which was built to result in your binary:

Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.

---

- x64: [https://github.com/ctrliq/shim-unsigned-x64](https://github.com/ctrliq/shim-unsigned-x64)  
- aa64: [https://github.com/ctrliq/shim-unsigned-aarch64](https://github.com/ctrliq/shim-unsigned-aarch64)  
- Build scripts: [https://github.com/ctrliq/ciq-shim-build](https://github.com/ctrliq/ciq-shim-build)

---

### What patches are being applied and why:

Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.

---

N/A \- no additional patches are applied to shim 16.1 source. The source tar ball is added to a rpm spec file that is built with mock. Nothing is done to the source.

---

### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See [https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522](https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522) for more details on the signing of shim without NX bit.

---

No, we do not have the NX bit set on our shim.

---

### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim\_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)

Skip this, if you're not using GRUB2.

---

We intend to use the Rocky 9 (based on RHEL 9\) GRUB2 source code unmodified, as our projects have no need for bootloader modifications. The Rocky/RHEL Grub versions (and their patches) are what we are using.

---

### Do you have fixes for all the following GRUB2 CVEs applied?

**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with *yes*.**

* 2020 July \- BootHole  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html](https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html)  
  * CVE-2020-10713  
  * CVE-2020-14308  
  * CVE-2020-14309  
  * CVE-2020-14310  
  * CVE-2020-14311  
  * CVE-2020-15705  
  * CVE-2020-15706  
  * CVE-2020-15707  
* March 2021  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html](https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html)  
  * CVE-2020-14372  
  * CVE-2020-25632  
  * CVE-2020-25647  
  * CVE-2020-27749  
  * CVE-2020-27779  
  * CVE-2021-3418 (if you are shipping the shim\_lock module)  
  * CVE-2021-20225  
  * CVE-2021-20233  
* June 2022  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html](https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html), SBAT increase to 2  
  * CVE-2021-3695  
  * CVE-2021-3696  
  * CVE-2021-3697  
  * CVE-2022-28733  
  * CVE-2022-28734  
  * CVE-2022-28735  
  * CVE-2022-28736  
  * CVE-2022-28737  
* November 2022  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html](https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html), SBAT increase to 3  
  * CVE-2022-2601  
  * CVE-2022-3775  
* October 2023 \- NTFS vulnerabilities  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html](https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html), SBAT increase to 4  
  * CVE-2023-4693  
  * CVE-2023-4692  
* February 2025  
  * Details: [https://lists.gnu.org/archive/html/grub-devel/2025-02/msg00024.html](https://lists.gnu.org/archive/html/grub-devel/2025-02/msg00024.html), SBAT increase to 5  
  * CVE-2024-45774  
  * CVE-2024-45775  
  * CVE-2024-45776  
  * CVE-2024-45777  
  * CVE-2024-45778  
  * CVE-2024-45779  
  * CVE-2024-45780  
  * CVE-2024-45781  
  * CVE-2024-45782  
  * CVE-2024-45783  
  * CVE-2025-0622  
  * CVE-2025-0624  
  * CVE-2025-0677  
  * CVE-2025-0678  
  * CVE-2025-0684  
  * CVE-2025-0685  
  * CVE-2025-0686  
  * CVE-2025-0689  
  * CVE-2025-0690  
  * CVE-2025-1118  
  * CVE-2025-1125

---

I can confirm that our grub2 builds will not be affected by any of those, as they've all been fixed in our upstream: [https://git.rockylinux.org/staging/rpms/grub2/-/blob/r9/SPECS/grub2.spec\#L609](https://git.rockylinux.org/staging/rpms/grub2/-/blob/r9/SPECS/grub2.spec#L609)

---

### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 5?

Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,5,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?

---

Our grub2 follows the upstream (Rocky linux)

```
objcopy --only-section .sbat -O binary grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,5,Free Software Foundation,grub,2.06,https//www.gnu.org/software/grub/
grub.rh,2,Red Hat,grub2,2.06-114.el9,mailto:secalert@redhat.com
grub.rocky,2,Rocky Linux,grub2,2.06-114.el9.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky,1,Rocky Linux (CIQ modified),grub2,2.06-114.el9_6_ciq.ciq.0.1,mailto:secureboot@ciq.com
```

---

### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?

### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?

If you had no previous signed shim, say so here. Otherwise a simple *yes* will do.

---

- This is the first time upgrading the shim, our previous submissions were based on 15.8, we will be submitting the hashes of our old shims.   
- Yes, The new chain of trust uses SBAT enforcement to prevent booting GRUB2 builds affected by CVEs.

---

### If your boot chain of trust includes a Linux kernel:

### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar\_ssdt\_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?

### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?

### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?

Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).

---

Yes, all of these patches are already in the Rocky/RHEL kernels we plan to base on.

We also include the Dynamic lockdown patches from Debian in our upstream LT kernel:

* [lockdown/arm64-add-kernel-config-option-to-lock-down-when.patch](https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/lockdown/arm64-add-kernel-config-option-to-lock-down-when.patch)  
* [lockdown/efi-add-an-efi\_secure\_boot-flag-to-indicate-secure-b.patch](https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/lockdown/efi-add-an-efi_secure_boot-flag-to-indicate-secure-b.patch)  
* [lockdown/efi-lock-down-the-kernel-if-booted-in-secure-boot-mo.patch](https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/lockdown/efi-lock-down-the-kernel-if-booted-in-secure-boot-mo.patch)  
* [lockdown/mtd-disable-slram-and-phram-when-locked-down.patch](https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/lockdown/mtd-disable-slram-and-phram-when-locked-down.patch)

---

### How does your signed kernel enforce lockdown when your system runs

### with Secure Boot enabled?

Hint: If it does not, we are not likely to sign your shim.

---

The kernel enforces lockdown out of the box when Secure Boot is enabled.

---

### Do you build your signed kernel with additional local patches? What do they do?

---

- Generally we'll be performing 2 sorts of modifications: Fixes and enhancements (especially security updates) to continue long-term support of a previous Rocky Linux release.  For example, further backports to the Rocky/RHEL 9.2 kernel (kernel-5.14.0-284) to keep it updated for customers, or FIPS enhancements/restrictions for those that require compliance.  
    
- Builds of recent longterm (LT) upstream kernel releases designed for installation on Rocky Linux.  Different variants are planned with compile-time configuration tweaks, especially around enhancing high performance computing (HPC) applications.

---

### Do you use an ephemeral key for signing kernel modules?

### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.

---

A temporary ephemeral key is used to sign kernel modules 

---

### If you use vendor\_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.

### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.

---

We aren't using vendor\_db functionality at this time.

---

### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor\_dbx in shim. Please describe your strategy.

This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.

---

We currently sign with a previously used (currently active) CA from our previous submissions. Any older grub2 versions are set to sbat level 3 and will not boot because of the sbat restrictions not set to level 5\.

---

### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?

A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.

---

This build is all Rocky 9.6 dependencies, using rpmbuild. To ensure reproducibility, are using Rocky 9.6 packages from a frozen vault. Using a tagged container base plus the rocky vault should ensure binaries are 100% reproducible.

Current reproducible shim build location:  [https://github.com/ctrliq/ciq-shim-build/tree/r9](https://github.com/ctrliq/ciq-shim-build/tree/r9)

---

### Which files in this repo are the logs for your build?

This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.

---

Shim Build Logs

* Main build log:  
  * shim\_rpmbuild.log \- Complete rpmbuild output from Docker container  
* Mock build logs (x64):  
  * mock-build/build.log \- Main mock build log for x86\_64  
  * mock-build/root.log \- Mock chroot creation log  
  * mock-build/state.log \- Mock state transitions  
  * mock-build/installed\_pkgs.log \- Packages installed in buildroot  
* Mock build logs (aarch64):  
  * mock-build-aa64/build.log \- Main mock build log for aarch64  
  * mock-build-aa64/root.log \- Mock chroot creation log  
  * mock-build-aa64/state.log \- Mock state transitions  
  * mock-build-aa64/installed\_pkgs.log \- Packages installed in buildroot

These logs include buildroot creation, dependency installation, patch application,   
compilation, and package creation for both x86\_64 and aarch64 architectures.

---

### What changes were made in the distro's secure boot chain since your SHIM was last signed?

For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.

---

We now sign UKI for kernels that support the feature.

---

### What is the SHA256 hash of your final shim binary?

---

* SHA256 (shimx64.efi) \= b84c025d211dd72a2cd4847d1e090286ae6cc0507b8a144c9eea56bfd8898f72
* SHA256 (shimaa64.efi) \= 1906bc52b59b09cb3c91df2654ab689c9155609a09135b2496d1dc29c820bb62

---

### How do you manage and protect the keys used in your shim?

Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.

---

We use a managed PKI solution that meets all industry standards and requirements for issuing, protecting, backing up and securing code signing certs. There is a Private Root CA and a Private Issuing CA.  The Private Issuing CA was used for issuing of the private code signing certs that are found in the SHIM.

Those issued certs are then stored on a physical HSM.  That HSM is installed within a FIPS environment.  All access to that environment is strictly controlled with physical and logical controls in place, with no outside access permitted.  The servers are in a locked environment and within a secure data center with proper physical access controls in place at that location for security purposes.

---

### Do you use EV certificates as embedded certificates in the shim?

A *yes* or *no* will do. There's no penalty for the latter.

---

No

---

### Are you embedding a CA certificate in your shim?

A *yes* or *no* will do. There's no penalty for the latter. However, if *yes*: does that certificate include the X509v3 Basic Constraints to say that it is a CA? See the [docs](http://./docs/) for more guidance about this.

---

Yes, the CIQ secureboot CA (PKI) is embedded in our Shim with proper X509v3 Basic Constraints.

---

### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim \+ all child shim binaries )?

### Please provide the exact SBAT entries for all binaries you are booting directly through shim.

Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --dump-section .sbat=/dev/stdout YOUR_EFI_BINARY` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.

---

**x64 architecture:**

```
objcopy --only-section .sbat -O binary grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,5,Free Software Foundation,grub,2.06,https//www.gnu.org/software/grub/
grub.rh,2,Red Hat,grub2,2.06-114.el9,mailto:secalert@redhat.com
grub.rocky,2,Rocky Linux,grub2,2.06-114.el9.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky,1,Rocky Linux (CIQ modified),grub2,2.06-114.el9_6_ciq.ciq.0.1,mailto:secureboot@ciq.com
```

```
objcopy --only-section .sbat -O binary fwupdx64.efi /dev/stdout
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.4,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.9.31,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux,fwupd,1.9.31,mail:security@rockylinux.org
fwupd-efi.ciq_rocky,1,Rocky Linux (CIQ modified),fwupd,1.9.31,mail:secureboot@ciq.com
```

```
objcopy --only-section .sbat -O binary shimx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq_rocky,1,Ctrl IQ Inc,shim,16.1,mail:it_security@ciq.com
```

```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
linux,1,CIQ,linux,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:secureboot@ciq.com
linux.rhel,1,Red Hat,linux,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:secalert@redhat.com
linux.rocky,1,RESF,linux,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:security@rockylinux.org
linux.ciq_rocky,1,CIQ,linux,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:secureboot@ciq.com
kernel-uki-virt.rhel,1,Red Hat,kernel-uki-virt,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:secalert@redhat.com
kernel-uki-virt.rocky,1,RESF,kernel-uki-virt,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:security@rockylinux.org
kernel-uki-virt.ciq_rocky,1,CIQ,kernel-uki-virt,5.14.0-427.42.1+14.1.el9_4_ciq.x86_64,mailto:secureboot@ciq.com
systemd,1,The systemd Developers,systemd,252,https://systemd.io/
systemd.rocky,1,Rocky Linux,systemd,252-32.el9_4.7,mailto:security@rockylinux.org
```

**aa64 architecture:**

```
objcopy --only-section .sbat -O binary grubaa64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,5,Free Software Foundation,grub,2.06,https//www.gnu.org/software/grub/
grub.rh,2,Red Hat,grub2,2.06-114.el9,mailto:secalert@redhat.com
grub.rocky,2,Rocky Linux,grub2,2.06-114.el9.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky,1,Rocky Linux (CIQ modified),grub2,2.06-114.el9_6_ciq.ciq.0.1,mailto:secureboot@ciq.com
```

```
objcopy --only-section .sbat -O binary fwupdaa64.efi /dev/stdout
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.4,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.9.31,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux,fwupd,1.9.31,mail:security@rockylinux.org
fwupd-efi.ciq_rocky,1,Rocky Linux (CIQ modified),fwupd,1.9.31,mail:secureboot@ciq.com
```

```
objcopy --only-section .sbat -O binary shimaa64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq_rocky,1,Ctrl IQ Inc,shim,16.1,mail:it_security@ciq.com
```

```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
linux,1,CIQ,linux,6.12.30-1.1.0.0.el9_clk.aarch64+64k,mailto:secureboot@ciq.com
linux.centos,1,Red Hat,linux,6.12.30-1.1.0.0.el9_clk.aarch64+64k,mailto:secalert@redhat.com
linux.ciq_rocky,1,CIQ,linux,6.12.30-1.1.0.0.el9_clk.aarch64+64k,mailto:secureboot@ciq.com
kernel-uki-virt.centos,1,Red Hat,kernel-uki-virt,6.12.30-1.1.0.0.el9_clk.aarch64+64k,mailto:secalert@redhat.com
kernel-uki-virt.ciq_rocky,1,CIQ,kernel-uki-virt,,mailto:secureboot@ciq.com
```

---

### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?

Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.

---

Rocky Linux / GRUB 2.06: 

```
all_video boot blscfg cat configfile cryptodisk echo
ext2 f2fs fat font gcry_rijndael gcry_rsa gcry_serpent
gcry_sha256 gcry_twofish gcry_whirlpool gfxmenu gfxterm
gzio halt http increment iso9660 jpeg loadenv loopback
linux lvm luks luks2 mdraid09 mdraid1x minicmd net normal
part_apple part_msdos part_gpt password_pbkdf2 pgp png
reboot regexp search search_fs_uuid search_fs_file
search_label serial sleep syslinuxcfg test tftp version
video xfs zstd
```

---

### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?

---

No

---

### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?

---

We use Rocky Linux \- GRUB 2.06-114.el9\_6\_ciq.ciq.0.1

---

### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.

Hint: The most common case here will be a firmware updater like fwupd.

---

We have successfully packaged and tested a RockyLinux version of certwrapper (formerly certmule). That is, a certmule package signed by us, but containing the Rocky Linux CA.

This seems perfect for our use-case, as the Rocky grub2 \+ fwupd upstream packages could be used as-is without the need for recompilation or re-signing. While keenly interested in kernel modifications, we don't have as much cause to update fwupd or grub2, and would prefer to use our upstream whenever feasible.

The certmule package in question (with the embedded Rocky CA) is located at: https://github.com/ctrliq/certmule-rocky

---

### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.

Skip this, if you're not using GRUB2 or systemd-boot.

---

No, Linux kernel launches are all we are interested in. 

---

### How do the launched components prevent execution of unauthenticated code?

Summarize in one or two sentences, how your secure bootchain works on higher level.

---

In the case of the kernel, both the RHEL variant and the upstream ("new") variants prevent this by default, and we do not want to change that. In the case of Grub \+ Fwupd, we will be running the same Rocky/RHEL versions unmodified, which also do not execute unauthenticated code by default.

---

### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?

---

Grub2 will only load unsigned code if the secureboot feature is turned off. Otherwise booting signed code is always enforced, same as the upstream Rocky/RHEL loaders. 

---

### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?

---

We are using our RHEL upstream variant 5.14 with minor patches (on top of the many patches from Red Hat and others). We are also building and packaging supported upstream kernels designed for use on Rocky and enterprise-Linux variants.  These include supported LT versions (6.12, 6.18), as well as the rolling latest-stable version.

I understand that these all enforce secure boot "out of the box".

---

### What contributions have you made to help us review the applications of other applicants?

The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours.

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.

---

Jason Rodriguez has contributed to the review process of other shim submissions, specifically the EL7 submissions.  
---

### Add any additional information you think we may need to validate this shim signing application.

---

N/A  
