ceur-make
=========

A free set of scripts to semi-automatically generate open access workshop proceedings for [CEUR-WS.org] [1], with special support for proceedings exported from [EasyChair] [2].

Features
--------

* From a special table of contents file, generate
  * [a CEUR-WS.org compliant index.html file] [3]
  * [a CEUR-WS.org compliant copyright form] [4]
  * a LaTeX table of contents that helps you generate an all-in-one PDF version of the proceedings
  * a BibTeX database to make your proceedings citable
* Optionally generate this table of contents from [EasyChair] [2] proceedings
  
Disclaimer
----------

CEUR-WS.org may revise their requirements for [index.html] [3] files, [copyright forms] [4], etc., at any time.  You are responsible for checking whether CEUR-WS.org have released new versions of these.  The ceur-make developers welcome any [bug reports] [5] related to this.

Use ceur-make at your own risk.  At the time of this writing, the documentation (both in this README file and in the sources) is not yet complete, but we will be working on this.

Prerequisites
-------------

* GNU make (any recent version should be sufficient)
* GNU bash (any recent version should be sufficient)
* [Saxon-HE 9](http://saxon.sourceforge.net/#F9.4HE) (other XSLT 2 processors might work as well, but the Makefile currently assumes Saxon)
* Optional:
  * Perl 5 (for processing EasyChair proceedings; any recent version should be sufficient)
  * TeX (for generating an all-in-one proceedings file; any recent version should be sufficient; tested with [TeX Live 2012](http://www.tug.org/texlive/))

ceur-make has not been tested on any other operating system than Linux so far; [reports] [5] from users of other systems are welcome.

How to use
----------

### Getting started ###

To get started, you need to copy the ceur-make scripts into the directory in which you would like to keep your proceedings.  You can do this by calling `./ceur-make-init path/to/your/directory` from the directory where you installed ceur-make.  Copy `Makefile.vars.template` to `Makefile.vars` and adapt the paths to point to your local installations of Saxon, etc.  (`ceur-make-init` doesn't do this automatically to prevent problems.)

### Export from EasyChair (optional) ###

When you use [EasyChair] [2] and instruct it to create an LNCS proceedings volume, ceur-make can automatically generate the XML table of contents from the EasyChair volume information.  Note that, for the purpose of ceur-make, LNCS just means that EasyChair will provide the proceedings for download in a ZIP file with a certain structure.  It doesn't mean that your proceedings will be published with Springer, nor that the papers have to be in the LNCS layout.

1. When creating a proceedings menu in EasyChair, use “9999” for the volume number (as this is currently hard-coded in ceur-make).
2. Download the final proceedings as a ZIP file and unzip it into a directory.
3. Copy the ceur-make scripts into that directory, so that they become siblings of the 9999PPPP per-paper directories, the README file, etc.
4. Generate toc.xml by `make toc.xml` and adapt it manually.
    * related issues: #1

### Generating CEUR-WS.org proceedings ###

To get started with this, you need a `toc.xml` file ([see this example](/clange/ceur-make/blob/master/toc.xml)), which you can either write manually, or have generated from an EasyChair archive (see above).  Additionally, you need to write `workshop.xml` ([see this example](/clange/ceur-make/blob/master/workshop.xml)) manually.

From these files, you can generate the following building blocks of a CEUR-WS.org proceedings volume.

* [the index.html file] [3] (via `make`, or specifically `make ceur-ws/index.html`)
* [the copyright form] [4] (via `make`, or specifically `make copyright-form.txt`)
* a LaTeX table of contents to help with generating an all-in-one PDF version of the proceedings (via `make`, or specifically `make toc.tex`)
* a BibTeX database (via `make`, or specifically `make ceur-ws/temp.bib`).  This file gets created as `ceur-ws/temp.bib` and requires manual revision.
* a ZIP archive for upload to CEUR-WS.org (via `make zip`)

License
-------

This code is licensed under [GPL version 3](/clange/ceur-make/blob/master/LICENSE) or any later version.

 [1]: http://ceur-ws.org "CEUR-WS.org"
 [2]: http://easychair.org "EasyChair"
 [3]: http://ceur-ws.org/Vol-XXX/index.html "index.html"
 [4]: http://ceur-ws.org/Non-Ex-Publication-Permission-Template.txt "copyright form"
 [5]: /clange/ceur-make/issues "issues"
