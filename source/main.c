#include <nds.h>
#include <stdio.h>
#include <stdbool.h>

int frame = 0;

void Vblank()
{
    frame++;
}

int main(void)
{
    touchPosition touch;

    irqSet(IRQ_VBLANK, Vblank);

    consoleDemoInit();

    videoSetMode(MODE_0_2D);

    vramSetBankA(VRAM_A_MAIN_SPRITE);

    oamInit(&oamMain, SpriteMapping_1D_32, false);

    u16 *gfx = oamAllocateGfx(&oamMain, SpriteSize_16x16, SpriteColorFormat_256Color);

    for (int i = 0; i < 16 * 16 / 2; i++)
        gfx[i] = 1 | (1 << 8);

    SPRITE_PALETTE[1] = RGB15(31, 0, 0);

    printf("Hello blocksDS!\n");

    while (1) {
        swiWaitForVBlank();

        oamUpdate(&oamMain);

        scanKeys();

        int keys = keysHeld();
        if (keys & KEY_START)
            break;

        if (keys & KEY_TOUCH) {
            touchRead(&touch);

            printf("\x1b[16;0HTouch x = %04X\n", touch.px);
            printf("Touch y = %04X\n", touch.py);
        }

        oamSet(&oamMain, 0
              , touch.px, touch.py
              , 0, 0
              , SpriteSize_16x16, SpriteColorFormat_256Color
              , gfx, -1
              , false, !(keys & KEY_TOUCH), false, false, false);

        // print at using ansi escape sequence \x1b[line;columnH
        printf("\x1b[10;0HFrame = %d", frame);
    }

    return 0;
}
