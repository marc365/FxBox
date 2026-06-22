# FxBox 1.22
realtime multi loop processor editor for the Amiga range of computers m68k-amigaos >= 1.3

![alt fxbox](https://github.com/marc365/FxBox/raw/master/fxbox.png)

  Imports 16bit, 24bit and 32bit floating point Aif and Wav files, and Octamed modules.

  Loads and saves Iff 8bit files, Iff CATs and AMOS sample banks.

  Can do mono, stereo, quad and 4 channel multi track.

  Render Octamed modules as waveforms.

  Record to disk and pipe over the network to a VST Host, Win32 plugin included.

  Network BPM sync and Octamed Arexx sync at the same time.
  
  Realtime effects preview and oscilloscope is available on accelerated machines.

  Requires at least 1M ram, and supports up to 2G.

  Written in AMOS BASIC and compiled with AMOS Professional 365.

![alt options](https://github.com/marc365/FxBox/raw/master/fxbox_options.png)

![alt oscilloscope](https://github.com/marc365/FxBox/raw/master/fxbox_oscilloscope.png)

# Source Code
there is an archive of .AMOS files and an .Asc file that is updated to compare the difference between each version

the build folder has a 'make' file that compiles FxBox using a custom APCmp command that looks for the AMOS.Library in the local folder, it builds the fxbox custom config and headers and the updated music extension. note: FxBox is fully compatible interpreted with a default installation of AMOS Professional nothing custom needs installing, the customizations are during the build process only.

    cd build
  
    execute make
