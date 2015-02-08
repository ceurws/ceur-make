#!/usr/bin/perl -wln
#
# Script to generate one <paper> element in toc.xml, out of the information in the respective VVVVPPPP/README_EASYCHAIR file
# Not to be invoked standalone, but from “make toc.xml”
#
# Part of ceur-make (https://github.com/ceurws/ceur-make/)
#
# © Christoph Lange and contributors 2012–2015
#
# Licensed under GPLv3 or any later version

BEGIN {
    $authors = -1;
    print "    <paper>";
}

print "        <pages from=\"$1\" to=\"$2\"/>" if /^Pages: (\d+)-(\d+)$/;
print "        <title>$1</title>" if /^Paper: (.*)$/;
if (/^-+$/ && $authors == -1) {
    $authors = 0;
}
if (/^$/ && $authors == 0) {
    $authors = 1;
    print "        <authors>";
}
print "            <author>$1 $2</author>" if (/^([^|]+) \| (.*)$/ && $authors == 1);
if (/^-+$/ && $authors == 1) {
        $authors = -1;
        print "        </authors>";
}

END {
    print "    </paper>";
}
