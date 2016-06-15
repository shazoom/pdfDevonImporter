# pdfDevonImporter

Uses Keyboard Maestro to watch a directory; new files will cause a dialogue to popup to edit its metadata; the file is renamed and imported into a specified DEVONthink DB and group.

Installation is a bit tricky; think of this a being held together by sticky tape, tooth paste and bogies 😉a It has two dependencies:

1. MacVim
2. PDFtk

Installing MacVim is easy; it's on Homebrew and Macports. If you download the package, make sure you install the optional command line executable **mvim**. It is referred to in the macro at ```/usr/local/bin/mvim```.

The version of PDFtk needed is the *PDFtk-server*. However, the version on the website is broken; luckily it was fixed a few months ago but the website hasn't been update yet 🙁 Instead, you can find a working version in an answer they gabe to a question posted on [StackOverflow](http://stackoverflow.com/questions/32505951/pdftk-server-on-os-x-10-11). The link the posted is [here](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg).


## The gory details 😈

This macro watches a directory and when files are dropped in it does some stuff, asks the user to do some stuff and stuffs it in DevonThink. It uses PDFtk4 to read and write basic metadata to the PDF; so you will need to install it if you want to use this macro. I had problems reading with Finder (it didn't read the metadata for newly created files quickly enough.)

It works something like this:

1. Check the file has a .pdf extension
2. Use PDFtk to dump it's metadata
3. Parse the file's infoKey/infoValues into a KM variable
4. Popup a dialog in which they can be edited (or added.)
5. Optionally, and by default, start a non-forking MacVim to make more significant edits
6. Write the metadata update to the file with PDFtk
7. Re-parse the metadata and check that, at least, the title metadata was set
8. Rename the file to the set title
9. Add it to a specified DevonThink database and group
