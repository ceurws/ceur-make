ceur-make
=========

A set of scripts to semi-automatically generate workshop proceedings for [CEUR-WS.org] [1], with special support for proceedings exported from [EasyChair] [2].

Features
--------

* From a special table of contents file, generate
  * [a CEUR-WS.org compliant index.html file] [3]
  * [a CEUR-WS.org compliant copyright form] [4]
  * a LaTeX table of contents that helps you generate an all-in-one PDF version of the proceedings
  
Disclaimer
----------

CEUR-WS.org may revise their requirements for [index.html] [3] files, [copyright forms] [4], etc., at any time.  You are responsible for checking whether CEUR-WS.org have released new versions of these.  The ceur-make developers welcome any bug reports related to this.

Use ceur-make at your own risk.  At the time of this writing, the documentation (both in this README file and in the sources) is not yet complete, but we will be working on this.

Prerequisites
-------------

* GNU make (any recent version should be sufficient)
* GNU bash (any recent version should be sufficient)
* Perl 5 (for processing EasyChair proceedings; any recent version should be sufficient)
* [Saxon-HE 9](http://saxon.sourceforge.net/#F9.4HE) (other XSLT 2 processors might work as well, but the Makefile currently assumes Saxon)

ceur-make has not been tested on any other operating system than Linux so far; reports from users of other systems are welcome.

How to use
----------

### Export from EasyChair (optional) ###

When you use [EasyChair] [2] and instruct it to create an LNCS proceedings volume, ceur-make can automatically generate the XML table of contents from the EasyChair volume information.  Note that, for the purpose of ceur-make, LNCS just means that EasyChair will provide the proceedings for download in a ZIP file with a certain structure.  It doesn't mean that your proceedings will be published with Springer, nor that the papers have to be in the LNCS layout.

1. When creating a proceedings menu in EasyChair, use “9999” for the volume number (as this is currently hard-coded in ceur-make).
2. Download the final proceedings as a ZIP file and unzip it into a directory.
3. Copy the ceur-make scripts into that directory, so that they become siblings of the 9999PPPP per-paper directories, the README file, etc.
4. Generate toc.xml by `make toc.xml` and adapt it manually.

### Generating CEUR-WS.org proceedings ###

To get started with this, you need a `toc.xml` file ([see this example](./toc.xml)), which you can either write manually, or have generated from an EasyChair archive (see above).

TODO: further steps to be documented

License
-------

This code is licensed under [GPL version 3](./LICENSE) or any later version.

 [1]: http://ceur-ws.org "CEUR-WS.org"
 [2]: http://easychair.org "EasyChair"
 [3]: http://ceur-ws.org/Vol-XXX/index.html "index.html"
 [4]: http://ceur-ws.org/Non-Ex-Publication-Permission-Template.txt "copyright form"
