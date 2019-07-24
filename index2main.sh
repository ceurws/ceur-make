#!/bin/bash
# 
# Part of ceur-make (https://github.com/ceurws/ceur-make/)
#
# © Christoph Lange and contributors 2019–
# 
# Licensed under GPLv3 or any later version

# https://stackoverflow.com/a/697552
SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

tidy -asxhtml --preserve-entities no --output-encoding utf8 -w 0 $1 \
| xsltproc --nonet $SELF_PATH/index2main.xsl -
