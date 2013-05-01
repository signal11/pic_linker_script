
Linker Script Generator for PIC24
==================================

About
------
This is a linker script generator for PIC24. This project exists because the
linker scripts that ship with Microchip's XC16 are non-free in the
free/libre software sense of the word and can't be redistributed as open
source as part of open source projects, according to the XC16 license.

Supported Microcontrollers
---------------------------
See gen_linker_scripts.sh for a list of the supported MCUs.

Generating
-----------
Run ./gen_linker_scripts.sh . All the generated files will go in output/ .

Adding Suport for New Microcontrollers
---------------------------------------
To add an MCU in an already supported family (currently PIC24F), all you
should need to generate is a *_mem.txt and a *_regs.txt for your micro.  For
the _mem.txt file, start with one that exists already and modify it. For the
*_regs.txt file, you'll need to make one using the datahseet for your MCU. 
Use the exact names and addresses of the registers in the datahseet in the
*_regs.txt file.  Use the full name of the MCU as the prefix to the
filenames.  Add another line to gen_linker_scripts.sh with your
microcontroller in it.  Use pic24fj64gb002_*.txt as a template if you want. 
If you add a microcontroller, please send me the files so I can put them in
the main repo.

License
--------
These files are owned by Signal 11 Software, and may be used by anyone for
any purpose.


Alan Ott
Signal 11 Software
407-222-6975
