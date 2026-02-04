This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

As of 20 October 2025, shims sent to Microsoft will be signed with the 2011 and 2023 keys. For each shim you submit, you will receive two copies back, each signed by a different key. Here is the latest information from Microsoft: https://techcommunity.microsoft.com/blog/hardware-dev-center/signing-with-the-new-2023-microsoft-uefi-certificates-what-submitters-need-to-kn/4455787

New signing requirements have also taken effect, and are available here: https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916 Please note that undergoing this shim review exempts you from yearly security audits, as long as your shim only hands off to open source boot loaders.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
<!--SHIM:ORG_NAME-->CIQ Inc.<!--/SHIM-->  ( <!--SHIM:ORG_WEBSITE-->https://ciq.com<!--/SHIM--> )

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:
(a link to the organization entry in your jurisdiction's register will do)

<!--SHIM:ORG_LEGAL_INFO-->[TODO: ORG_LEGAL_INFO - Company/tax register information needs manual completion]<!--/SHIM-->

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

<!--SHIM:EV_CERT_DETAILS-->[TODO: EV_CERT_DETAILS - EV certificate details need manual completion]<!--/SHIM-->

*******************************************************************************
### What product or service is this for?
*******************************************************************************
<!--SHIM:PRODUCT_DESCRIPTION-->CIQ provides enhancements to, and customizations around Rocky Linux for our customers.  We are especially interested in customized/improved Linux kernel builds, along with packaging and improving the out-of-tree driver experience.<!--/SHIM-->

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
<!--SHIM:JUSTIFICATION-->We need these customized kernels to boot properly on stock hardware.  This is not possible with the default Rocky Linux (or RHEL) shim binary.<!--/SHIM-->

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
<!--SHIM:WHY_NOT_REUSE-->We need these customized kernels to boot properly on stock hardware.  This is not possible with the default Rocky Linux (or RHEL) shim binary.<!--/SHIM-->

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: <!--SHIM:PRIMARY_NAME-->Jason Rodriguez<!--/SHIM-->
- Position: <!--SHIM:PRIMARY_POSITION-->Sr Principal Software Engineer<!--/SHIM-->
- Email address: <!--SHIM:PRIMARY_EMAIL-->jrodriguez@ciq.com<!--/SHIM-->
- PGP key fingerprint: <!--SHIM:PRIMARY_PGP-->0310 CFD4 0447 4D14 5072 D3E1 EAFF ECB3 C3AB C924<!--/SHIM-->
- PGP key URL: <!--SHIM:PRIMARY_PGP_URL-->https://keys.openpgp.org/vks/v1/by-fingerprint/0310CFD404474D145072D3E1EAFFECB3C3ABC924<!--/SHIM-->

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: <!--SHIM:SECONDARY_NAME-->Michael Young<!--/SHIM-->
- Position: <!--SHIM:SECONDARY_POSITION-->Principal Systems Engineer<!--/SHIM-->
- Email address: <!--SHIM:SECONDARY_EMAIL-->myoung@ciq.com<!--/SHIM-->
- PGP key fingerprint: <!--SHIM:SECONDARY_PGP-->CD82 9808 7BCA C022 B5EC  84FA D84A 6A59 1392 6D2B<!--/SHIM-->
- PGP key URL: <!--SHIM:SECONDARY_PGP_URL-->http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xcd8298087bcac022b5ec84fad84a6a5913926d2b<!--/SHIM-->

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 16.1 shim release tar?
Please create your shim binaries starting with the 16.1 shim release tar file: https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.1 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum
(SHA256, SHA512) with the following ones:

```
46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2
ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb  shim-16.1.tar.bz2
```

Make sure that you've verified that your build process uses that file
as a source of truth (excluding external patches) and its checksum
matches. You can also further validate the release by checking the PGP
signature: there's [a detached
signature](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2.asc)

The release is signed by the maintainer Peter Jones - his master key
has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the
signing sub-key in the signature here has the fingerprint
`02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key
is included here for reference:
[pjones.asc](https://github.com/rhboot/shim-review/blob/main/pjones.asc)

Once you're sure that the tarball you are using is correct and
authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
Yes, no other patches are applied.

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
- x64: <!--SHIM:REPO_X64-->https://github.com/ctrliq/shim-unsigned-x64<!--/SHIM-->
- ia32: <!--SHIM:REPO_IA32-->https://github.com/ctrliq/shim-unsigned-x64"  # ia32 built from same x64 repo<!--/SHIM-->
- aa64: <!--SHIM:REPO_AA64-->https://github.com/ctrliq/shim-unsigned-aarch64<!--/SHIM-->
- Build scripts: <!--SHIM:BUILD_REPO_URL-->https://github.com/ctrliq/ciq-shim-build<!--/SHIM-->

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************
N/A - no patches applied to shim <!--SHIM:SHIM_VERSION-->16.1<!--/SHIM--> source.

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
No, we do not have the NX bit set on our shim.

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
We intend to use the Rocky <!--SHIM:EL_VERSION-->8<!--/SHIM--> (based on RHEL <!--SHIM:EL_VERSION-->8<!--/SHIM-->) GRUB2 source code unmodified, as our projects have no need for bootloader modifications. The Rocky/RHEL Grub versions (and their patches) are what we are using.

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
<!--SHIM:GRUB2_CVE_STATUS-->I can confirm that our grub2 builds will not be affected by any of those, as they've all been fixed in our upstream:

https://git.rockylinux.org/staging/rpms/grub2/-/blob/r9/SPECS/grub2.spec#L536
<!--/SHIM-->

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:
`grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
Our grub2 follows our upstream (Rocky linux), Rocky has not updated grub and is still on generation level 3

<!--SHIM:SBAT_GRUB_X64-->
```
objcopy --only-section .sbat -O binary grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-169.el8_10,mailto:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-169.el8_10.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ build),grub2,2.02-169.el8.ciq.0.1,mailto:secureboot@ciq.com
```
<!--/SHIM-->

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
<!--SHIM:OLD_SHIM_HASHES_STATUS-->Yes. Old shim hashes from previous submissions were provided to Microsoft for DBX updates. Previous CIQ submissions include:

- [Issue #366](https://github.com/rhboot/shim-review/issues/366): Ctrl IQ, Inc Shim 15.8 for x64 & ia32
- [Issue #420](https://github.com/rhboot/shim-review/issues/420): Ctrl IQ, Inc EL9 Shim 15.8 for x64
- [Issue #430](https://github.com/rhboot/shim-review/issues/430): Ctrl IQ, Inc EL7 Shim 15.8 for x64 & ia32
- [Issue #455](https://github.com/rhboot/shim-review/issues/455): Ctrl IQ, Inc EL9 Shim 15.8 for aa64

The new chain of trust uses SBAT enforcement to prevent booting GRUB2 builds affected by CVEs.<!--/SHIM-->

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
Yes, all of these patches are already in the Rocky/RHEL kernels we plan to base on.

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs
### with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
The kernel enforces lockdown out of the box when Secure Boot is enabled.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
<!--SHIM:KERNEL_LOCAL_PATCHES-->Generally we'll be performing 2 sorts of mofifications:

- Fixes and enhancements (especially security updates) to continue long-term support of a previous Rocky Linux release.  For example, further backports to the Rocky/RHEL 9.2 kernel (kernel-5.14.0-284) to keep it updated for customers, or FIPS enhancements/restrictions for those that require compliance.

- Builds of recent mainline (ML) and longterm (LT) upstream kernel releases designed for installation on Rocky Linux.  Different variants are planned with compile-time configuration tweaks, especially around enhancing high performance computing (HPC) applications.
<!--/SHIM-->

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
<!--SHIM:EPHEMERAL_KEY-->A temporary ephemeral key is used to sign kernel modules<!--/SHIM-->

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We aren't using vendor_db functionality at this time.

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
<!--SHIM:CA_REUSE_STRATEGY-->We are using a previously used (currently active) CA from our past Rocky Linux 8-based submission.

There are no built GRUB2 binaries exposed to the listed CVEs that we have released, as our previous submission was relatively recent.<!--/SHIM-->

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
<!--SHIM:BUILD_REPRODUCIBILITY-->This build is all Rocky 9.2 dependencies, using rpmbuild.

To ensure reproducibility, are using Rocky 9.2 packages from a frozen vault.
Using a tagged container base plus the rocky vault should ensure binaries are 100% reproducible.

Current reproducible shim build location:  https://github.com/ctrliq/ciq-shim-build/tree/r9
<!--/SHIM-->

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?
Include where to find it, etc. We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
*******************************************************************************
<!--SHIM:BUILD_ENVIRONMENT_DESC-->This build is all Rocky 9.2 dependencies, using rpmbuild.

To ensure reproducibility, are using Rocky 9.2 packages from a frozen vault.
Using a tagged container base plus the rocky vault should ensure binaries are 100% reproducible.

Current reproducible shim build location:  https://github.com/ctrliq/ciq-shim-build/tree/r9
<!--/SHIM-->

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
<!--SHIM:BUILD_LOG_FILENAME-->[TODO: BUILD_LOG_FILENAME - Build log filename needs manual completion]<!--/SHIM--> contains a log of the docker build run. This includes dependency install, compilation, hash comparison, etc.

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
<!--SHIM:CHANGES_SINCE_LAST_SIGNING-->Nothing has changed since our el9 https://github.com/rhboot/shim-review/issues/339 submission<!--/SHIM-->

*******************************************************************************
### Shim Version Information
*******************************************************************************
**Shim Version:** <!--SHIM:SHIM_VERSION-->16.1<!--/SHIM-->
**SBAT Generation:** <!--SHIM:SBAT_GENERATION-->4<!--/SHIM-->

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
* SHA256 (shimx64.efi) = <!--SHIM:BINARY_HASH_SHIM_X64-->dab09cec9d9a7cf7bec88749d32fbe021978e35cfaa0a382483c55e6527e7c89<!--/SHIM-->
* SHA256 (shimia32.efi) = <!--SHIM:BINARY_HASH_SHIM_IA32-->5d5a8ffd715a9a295967f078bf824cfe455b8c9dda390ff340e3f8e4de0f9091<!--/SHIM-->
* SHA256 (shimaa64.efi) = <!--SHIM:BINARY_HASH_SHIM_AA64-->b4df771ca898296102915ea76b21be590519c015f39929d95173c34cfc160f6a<!--/SHIM-->

**Certificate Information:**
- SHA256 Fingerprint: <!--SHIM:CERT_FINGERPRINT-->8F:B3:73:2A:87:CB:F7:35:BB:E3:19:A3:90:E0:DD:A3:8C:1D:DC:2F:35:B7:40:42:45:89:DA:A9:4D:7C:49:10<!--/SHIM-->
- Valid From: <!--SHIM:CERT_VALID_FROM-->Apr 21 15:09:30 2023 GMT<!--/SHIM-->
- Valid Until: <!--SHIM:CERT_VALID_UNTIL-->Apr 20 23:59:59 2048 GMT<!--/SHIM-->

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
<!--SHIM:KEY_MANAGEMENT-->We use a managed PKI solution that meets all industry standards and requirements for issuing, protecting, backing up and securing code signing certs.

There is a Private Root CA and a Private Issuing CA.  The Private Issuing CA was used for issuing of the private code signing certs that are found in the SHIM.

Those issued certs are then stored on a physical HSM.  That HSM is installed within a FIPS environment.  All access to that environment is strictly controlled with physical and logical controls in place, with no outside access permitted.  The servers are in a locked environment and within a secure data center with proper physical access controls in place at that location for security purposes.<!--/SHIM-->

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
<!--SHIM:EV_CERTIFICATE-->No, only the CIQ secureboot CA (PKI) is embedded in our Shim<!--/SHIM-->

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
Yes, the CIQ secureboot CA (PKI) is embedded in our Shim with proper X509v3 Basic Constraints.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --only-section .sbat -O binary YOUR_EFI_BINARY /dev/stdout` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************

**x64 architecture:**
<!--SHIM:SBAT_GRUB_X64-->
```
objcopy --only-section .sbat -O binary grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-169.el8_10,mailto:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-169.el8_10.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ build),grub2,2.02-169.el8.ciq.0.1,mailto:secureboot@ciq.com
```
<!--/SHIM-->

<!--SHIM:SBAT_FWUPD_X64-->
```
objcopy --only-section .sbat -O binary fwupdx64.efi /dev/stdout
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.3,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.7.8,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux (CIQ modified),fwupd,1.7.8,mail:secureboot@ciq.co
```
<!--/SHIM-->

<!--SHIM:SBAT_SHIM_X64-->
```
objcopy --only-section .sbat -O binary shimx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq,3,Ctrl IQ Inc,shim,16.1,mail:it_security@ciq.com
```
<!--/SHIM-->

**ia32 architecture:**
<!--SHIM:SBAT_GRUB_IA32-->
```
objcopy --only-section .sbat -O binary grubia32.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-169.el8_10,mailto:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-169.el8_10.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ build),grub2,2.02-169.el8.ciq.0.1,mailto:secureboot@ciq.com
```
<!--/SHIM-->

<!--SHIM:SBAT_FWUPD_IA32-->
```
objcopy --only-section .sbat -O binary fwupdia32.efi /dev/stdout
N/A - fwupd does not support 32-bit architectures
```
<!--/SHIM-->

<!--SHIM:SBAT_SHIM_IA32-->
```
objcopy --only-section .sbat -O binary shimia32.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq,3,Ctrl IQ Inc,shim,16.1,mail:it_security@ciq.com
```
<!--/SHIM-->

**aa64 architecture:**
<!--SHIM:SBAT_GRUB_AA64-->
```
objcopy --only-section .sbat -O binary grubaa64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-169.el8_10,mailto:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-169.el8_10.rocky.0.1,mailto:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ build),grub2,2.02-169.el8.ciq.0.1,mailto:secureboot@ciq.com
```
<!--/SHIM-->

<!--SHIM:SBAT_FWUPD_AA64-->
```
objcopy --only-section .sbat -O binary fwupdaa64.efi /dev/stdout
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.3,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.7.8,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux (CIQ modified),fwupd,1.7.8,mail:secureboot@ciq.co
```
<!--/SHIM-->

<!--SHIM:SBAT_SHIM_AA64-->
```
objcopy --only-section .sbat -O binary shimaa64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq,3,Ctrl IQ Inc,shim,16.1,mail:it_security@ciq.com
```
<!--/SHIM-->

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
<!--SHIM:GRUB_UPSTREAM-->Rocky Linux<!--/SHIM--> / GRUB <!--SHIM:GRUB2_BASE_VERSION-->2.02<!--/SHIM-->:
<!--SHIM:GRUB2_MODULES-->
```
all_video at_keyboard backtrace blscfg boot cat chain configfile connectefi cryptodisk echo efifwsetup efinet efi_netfs ext2 fat font gcry_rijndael gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool gfxmenu gfxterm gzio halt http increment iso9660 jpeg keylayouts linux loadenv loopback lsefi lsefimmap luks lvm mdraid09 mdraid1x minicmd net normal part_apple part_gpt part_msdos password_pbkdf2 png reboot regexp search search_fs_file search_fs_uuid search_label serial sleep syslinuxcfg test tftp usb usbserial_common usbserial_ftdi usbserial_pl2303 usbserial_usbdebug video xfs
```
<!--/SHIM-->

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
Currently, we are not providing signed systemd-boot.

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
We use <!--SHIM:GRUB_UPSTREAM-->Rocky Linux<!--/SHIM--> - GRUB <!--SHIM:GRUB2_VERSION-->2.02-169.el8.ciq.0.1<!--/SHIM-->

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************
<!--SHIM:LAUNCHED_COMPONENTS-->This build is all Rocky 9.2 dependencies, using rpmbuild.

To ensure reproducibility, are using Rocky 9.2 packages from a frozen vault.
Using a tagged container base plus the rocky vault should ensure binaries are 100% reproducible.

Current reproducible shim build location:  https://github.com/ctrliq/ciq-shim-build/tree/r9
<!--/SHIM-->

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
<!--SHIM:GRUB_LAUNCHES-->No, Linux kernel launches are all we are interested in.<!--/SHIM-->

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
<!--SHIM:PREVENT_UNAUTH-->In the case of the kernel, both the RHEL variant and the upstream ("new") variants prevent this by default, and we do not want to change that.

In the case of Grub + Fwupd, we will be running the same Rocky/RHEL versions unmodified, which also do not execute unauthenticated code by default.<!--/SHIM-->

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
<!--SHIM:LOAD_UNSIGNED-->Grub2 will only load unsigned code if the secureboot feature is turned off.  Otherwise booting signed code is always enforced, same as the upstream Rocky/RHEL loaders.<!--/SHIM-->

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************
<!--SHIM:KERNEL_DESCRIPTION-->We are using our RHEL upstream variant 5.14 with minor patches (on top of the many patches from Red Hat and others).

We are also building and packaging supported upstream kernels designed for use on Rocky and enterprise-Linux variants.  These include supported LT versions (5.4, 5.10, 5.15, 6.1), as well as the rolling latest-stable version.

I understand that these all enforce secure boot "out of the box".<!--/SHIM-->

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours.

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
<!--SHIM:CONTRIBUTIONS-->Nothing has changed since our el9 https://github.com/rhboot/shim-review/issues/339 submission<!--/SHIM-->

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
N/A
