#!/bin/bash

# Simple script to do some comparisons between fresh compiled shim binaries and pre-built ones
# (Check for binary reproducibility)

echo "
Shim Comparison, original binary vs. freshly built binaries:
"

# Compare shimx64.efi if control binary exists
if [ -f /shimx64.efi ] && [ -s /shimx64.efi ]; then
    echo "SHA256 sums ::"
    sha256sum /shimx64.efi /shim_result/usr/share/shim/*/x64/shim*.efi
    echo ""
    echo "Binary compare (blank output means binaries are the same) ::"
    cmp /shim_result/usr/share/shim/*/x64/shimx64.efi /shimx64.efi || true
    echo ""
    echo ""
    echo "Pesign checks ::"
    pesign -h -P -i /shim_result/usr/share/shim/*/x64/shimx64.efi
    pesign -h -P -i /shimx64.efi
    echo ""
fi

# Compare shimia32.efi if control binary exists (not available on EL9+)
if [ -f /shimia32.efi ] && [ -s /shimia32.efi ]; then
    echo "SHA256 sums ::"
    sha256sum /shimia32.efi /shim_result/usr/share/shim/*/ia32/shim*.efi
    echo ""
    echo "Binary compare (blank output means binaries are the same) ::"
    cmp /shim_result/usr/share/shim/*/ia32/shimia32.efi /shimia32.efi || true
    echo ""
    echo ""
    echo "Pesign checks ::"
    pesign -h -P -i /shim_result/usr/share/shim/*/ia32/shimia32.efi
    pesign -h -P -i /shimia32.efi
    echo ""
fi

# Compare shimaa64.efi if control binary exists
if [ -f /shimaa64.efi ] && [ -s /shimaa64.efi ]; then
    echo "SHA256 sums ::"
    sha256sum /shimaa64.efi /shim_result/usr/share/shim/*/aa64/shim*.efi
    echo ""
    echo "Binary compare (blank output means binaries are the same) ::"
    cmp /shim_result/usr/share/shim/*/aa64/shimaa64.efi /shimaa64.efi || true
    echo ""
    echo ""
    echo "Pesign checks ::"
    pesign -h -P -i /shim_result/usr/share/shim/*/aa64/shimaa64.efi
    pesign -h -P -i /shimaa64.efi
    echo ""
fi
