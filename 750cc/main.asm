    DEVICE ZXSPECTRUM48

    ORG 0xe000
main
    DI
    call logo_init
test
    ei : halt : di
    call logo_draw
    jr test

    INCLUDE "logopen.asm"

    DISPLAY "750cc: code start=",main," length=",$-main
    SAVESNA "750cc.sna",main
