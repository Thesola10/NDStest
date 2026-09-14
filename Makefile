
# These set the information text in the nds file
NAME := NDStest

GAME_TITLE     := Test libnds
GAME_SUBTITLE  := TheSola10
GAME_ICON      := gameicon.bmp

GFXDIRS        := graphics

include $(BLOCKSDS)/sys/default_makefiles/rom_arm9/Makefile
