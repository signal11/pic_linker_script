
Linker Script Generator for PIC24
==================================

About
------
This is a linker script generator for PIC24. This project exists because the
linker scripts that ship with Microchip's XC16 are non-free in the
free/libre software sense of the word and can't be redistributed as open
source as part of open source projects, according to the XC16 license.

In addition to being free, this linker script generator will generate two
types of linker script: standard and bootloader.

Standard linker scripts behave similarly to the default linker scripts which
come with the XC16 compiler.

Bootloader linker scripts implement the needed functionality which make them
able to be used with the Signal 11 PIC24 Bootloader, part of the Signal 11
USB Device Stack.  With the generated bootloader linker scripts, the same
script can be used for both bootloader firmware and for application firmware
which is to be loaded by the bootloader.  To specify which mode to use
(bootloader or application), either define the BOOTLOADER or BOOTLOADER_APP
preprocessor symbol from MPLABX's Linker Symbols field (under Symbols &
Macros for the Linker (xc16-ld) in the Project Properties in MPLAB X).

Bootloader Linker Script Theory of Operation
---------------------------------------------
To implement a bootloader, a custom linker script (different than the
default linker script that comes with the compiler) must be used to instruct
the linker where to put the bootloader firmware in flash memory and which
area should be left empty for the application (which will be loaded later by
the bootloader). The application then must also be built with a custom
linker script which instructs the linker to put the application in a
different section of memory than that which the bootloader occupies.

Two other factors come into play. First, the device needs to be unbrickable
(or as close as it can possibly be made to be).  Since the bootloader is to
be run at the beginning of execution, the GOTO instruction at the bottom of
the flash memory must be under bootloader control (and not written by the
application).  Since this is in the same flash erase block as the interrupt
vector table, it makes sense to put the bootloader at the bottom of memory.

The other important factor is interrupt remapping. Since the application
will be unable to write the interrupt vectors (since that flash is part of
the bootloader's flash area), the interrupt vectors must be remapped.  To
implement this, a map is made which is in the application's flash space
(ivt_map in the generated bootloader files).  This map contains a GOTO
instruction for each implemented interrupt which jumps to the application's
interrupt handler.  The bootloader then, in each entry in the actual
interrupt vector table (ivt in the generated bootloader files), references
the appropriate entry in the interrupt map (in application space).  This
adds a small overhead to interrupt service routines (the single GOTO
instruction).

See the comments in the generated linker scripts for more information.


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
