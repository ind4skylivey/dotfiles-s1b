#!/bin/bash
echo "openssl: $(openssl version 2>/dev/null | awk '{print $2}') | curl: $(curl --version | head -1 | awk '{print $2}') | wget: $(wget --version | head -1 | awk '{print $3}')"
