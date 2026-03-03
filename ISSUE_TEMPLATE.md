Confirm the following are included in your repo, checking each box:

 - [X] completed README.md file with the necessary information
 - [X] shim.efi to be signed
 - [X] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [X] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [X] any extra patches to shim via your own git tree or as files
 - [X] any extra patches to grub via your own git tree or as files
 - [X] build logs
 - [X] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/ctrliq/ciq-shim-build/releases/tag/ciqliq-shim-EL9-x86-aarch64-202602??`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
* SHA256 (shimx64.efi) \= dc5cd229935b21725b4e6739a9282c58fb376acb18ac8268674d28c1fecadb99
* SHA256 (shimaa64.efi) \= a33352422216df4b5f3fd47f5e1320c3c1762813baeb6430cd4aacf6c35c9357

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
- [Ctrl IQ, Inc Shim 15.7 for x64 & ia32 #339 - suspended due to 15.8 upgrade](https://github.com/rhboot/shim-review/issues/339)
- [Ctrl IQ, Inc Shim 15.8 for x64 & ia32 #336](https://github.com/rhboot/shim-review/issues/366)
- [Ctrl IQ, Inc EL7 Shim 15.8 for x64 & ia32 #430](https://github.com/rhboot/shim-review/issues/430)
- [Ctrl IQ, Inc EL9 Shim 15.8 for x64 #420](https://github.com/rhboot/shim-review/issues/420)
- [Ctrl IQ, Inc EL9 Shim 15.8 for aa64 #455](https://github.com/rhboot/shim-review/issues/455)


*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
[Contact verification confirmed by aronowski](https://github.com/rhboot/shim-review/issues/339#issuecomment-1779052456)