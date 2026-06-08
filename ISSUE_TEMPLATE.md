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
`https://github.com/ctrliq/ciq-shim-build/releases/tag/ciq-shim-EL9-x86-aarch64-20260608`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************

* SHA256 (shimx64.efi) \= 57bb81f83825be1a21693cef657a7f33c860e80aa4ac5a9f68ea6b56991eccd0
* SHA256 (shimaa64.efi) \= 61efe8d165cd838598eaf8d369d7528adc09e91d22aa40660f323eee56378eb4

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
- [Ctrl IQ, Inc Shim 15.7 for x64 & ia32 #339 - suspended due to 15.8 upgrade](https://github.com/rhboot/shim-review/issues/339)
- [Ctrl IQ, Inc Shim 15.8 for x64 & ia32 #336](https://github.com/rhboot/shim-review/issues/366)
- [Ctrl IQ, Inc EL7 Shim 15.8 for x64 & ia32 #430](https://github.com/rhboot/shim-review/issues/430)
- [Ctrl IQ, Inc EL9 Shim 15.8 for x64 #420](https://github.com/rhboot/shim-review/issues/420)
- [Ctrl IQ, Inc EL9 Shim 15.8 for aa64 #455](https://github.com/rhboot/shim-review/issues/455)
- [Ctrl IQ, Inc EL7 Shim 16.1 for x64 & ia32 #530](https://github.com/rhboot/shim-review/issues/521)
- [Ctrl IQ, Inc Shim 16.1 for x64 & aa64 #521](https://github.com/rhboot/shim-review/issues/530)

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
[Contact verification confirmed](https://github.com/rhboot/shim-review/issues/530#event-24953174831)
