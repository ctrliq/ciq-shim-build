This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
CIQ Inc.  ( https://ciq.com )

*******************************************************************************
### What product or service is this for?
*******************************************************************************
CIQ provides enhancements to, and customizations around Rocky Linux for our customers.  We are especially interested in customized/improved Linux kernel builds, along with packaging and improving the out-of-tree driver experience.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
Our customers use a variety of hardware platforms.  Many of them have policies in place, or are contractually obligated in some way to use the default EFI firmware with no customized secureboot/MOK key injection.  At the same time, many customers require some modification from the stock Rocky / RHEL kernel, mostly around the area of security backports (supporting older minor versions), or customized options for their workload.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
We need these customized kernels to boot properly on stock hardware.  This is not possible with the default Rocky Linux (or RHEL) shim binary.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Jason Rodriguez
- Position: Engineer
- Email address: jrodriguez@ciq.com
- PGP key fingerprint: 0310 CFD4 0447 4D14 5072 D3E1 EAFF ECB3 C3AB C924
- PGP key available on keys.openpgp.org
- https://keys.openpgp.org/vks/v1/by-fingerprint/0310CFD404474D145072D3E1EAFFECB3C3ABC924

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Michael Young
- Position: Information Technology Director
- Email address: myoung@ciq.com
- PGP key fingerprint:  CD82 9808 7BCA C022 B5EC  84FA D84A 6A59 1392 6D2B
- http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xcd8298087bcac022b5ec84fad84a6a5913926d2b

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.8 shim release tar?
Please create your shim binaries starting with the 15.8 shim release tar file: https://github.com/rhboot/shim/releases/download/15.7/shim-15.8.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.8 and contains the appropriate gnu-efi source.

******************************************************************************
Yes. no other patches are applied


*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
CIQ shim-unsigned-x64 RPM repository:  https://bitbucket.org/ciqinc/shim-unsigned-x64/src/ciq8/

This code is a combination of:  https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2 and an RPM spec file derived from the Rocky (and in turn RHEL) one.

Additionally, I have a "frozen" repository copy of the Mock buildroot and build dependencies (gcc, openssl, et al.) here:  https://rl-secure-boot.ewr1.vultrobjects.com/repos/shim_review_deps/  (this gets used by Mock as a source of RPM dependencies)

Using this repository (consisting of public Rocky Linux 8 packages) ensures a reproducible binary when building the shim-unsigned-x64 with mock (or Docker/Podman) and rpmbuild.



*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
N/a



*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
We intend to use the Rocky 8 + 9 (based on RHEL 8 + 9) GRUB2 source code unmodified, as our projects have no need for bootloader modifications.  The Rocky/RHEL Grub versions (and their patches) are what we are using.


*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of GRUB2 affected by any of the CVEs in the July 2020, the March 2021, the June 7th 2022, the November 15th 2022, or 3rd of October 2023 GRUB2 CVE list, have fixes for all these CVEs been applied?

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
We are a new vendor, and this is our first submission.  But I can confirm that our grub2 builds will not be affected by any of those, as they've all been fixed in our upstream:

https://git.rockylinux.org/staging/rpms/grub2/-/blob/r9/SPECS/grub2.spec#L536

https://git.rockylinux.org/staging/rpms/grub2/-/blob/r8/SPECS/grub2.spec#L511


*******************************************************************************
### If these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
The entry should look similar to: `grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`
*******************************************************************************
Yes, the global SBAT generation on our GRUB binary has been set to 4

```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-148.el8_8.1,mail:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-148.el8_8.1.rocky.0.3,mail:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ modified),grub2,2.02-148.el8.1.ciq.0.3,mail:secureboot@ciq.com
```

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
This is our first submission, we have no older shims.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
Yes, all of these patches are already in the Rocky/RHEL 8 + 9 kernels we plan to base on.


*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
Generally we'll be performing 2 sorts of mofifications:

- Fixes and enhancements (especially security updates) to continue long-term support of a previous Rocky Linux release.  For example, further backports to the Rocky/RHEL 8.6 kernel (kernel-4.18.0-372) to keep it updated for customers, or FIPS enhancements/restrictions for those that require compliance.

- Builds of recent mainline (ML) and longterm (LT) upstream kernel releases designed for installation on Rocky Linux.  Different variants are planned with compile-time configuration tweaks, especially around enhancing high performance computing (HPC) applications.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
A temporary ephemral key is used to sign kernel modules


*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We aren't using vendor_db functionality at this time.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
Our CA and shim are new.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
This build is all Rocky 8.8 dependencies, using rpmbuild.

To ensure reproducibility, I have "frozen" all the dependent Rocky 8 packages needed and put them in their own repository.  It can be found in the builder's Dockerfile.

Using a tagged container base plus this repository should ensure binaries are 100% reproducible.

Current reproducible shim build location:  https://bitbucket.org/ciqinc/ciq-shim-build


*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
shim_rpmbuild.log contains a log of the docker build run.  This includes dependency install, compilation, hash comparison, etc.

*******************************************************************************
### What changes were made since your SHIM was last signed?
*******************************************************************************
N/A

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
* SHA256 (shimx64.efi) = 654d8efe248cd113f7ecb5a1f4fc9c309cc0d65a66b4bb8d9b2991f57f2dbcf6
* SHA256 (shimia32.efi) = b739423471c03d32f2918906286076ea73c1385ced3f175a60ceeb8fadf009de

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
We use a managed PKI solution that meets all industry standards and requirements for issuing, protecting, backing up and securing code signing certs.

There is a Private Root CA and a Private Issuing CA.  The Private Issuing CA was used for issuing of the private code signing certs that are found in the SHIM.

Those issued certs are then stored on a physical HSM.  That HSM is installed within a FIPS environment.  All access to that environment is strictly controlled with physical and logical controls in place, with no outside access permitted.  The servers are in a locked environment and within a secure data center with proper physical access controls in place at that location for security purposes.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No, only the CIQ secureboot CA (PKI) is embedded in our Shim

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), please
preserve the SBAT entry from those distributions and only append your own.
More information on how SBAT works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md).
*******************************************************************************
Besides being signed with our keys, We intend to leave our grub2 and fwupd source code completely unchanged from the upstream Rocky (RHEL) versions, as we have no need to customize it beyond that.
```
objcopy --only-section .sbat -O binary grubx64.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-148.el8_8.1,mail:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-148.el8_8.1.rocky.0.3,mail:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ modified),grub2,2.02-148.el8.1.ciq.0.3,mail:secureboot@ciq.com

objcopy --only-section .sbat -O binary grubia32.efi /dev/stdout 
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rh,2,Red Hat Enterprise Linux 8,grub2,2.02-148.el8_8.1,mail:secalert@redhat.com
grub.rocky8,2,Rocky Linux 8,grub2,2.02-148.el8_8.1.rocky.0.3,mail:security@rockylinux.org
grub.ciq_rocky8,1,Rocky Linux 8 (CIQ modified),grub2,2.02-148.el8.1.ciq.0.3,mail:secureboot@ciq.com

objcopy --only-section .sbat -O binary fwupdx64.efi /dev/stdout 
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.3,https://github.com/fwupd/fwupd-efi
fwupd-efi.rhel,1,Red Hat Enterprise Linux,fwupd,1.7.8,mail:secalert@redhat.com
fwupd-efi.rocky,1,Rocky Linux,fwupd,1.7.8,mail:security@rockylinux.org

objcopy --only-section .sbat -O binary  shimx64.efi /dev/stdout 
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,3,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq,1,Ctrl IQ Inc,shim,15.8,mail:it_security@ciq.com

objcopy --only-section .sbat -O binary shimia32.efi /dev/stdout
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,3,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.ciq,1,Ctrl IQ Inc,shim,15.8,mail:it_security@ciq.com
```


*******************************************************************************
### Which modules are built into your signed GRUB2 image?
*******************************************************************************
Rocky 8 / Grub 2.02-148 :
```
efi_netfs efifwsetup efinet lsefi lsefimmap connectefi
backtrace chain usb usbserial_common usbserial_pl2303 
usbserial_ftdi usbserial_usbdebug keylayouts at_keyboard 
all_video boot blscfg
cat configfile cryptodisk echo ext2
fat font gcry_rijndael gcry_rsa gcry_serpent
gcry_sha256 gcry_twofish gcry_whirlpool
gfxmenu gfxterm gzio halt http
increment iso9660 jpeg loadenv loopback linux
lvm luks mdraid09 mdraid1x minicmd net
normal part_apple part_msdos part_gpt
password_pbkdf2 png reboot regexp search
search_fs_uuid search_fs_file search_label
serial sleep syslinuxcfg test tftp video xfs
```

Rocky 9 / Grub 2.06-61 :
```
efi_netfs efifwsetup efinet lsefi lsefimmap connectefi
backtrace chain tpm usb usbserial_common usbserial_pl2303
usbserial_ftdi usbserial_usbdebug keylayouts at_keyboard 
all_video boot blscfg
cat configfile cryptodisk
echo ext2 f2fs fat font
gcry_rijndael gcry_rsa gcry_serpent
gcry_sha256 gcry_twofish gcry_whirlpool
gfxmenu gfxterm gzio
halt http increment iso9660
jpeg loadenv loopback linux lvm luks
luks2 mdraid09 mdraid1x minicmd net
normal part_apple part_msdos part_gpt
password_pbkdf2 pgp png reboot regexp
search search_fs_uuid search_fs_file
search_label serial sleep syslinuxcfg
test tftp version video xfs zstd 
```

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or other)?
*******************************************************************************

Rocky / RHEL 8 base:
  - grub2-2.02 base version
  - grub2-2.02-148.1 (current version)
  
(We plan to track security updates from upstream when building Grub)

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
We have successfully packaged and tested a RockyLinux version of certwrapper (formerly certmule).  That is, a certmule package signed by us, but containing the Rocky Linux CA.

This seems perfect for our use-case, as the Rocky grub2 + fwupd upstream packages could be used as-is without the need for recompilation or re-signing.  While keenly interested in kernel modifications, we don't have as much cause to update fwupd or grub2, and would prefer to use our upstream whenever feasible.

I want to inquire about signing this wrapper efi and making it available to users.

The certmule package in question (with the embedded Rocky CA) is located at:  https://bitbucket.org/ciqinc/certmule-rocky/

*******************************************************************************
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
No, Linux kernel launches are all we are interested in.


*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
In the case of the kernel, both the RHEL variant and the upstream ("new") variants prevent this by default, and we do not want to change that.

In the case of Grub + Fwupd, we will be running the same Rocky/RHEL versions unmodified, which also do not execute unauthenticated code by default.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB2)?
*******************************************************************************
Grub2 will only load unsigned code if the secureboot feature is turned off  load unsigned kernels, but only with secureboot mode turned off on an end-user's system.

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
We are using our RHEL upstream variants: 4.18 and 5.14 with minor patches (on top of the many patches from Red Hat and others).

We are also building and packaging supported upstream kernels designed for use on Rocky and enterprise-Linux variants.  These include supported LT versions (5.4, 5.10, 5.15, 6.1), as well as the rollling latest-stable version.

I understand that these all enforce secure boot "out of the box".

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
No extra info, just some questions about using certwrapper/certmule to trust upstream distro components. (I like the "mule" name better ;-) )  Can't find this being used or approved in other reviews, but it's very interesting.  We're maintaining the beginnings of an RPM, and it's definitely something that should find its way into distros!




