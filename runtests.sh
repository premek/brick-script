#!/usr/bin/env bash

find . -iname "*.lua" | xargs luac -p || { echo 'luac parse test failed' ; exit 1; }

lua test/parser-simple.lua &&
# uncomment when syntax is stable   lua test/parser-complex.lua &&
lua test/runtime.lua &&
echo && echo "ALL OK"

exit $?
