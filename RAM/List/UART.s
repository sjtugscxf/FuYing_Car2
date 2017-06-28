///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:50
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\UART.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\UART.c -D LPLD_K60 -lCN
//        D:\GitHub_pository\FuYing_Car2\RAM\List\ -lB
//        D:\GitHub_pository\FuYing_Car2\RAM\List\ -o
//        D:\GitHub_pository\FuYing_Car2\RAM\Obj\ --no_cse --no_unroll
//        --no_inline --no_code_motion --no_tbaa --no_clustering
//        --no_scheduling --debug --endian=little --cpu=Cortex-M4 -e --fpu=None
//        --dlib_config "C:\Program Files (x86)\IAR Systems\Embedded Workbench
//        7.0\arm\INC\c\DLib_Config_Normal.h" -I
//        D:\GitHub_pository\FuYing_Car2\..\app\ -I
//        D:\GitHub_pository\FuYing_Car2\source\ -I
//        D:\GitHub_pository\FuYing_Car2\common\ -I
//        D:\GitHub_pository\FuYing_Car2\LPLD\ -I
//        D:\GitHub_pository\FuYing_Car2\LPLD\HW\ -I
//        D:\GitHub_pository\FuYing_Car2\LPLD\DEV\ -I
//        D:\GitHub_pository\FuYing_Car2\iar_config_files\ -Ol -I "C:\Program
//        Files (x86)\IAR Systems\Embedded Workbench 7.0\arm\CMSIS\Include\" -D
//        ARM_MATH_CM4
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\UART.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN g_bus_clock
        EXTERN remote_state

        PUBLIC UART3_IRQHandler
        PUBLIC UART_GetChar
        PUBLIC UART_Init
        PUBLIC UART_SendChar
        PUBLIC UART_SendData
        PUBLIC UART_SendDataHead
        PUBLIC UART_SendString

// D:\GitHub_pository\FuYing_Car2\source\UART.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 #include "includes.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_EnableIRQ(IRQn_Type)
NVIC_EnableIRQ:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable7  ;; 0xe000e100
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+5
        STR      R1,[R2, R0, LSL #+2]
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp void NVIC_SetPriority(IRQn_Type, uint32_t)
NVIC_SetPriority:
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BPL.N    ??NVIC_SetPriority_0
        LSLS     R1,R1,#+4
        LDR.N    R2,??DataTable7_1  ;; 0xe000ed18
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        ANDS     R0,R0,#0xF
        ADDS     R0,R0,R2
        STRB     R1,[R0, #-4]
        B.N      ??NVIC_SetPriority_1
??NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.N    R2,??DataTable7_2  ;; 0xe000e400
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        STRB     R1,[R0, R2]
??NVIC_SetPriority_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// static __interwork __softfp uint32_t NVIC_EncodePriority(uint32_t, uint32_t, uint32_t)
NVIC_EncodePriority:
        PUSH     {R4}
        ANDS     R0,R0,#0x7
        RSBS     R3,R0,#+7
        CMP      R3,#+5
        BCC.N    ??NVIC_EncodePriority_0
        MOVS     R3,#+4
        B.N      ??NVIC_EncodePriority_1
??NVIC_EncodePriority_0:
        RSBS     R3,R0,#+7
??NVIC_EncodePriority_1:
        ADDS     R4,R0,#+4
        CMP      R4,#+7
        BCS.N    ??NVIC_EncodePriority_2
        MOVS     R0,#+0
        B.N      ??NVIC_EncodePriority_3
??NVIC_EncodePriority_2:
        SUBS     R0,R0,#+3
??NVIC_EncodePriority_3:
        MOVS     R4,#+1
        LSLS     R3,R4,R3
        SUBS     R3,R3,#+1
        ANDS     R1,R3,R1
        LSLS     R1,R1,R0
        MOVS     R3,#+1
        LSLS     R0,R3,R0
        SUBS     R0,R0,#+1
        ANDS     R0,R0,R2
        ORRS     R0,R0,R1
        POP      {R4}
        BX       LR               ;; return
//    8 
//    9 
//   10 
//   11 // === Receive ISR ===

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   12 void UART3_IRQHandler(void){
UART3_IRQHandler:
        PUSH     {R7,LR}
//   13    uint8 tmp = UART_GetChar();
        BL       UART_GetChar
//   14    if (tmp == 'a'){
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+97
        BNE.N    ??UART3_IRQHandler_0
//   15      remote_state = 2;
        MOVS     R0,#+2
        LDR.N    R1,??DataTable7_3
        STRB     R0,[R1, #+0]
//   16      UART_SendString("turn left");//
        LDR.N    R0,??DataTable7_4
        BL       UART_SendString
        B.N      ??UART3_IRQHandler_1
//   17    }else if (tmp == 'd'){
??UART3_IRQHandler_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+100
        BNE.N    ??UART3_IRQHandler_2
//   18      remote_state = 3;
        MOVS     R0,#+3
        LDR.N    R1,??DataTable7_3
        STRB     R0,[R1, #+0]
//   19      UART_SendString("turn right");//
        LDR.N    R0,??DataTable7_5
        BL       UART_SendString
        B.N      ??UART3_IRQHandler_1
//   20    }else if (tmp == 'w'){
??UART3_IRQHandler_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+119
        BNE.N    ??UART3_IRQHandler_3
//   21      remote_state = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable7_3
        STRB     R0,[R1, #+0]
//   22      UART_SendString("go ahead");
        LDR.N    R0,??DataTable7_6
        BL       UART_SendString
        B.N      ??UART3_IRQHandler_1
//   23    }else if (tmp == 's'){
??UART3_IRQHandler_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+115
        BNE.N    ??UART3_IRQHandler_1
//   24      remote_state = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable7_3
        STRB     R0,[R1, #+0]
//   25      UART_SendString("stop");
        LDR.N    R0,??DataTable7_7
        BL       UART_SendString
//   26    }
//   27 }
??UART3_IRQHandler_1:
        POP      {R0,PC}          ;; return
//   28 
//   29 // ======== APIs ======
//   30 
//   31 // ---- Ayano's Format ----
//   32 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void UART_SendDataHead(){
//   34   while(!(UART3->S1 & UART_S1_TDRE_MASK));
UART_SendDataHead:
??UART_SendDataHead_0:
        LDR.N    R0,??DataTable7_8  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART_SendDataHead_0
//   35   UART3->D = 127;
        MOVS     R0,#+127
        LDR.N    R1,??DataTable7_9  ;; 0x4006d007
        STRB     R0,[R1, #+0]
//   36 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   37 void UART_SendData(s16 data){
//   38   uint8 neg=0;
UART_SendData:
        MOVS     R2,#+0
//   39   uint8 num;
//   40   if(data<0){
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BPL.N    ??UART_SendData_0
//   41     neg = 1;
        MOVS     R2,#+1
//   42     data = -data;
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        RSBS     R0,R0,#+0
//   43   }
//   44   num = data%100;
??UART_SendData_0:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R1,#+100
        SDIV     R3,R0,R1
        MLS      R1,R1,R3,R0
//   45   
//   46   while(!(UART3->S1 & UART_S1_TDRE_MASK));
??UART_SendData_1:
        LDR.N    R3,??DataTable7_8  ;; 0x4006d004
        LDRB     R3,[R3, #+0]
        LSLS     R3,R3,#+24
        BPL.N    ??UART_SendData_1
//   47   UART3->D = neg?(49-data/100):(50+data/100);
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??UART_SendData_2
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R2,#+100
        SDIV     R0,R0,R2
        RSBS     R0,R0,#+49
        B.N      ??UART_SendData_3
??UART_SendData_2:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        MOVS     R2,#+100
        SDIV     R0,R0,R2
        ADDS     R0,R0,#+50
??UART_SendData_3:
        LDR.N    R2,??DataTable7_9  ;; 0x4006d007
        STRB     R0,[R2, #+0]
//   48   
//   49   while(!(UART3->S1 & UART_S1_TDRE_MASK));
??UART_SendData_4:
        LDR.N    R0,??DataTable7_8  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??UART_SendData_4
//   50   UART3->D = num;
        LDR.N    R0,??DataTable7_9  ;; 0x4006d007
        STRB     R1,[R0, #+0]
//   51 }
        BX       LR               ;; return
//   52 
//   53 // ----- Basic Functions -----
//   54 
//   55 // Read 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 int8 UART_GetChar(){
//   57   while(!(UART3->S1 & UART_S1_RDRF_MASK));
UART_GetChar:
??UART_GetChar_0:
        LDR.N    R0,??DataTable7_8  ;; 0x4006d004
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??UART_GetChar_0
//   58   return UART3->D;
        LDR.N    R0,??DataTable7_9  ;; 0x4006d007
        LDRSB    R0,[R0, #+0]
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//   59 }
//   60 
//   61 // Send

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void UART_SendChar(uint8 data){
//   63   while(!(UART3->S1 & UART_S1_TDRE_MASK));
UART_SendChar:
??UART_SendChar_0:
        LDR.N    R1,??DataTable7_8  ;; 0x4006d004
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+24
        BPL.N    ??UART_SendChar_0
//   64   UART3->D = data;
        LDR.N    R1,??DataTable7_9  ;; 0x4006d007
        STRB     R0,[R1, #+0]
//   65 }
        BX       LR               ;; return
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 void UART_SendString(const char *p) {
UART_SendString:
        PUSH     {R4,LR}
        MOVS     R4,R0
        B.N      ??UART_SendString_0
//   68   while (*p)
//   69     UART_SendChar(*p++);
??UART_SendString_1:
        LDRB     R0,[R4, #+0]
        BL       UART_SendChar
        ADDS     R4,R4,#+1
??UART_SendString_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BNE.N    ??UART_SendString_1
//   70 }
        POP      {R4,PC}          ;; return
//   71 
//   72 // Init

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   73 void UART_Init(u32 baud){
UART_Init:
        PUSH     {R4,LR}
//   74   //UART3
//   75   
//   76   uint16 sbr;
//   77   uint32 busclock = g_bus_clock;
        LDR.N    R1,??DataTable7_10
        LDR      R1,[R1, #+0]
//   78 
//   79   SIM->SCGC4 |= SIM_SCGC4_UART3_MASK;
        LDR.N    R2,??DataTable7_11  ;; 0x40048034
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,#0x2000
        LDR.N    R3,??DataTable7_11  ;; 0x40048034
        STR      R2,[R3, #+0]
//   80   
//   81   PORTE->PCR[4] = PORT_PCR_MUX(3);
        MOV      R2,#+768
        LDR.N    R3,??DataTable7_12  ;; 0x4004d010
        STR      R2,[R3, #+0]
//   82   PORTE->PCR[5] = PORT_PCR_MUX(3);
        MOV      R2,#+768
        LDR.N    R3,??DataTable7_13  ;; 0x4004d014
        STR      R2,[R3, #+0]
//   83   UART3->C2 &= ~(UART_C2_TE_MASK | UART_C2_RE_MASK );  // DISABLE UART FIRST
        LDR.N    R2,??DataTable7_14  ;; 0x4006d003
        LDRB     R2,[R2, #+0]
        ANDS     R2,R2,#0xF3
        LDR.N    R3,??DataTable7_14  ;; 0x4006d003
        STRB     R2,[R3, #+0]
//   84   UART3->C1 = 0;  // NONE PARITY CHECK
        MOVS     R2,#+0
        LDR.N    R3,??DataTable7_15  ;; 0x4006d002
        STRB     R2,[R3, #+0]
//   85   
//   86   //UART baud rate = UART module clock / (16 ¡Á (SBR[12:0] + BRFD))
//   87   // BRFD = BRFA/32; fraction
//   88   sbr = (uint16)(busclock/(16*baud));
        LSLS     R2,R0,#+4
        UDIV     R2,R1,R2
//   89   UART3->BDH = (UART3->BDH & 0XC0)|(uint8)((sbr & 0X1F00)>>8);
        LDR.N    R3,??DataTable7_16  ;; 0x4006d000
        LDRB     R3,[R3, #+0]
        ANDS     R3,R3,#0xC0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ASRS     R4,R2,#+8
        ANDS     R4,R4,#0x1F
        ORRS     R3,R4,R3
        LDR.N    R4,??DataTable7_16  ;; 0x4006d000
        STRB     R3,[R4, #+0]
//   90   UART3->BDL = (uint8)(sbr & 0XFF);
        LDR.N    R3,??DataTable7_17  ;; 0x4006d001
        STRB     R2,[R3, #+0]
//   91   
//   92   UART3->C4 = (UART3->C4 & 0XE0)|(uint8)((32*busclock)/(16*baud)-sbr*32); 
        LDR.N    R3,??DataTable7_18  ;; 0x4006d00a
        LDRB     R3,[R3, #+0]
        ANDS     R3,R3,#0xE0
        LSLS     R1,R1,#+5
        LSLS     R0,R0,#+4
        UDIV     R0,R1,R0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSLS     R1,R2,#+5
        SUBS     R0,R0,R1
        ORRS     R0,R0,R3
        LDR.N    R1,??DataTable7_18  ;; 0x4006d00a
        STRB     R0,[R1, #+0]
//   93 
//   94   UART3->C2 |=  UART_C2_RIE_MASK;
        LDR.N    R0,??DataTable7_14  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable7_14  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   95   
//   96   UART3->C2 |= UART_C2_RE_MASK;
        LDR.N    R0,??DataTable7_14  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable7_14  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   97   
//   98   UART3->C2 |= UART_C2_TE_MASK; 
        LDR.N    R0,??DataTable7_14  ;; 0x4006d003
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable7_14  ;; 0x4006d003
        STRB     R0,[R1, #+0]
//   99   
//  100   NVIC_EnableIRQ(UART3_RX_TX_IRQn); 
        MOVS     R0,#+51
        BL       NVIC_EnableIRQ
//  101   NVIC_SetPriority(UART3_RX_TX_IRQn, NVIC_EncodePriority(NVIC_GROUP, 2, 2));
        MOVS     R2,#+2
        MOVS     R1,#+2
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+51
        BL       NVIC_SetPriority
//  102 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_3:
        DC32     remote_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_5:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_6:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_7:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_8:
        DC32     0x4006d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_9:
        DC32     0x4006d007

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_10:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_11:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_12:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_13:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_14:
        DC32     0x4006d003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_15:
        DC32     0x4006d002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_16:
        DC32     0x4006d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_17:
        DC32     0x4006d001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_18:
        DC32     0x4006d00a

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_0:
        DATA
        DC8 "turn left"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "turn right"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "go ahead"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "stop"
        DC8 0, 0, 0

        END
// 
//  44 bytes in section .rodata
// 604 bytes in section .text
// 
// 604 bytes of CODE  memory
//  44 bytes of CONST memory
//
//Errors: none
//Warnings: none
