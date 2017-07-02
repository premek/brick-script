#!/usr/bin/env bash

lua test/parser-simple.lua &&
# uncomment when syntax is stable   lua test/parser-complex.lua &&
lua test/runtime.lua &&
echo && echo "ALL OK"

exit $?
