#!/bin/bash
#
# Auto-generate an entry for the main index at http://ceur-ws.org/index.html from a proceedings volume ToC at http://ceur-ws.org/Vol-###/index.html (frontend for index2main.xsl).
#
# To be executed (by the CEUR-WS.org editorial team) as follows:
#
# How to run:
# 1. run the script: ~/bin/index2main ~/www/Vol-###/index.html
# 2. manually copy/paste the result (between <html> and </html>) from standard output into ~/www/index.html and check it.  Note that links to previous editions still have to be created manually.
# 
# Part of ceur-make (https://github.com/ceurws/ceur-make/)
#
# © Christoph Lange and contributors 2019–
# 
# Licensed under GPLv3 or any later version

# https://stackoverflow.com/a/697552
SELF_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

# 1. obtain a clean XHTML version of the proceedings volume ToC:
tidy -quiet -asxhtml --preserve-entities no -utf8 -wrap 0 $1 | \
# 2. apply the stylesheet to the XHTML file:
xsltproc --nonet $SELF_PATH/index2main.xsl -        
