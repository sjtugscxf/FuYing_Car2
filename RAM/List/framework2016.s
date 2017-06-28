///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:44
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\framework2016.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\framework2016.c -D LPLD_K60
//        -lCN D:\GitHub_pository\FuYing_Car2\RAM\List\ -lB
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\framework2016.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN CCD_Init
        EXTERN Cam_Algorithm
        EXTERN Cam_B
        EXTERN Cam_B_Init
        EXTERN Cam_Init
        EXTERN HMI_Init
        EXTERN Motor_Init
        EXTERN Oled_Clear
        EXTERN Oled_Putstr
        EXTERN PID_Init
        EXTERN PIT0_Init
        EXTERN PIT1_Init
        EXTERN PIT2_Init
        EXTERN Servo_Init
        EXTERN Tacho_Init
        EXTERN UART_Init
        EXTERN car_state
        EXTERN set_car_state
        EXTERN set_oled_menu

        PUBLIC ADC0_enabled
        PUBLIC ADC1_enabled
        PUBLIC BusFault_Handler
        PUBLIC DefaultISR
        PUBLIC HardFault_Handler
        PUBLIC NMI_Handler
        PUBLIC main

// D:\GitHub_pository\FuYing_Car2\source\framework2016.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 
//    8 #include "includes.h"
//    9 
//   10 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   11 U8 ADC0_enabled = 0;
ADC0_enabled:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   12 U8 ADC1_enabled = 0;//not used
ADC1_enabled:
        DS8 1
//   13 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   14 void main (void)
//   15 {
main:
        PUSH     {R7,LR}
//   16   
//   17   // --- System Initiate ---
//   18   
//   19   __disable_irq();
        CPSID    I
//   20   
//   21   HMI_Init();
        BL       HMI_Init
//   22   PIT0_Init(PIT0_PERIOD_US);
        MOVW     R0,#+2500
        BL       PIT0_Init
//   23   PIT1_Init(PIT1_PERIOD_US);
        MOVW     R0,#+20000
        BL       PIT1_Init
//   24   PIT2_Init();
        BL       PIT2_Init
//   25   
//   26   UART_Init(115200);
        MOVS     R0,#+115200
        BL       UART_Init
//   27   
//   28   Motor_Init();
        BL       Motor_Init
//   29   Tacho_Init();
        BL       Tacho_Init
//   30   Servo_Init();
        BL       Servo_Init
//   31   PID_Init(); 
        BL       PID_Init
//   32   Cam_B_Init();//≥ı ºªØCam_B
        BL       Cam_B_Init
//   33   
//   34 #if (CAR_TYPE==0)   // Magnet and Balance
//   35   
//   36   Mag_Init();
//   37   LPLD_MMA8451_Init();
//   38   Gyro_Init();
//   39   
//   40 #elif (CAR_TYPE==1)     // CCD
//   41   
//   42   CCD_Init();
//   43   
//   44 #else               // Camera
//   45   
//   46   Cam_Init();
        BL       Cam_Init
//   47   CCD_Init();
        BL       CCD_Init
//   48 #endif
//   49   
//   50   //---  Press Key 1 to Continue ---
//   51   Oled_Putstr(6,1,"Press Key1 to go on");
        LDR.N    R2,??DataTable4
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       Oled_Putstr
//   52   while (Key1());
??main_0:
        LDR.N    R0,??DataTable4_1  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??main_0
//   53   Oled_Clear();
        BL       Oled_Clear
//   54 
//   55   __enable_irq();
        CPSIE    I
//   56   
//   57   // --- System Initiated ---   
//   58   while(1)
//   59   {
//   60     set_car_state();
??main_1:
        BL       set_car_state
//   61     set_oled_menu();
        BL       set_oled_menu
//   62     if(car_state!=0)
        LDR.N    R0,??DataTable4_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??main_2
//   63       Cam_B();
        BL       Cam_B
//   64     Cam_Algorithm();
??main_2:
        BL       Cam_Algorithm
        B.N      ??main_1
//   65   }
//   66 
//   67 }
//   68 
//   69 
//   70 
//   71 
//   72 // ===== System Interrupt Handler  ==== ( No Need to Edit )
//   73 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   74 void BusFault_Handler(){
BusFault_Handler:
        PUSH     {R7,LR}
//   75   Oled_Clear();
        BL       Oled_Clear
//   76   Oled_Putstr(1,5,"Bus Fault");
        LDR.N    R2,??DataTable4_3
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//   77   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_4
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//   78   while(Key1());
??BusFault_Handler_0:
        LDR.N    R0,??DataTable4_1  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??BusFault_Handler_0
//   79   
//   80   return;
        POP      {R0,PC}          ;; return
//   81 }
//   82 
//   83 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void NMI_Handler(){
NMI_Handler:
        PUSH     {R7,LR}
//   85   Oled_Clear();
        BL       Oled_Clear
//   86   Oled_Putstr(1,5,"NMI Fault");
        LDR.N    R2,??DataTable4_5
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//   87   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_4
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//   88   while(Key1());
??NMI_Handler_0:
        LDR.N    R0,??DataTable4_1  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??NMI_Handler_0
//   89   
//   90   return;
        POP      {R0,PC}          ;; return
//   91 }
//   92 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 void HardFault_Handler(void)
//   94 {
HardFault_Handler:
        PUSH     {R7,LR}
//   95   Oled_Clear();
        BL       Oled_Clear
//   96   Oled_Putstr(1,5,"Hard Fault");
        LDR.N    R2,??DataTable4_6
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//   97   Oled_Putstr(4,1,"press Key1 to goon");
        LDR.N    R2,??DataTable4_4
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       Oled_Putstr
//   98   while(Key1());
??HardFault_Handler_0:
        LDR.N    R0,??DataTable4_1  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??HardFault_Handler_0
//   99   
//  100   return;
        POP      {R0,PC}          ;; return
//  101 }
//  102 
//  103 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 void DefaultISR(void)
//  105 {
DefaultISR:
        PUSH     {R7,LR}
//  106   Oled_Clear();
        BL       Oled_Clear
//  107   Oled_Putstr(1,5,"Default ISR");
        LDR.N    R2,??DataTable4_7
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       Oled_Putstr
//  108   Oled_Putstr(4,2,"press Key1 to goon");
        LDR.N    R2,??DataTable4_4
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       Oled_Putstr
//  109   while(Key1());
??DefaultISR_0:
        LDR.N    R0,??DataTable4_1  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??DefaultISR_0
//  110 
//  111   return;
        POP      {R0,PC}          ;; return
//  112 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     car_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     ?_4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     ?_5

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
        DC8 "Press Key1 to go on"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "Bus Fault"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "press Key1 to goon"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "NMI Fault"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "Hard Fault"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC8 "Default ISR"

        END
// 
//   2 bytes in section .bss
//  88 bytes in section .rodata
// 310 bytes in section .text
// 
// 310 bytes of CODE  memory
//  88 bytes of CONST memory
//   2 bytes of DATA  memory
//
//Errors: none
//Warnings: 1
