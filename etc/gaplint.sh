#!/bin/bash
set -e

gaplint --disable W004 $@ *.g gap/* read.g init.g PackageInfo.g makedoc.g tst/testall.g tst/*.tst tst/examples/*.tst
