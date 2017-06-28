///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:49
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\PIT.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\PIT.c -D LPLD_K60 -lCN
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\PIT.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Battery
        EXTERN Bell_Service
        EXTERN LED1_Tog
        EXTERN MotorL_Output
        EXTERN MotorR_Output
        EXTERN Tacho0_Get
        EXTERN Tacho1_Get
        EXTERN UI_Operation_Service
        EXTERN UI_SystemInfo
        EXTERN __aeabi_cdcmple
        EXTERN __aeabi_cdrcmple
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_dmul
        EXTERN __aeabi_dsub
        EXTERN __aeabi_i2d
        EXTERN battery
        EXTERN debug_dir
        EXTERN g_bus_clock
        EXTERN tacho0
        EXTERN tacho1
        EXTERN ui_operation_cnt

        PUBLIC L
        PUBLIC L_err
        PUBLIC L_pwm
        PUBLIC PID_Init
        PUBLIC PIT0_IRQHandler
        PUBLIC PIT0_Init
        PUBLIC PIT1_IRQHandler
        PUBLIC PIT1_Init
        PUBLIC PIT2_Init
        PUBLIC PWM
        PUBLIC PWMne
        PUBLIC R
        PUBLIC R_err
        PUBLIC R_pwm
        PUBLIC pit0_time
        PUBLIC pit1_time
        PUBLIC pit1_time_tmp
        PUBLIC speed_set
        PUBLIC time_us

// D:\GitHub_pository\FuYing_Car2\source\PIT.c
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
        LDR.W    R2,??DataTable9  ;; 0xe000e100
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
        LDR.W    R2,??DataTable9_1  ;; 0xe000ed18
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        ANDS     R0,R0,#0xF
        ADDS     R0,R0,R2
        STRB     R1,[R0, #-4]
        B.N      ??NVIC_SetPriority_1
??NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable9_2  ;; 0xe000e400
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
//   10 // ========= Variables =========
//   11 
//   12 //--- global ---

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 U32 time_us = 0;
time_us:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 U32 pit0_time;
pit0_time:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 U32 pit1_time; 
pit1_time:
        DS8 4
//   16 
//   17 
//   18  
//   19 //--- local ---

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   20 U32 pit1_time_tmp;
pit1_time_tmp:
        DS8 4
//   21 
//   22 // =========== PID CONTROL =========== 

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   23 PIDInfo L, R;  //两个结构体指针，存与电机pid控制有关的量， 包括pid三个参数，lastErr
L:
        DS8 56

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
R:
        DS8 56

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   24 double L_err = 0;
L_err:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   25 double R_err = 0;
R_err:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   26 double L_pwm = 0;
L_pwm:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   27 double R_pwm = 0;
R_pwm:
        DS8 8
//   28 
//   29 
//   30 

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   31 int16 speed_set = 0;
speed_set:
        DS8 2
//   32 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 void PID_Init() 
//   34 {
//   35   L.kp = 5;
PID_Init:
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_3  ;; 0x40140000
        LDR.W    R2,??DataTable9_4
        STRD     R0,R1,[R2, #+0]
//   36   L.ki = 2;
        MOVS     R0,#+0
        MOVS     R1,#+1073741824
        LDR.W    R2,??DataTable9_4
        STRD     R0,R1,[R2, #+8]
//   37   L.kd = 0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_4
        STRD     R0,R1,[R2, #+16]
//   38   R.kp = 5;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_3  ;; 0x40140000
        LDR.W    R2,??DataTable9_5
        STRD     R0,R1,[R2, #+0]
//   39   R.ki = 2;
        MOVS     R0,#+0
        MOVS     R1,#+1073741824
        LDR.W    R2,??DataTable9_5
        STRD     R0,R1,[R2, #+8]
//   40   R.kd = 0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_5
        STRD     R0,R1,[R2, #+16]
//   41   
//   42   L.lastErr=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_4
        STRD     R0,R1,[R2, #+24]
//   43   L.errSum=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_4
        STRD     R0,R1,[R2, #+48]
//   44   R.lastErr=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_5
        STRD     R0,R1,[R2, #+24]
//   45   R.errSum=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_5
        STRD     R0,R1,[R2, #+48]
//   46 
//   47   //临时测试用：
//   48   debug_dir.kp=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_6
        STRD     R0,R1,[R2, #+0]
//   49   debug_dir.kd=0;
        MOVS     R0,#+0
        MOVS     R1,#+0
        LDR.W    R2,??DataTable9_6
        STRD     R0,R1,[R2, #+16]
//   50   
//   51 }
        BX       LR               ;; return
//   52 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   53 void PWM(u8 left_speed, u8 right_speed, PIDInfo *L, PIDInfo *R)      //前进的PID控制
//   54 {  
PWM:
        PUSH     {R4-R6,R8,R9,LR}
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//   55   L_err=left_speed-tacho0;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable9_7
        LDRSH    R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable9_8
        STRD     R0,R1,[R2, #+0]
//   56   R_err=right_speed+tacho1;
        LDR.W    R0,??DataTable9_9
        LDRSH    R0,[R0, #+0]
        UXTAB    R0,R0,R4
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable9_10
        STRD     R0,R1,[R2, #+0]
//   57   L->errSum+=L_err;
        LDRD     R2,R3,[R5, #+48]
        LDR.W    R4,??DataTable9_8
        LDRD     R0,R1,[R4, #+0]
        BL       __aeabi_dadd
        STRD     R0,R1,[R5, #+48]
//   58   if(L->errSum>300) L->errSum=300;
        LDRD     R0,R1,[R5, #+48]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_11  ;; 0x4072c000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWM_0
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_11  ;; 0x4072c000
        STRD     R0,R1,[R5, #+48]
//   59   if(L->errSum<-300) L->errSum=-300;
??PWM_0:
        LDRD     R0,R1,[R5, #+48]
        MOVS     R2,#+0
        LDR.W    R3,??DataTable9_12  ;; 0xc072c000
        BL       __aeabi_cdcmple
        BCS.N    ??PWM_1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_12  ;; 0xc072c000
        STRD     R0,R1,[R5, #+48]
//   60   R->errSum+=R_err;
??PWM_1:
        LDRD     R2,R3,[R6, #+48]
        LDR.W    R4,??DataTable9_10
        LDRD     R0,R1,[R4, #+0]
        BL       __aeabi_dadd
        STRD     R0,R1,[R6, #+48]
//   61   if(R->errSum>300) R->errSum=300;
        LDRD     R0,R1,[R6, #+48]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_11  ;; 0x4072c000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWM_2
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_11  ;; 0x4072c000
        STRD     R0,R1,[R6, #+48]
//   62   if(R->errSum<-300)R->errSum=-300;
??PWM_2:
        LDRD     R0,R1,[R6, #+48]
        MOVS     R2,#+0
        LDR.W    R3,??DataTable9_12  ;; 0xc072c000
        BL       __aeabi_cdcmple
        BCS.N    ??PWM_3
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_12  ;; 0xc072c000
        STRD     R0,R1,[R6, #+48]
//   63   L_pwm=(L_err*L->kp + L->errSum*L->ki + (L_err-L->lastErr)*L->kd);
??PWM_3:
        LDR.W    R0,??DataTable9_8
        LDRD     R2,R3,[R0, #+0]
        LDRD     R0,R1,[R5, #+0]
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R2,R3,[R5, #+48]
        LDRD     R0,R1,[R5, #+8]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R2,??DataTable9_8
        LDRD     R0,R1,[R2, #+0]
        LDRD     R2,R3,[R5, #+24]
        BL       __aeabi_dsub
        LDRD     R2,R3,[R5, #+16]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        LDR.W    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   64   R_pwm=(R_err*R->kp + R->errSum*R->ki + (R_err-R->lastErr)*R->kd);
        LDR.W    R0,??DataTable9_10
        LDRD     R2,R3,[R0, #+0]
        LDRD     R0,R1,[R6, #+0]
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R2,R3,[R6, #+48]
        LDRD     R0,R1,[R6, #+8]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R2,??DataTable9_10
        LDRD     R0,R1,[R2, #+0]
        LDRD     R2,R3,[R6, #+24]
        BL       __aeabi_dsub
        LDRD     R2,R3,[R6, #+16]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        LDR.W    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   65   L->lastErr=L_err;
        LDR.W    R0,??DataTable9_8
        LDRD     R2,R3,[R0, #+0]
        STRD     R2,R3,[R5, #+24]
//   66   R->lastErr=R_err;
        LDR.W    R0,??DataTable9_10
        LDRD     R2,R3,[R0, #+0]
        STRD     R2,R3,[R6, #+24]
//   67   
//   68   if(L_pwm>700)  L_pwm=700;
        LDR.W    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_15  ;; 0x4085e000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWM_4
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_15  ;; 0x4085e000
        LDR.W    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   69   if(R_pwm>700)  R_pwm=700;
??PWM_4:
        LDR.W    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_15  ;; 0x4085e000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWM_5
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_15  ;; 0x4085e000
        LDR.W    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   70   if(L_pwm<-700)  L_pwm=-700;
??PWM_5:
        LDR.W    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+0
        LDR.W    R3,??DataTable9_16  ;; 0xc085e000
        BL       __aeabi_cdcmple
        BCS.N    ??PWM_6
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_16  ;; 0xc085e000
        LDR.W    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   71   if(R_pwm<-700)  R_pwm=-700;
??PWM_6:
        LDR.W    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+0
        LDR.W    R3,??DataTable9_16  ;; 0xc085e000
        BL       __aeabi_cdcmple
        BCS.N    ??PWM_7
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_16  ;; 0xc085e000
        LDR.W    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   72   MotorL_Output((int)(L_pwm)); 
??PWM_7:
        LDR.W    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        BL       __aeabi_d2iz
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       MotorL_Output
//   73   MotorR_Output((int)(-R_pwm));
        LDR.W    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        EORS     R1,R1,#0x80000000
        BL       __aeabi_d2iz
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       MotorR_Output
//   74 }
        POP      {R4-R6,R8,R9,PC}  ;; return
//   75 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 void PWMne(u8 left_speed, u8 right_speed, PIDInfo *L, PIDInfo *R)   //后退的PID控制，都是输入正数，输入负数有奇怪的bug
//   77 {
PWMne:
        PUSH     {R4-R6,R8,R9,LR}
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//   78   L_err=left_speed-tacho0;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable9_7
        LDRSH    R1,[R1, #+0]
        SUBS     R0,R0,R1
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable9_8
        STRD     R0,R1,[R2, #+0]
//   79   R_err=right_speed+tacho1;
        LDR.W    R0,??DataTable9_9
        LDRSH    R0,[R0, #+0]
        UXTAB    R0,R0,R4
        BL       __aeabi_i2d
        LDR.W    R2,??DataTable9_10
        STRD     R0,R1,[R2, #+0]
//   80   L->errSum+=L_err;
        LDRD     R2,R3,[R5, #+48]
        LDR.W    R4,??DataTable9_8
        LDRD     R0,R1,[R4, #+0]
        BL       __aeabi_dadd
        STRD     R0,R1,[R5, #+48]
//   81   if(L->errSum>300) L->errSum=300;
        LDRD     R0,R1,[R5, #+48]
        MOVS     R2,#+1
        LDR.W    R3,??DataTable9_11  ;; 0x4072c000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWMne_0
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_11  ;; 0x4072c000
        STRD     R0,R1,[R5, #+48]
//   82   if(L->errSum<-300) L->errSum=-300;
??PWMne_0:
        LDRD     R0,R1,[R5, #+48]
        MOVS     R2,#+0
        LDR.W    R3,??DataTable9_12  ;; 0xc072c000
        BL       __aeabi_cdcmple
        BCS.N    ??PWMne_1
        MOVS     R0,#+0
        LDR.W    R1,??DataTable9_12  ;; 0xc072c000
        STRD     R0,R1,[R5, #+48]
//   83   R->errSum+=R_err;
??PWMne_1:
        LDRD     R2,R3,[R6, #+48]
        LDR.W    R4,??DataTable9_10
        LDRD     R0,R1,[R4, #+0]
        BL       __aeabi_dadd
        STRD     R0,R1,[R6, #+48]
//   84   if(R->errSum>300) R->errSum=300;
        LDRD     R0,R1,[R6, #+48]
        MOVS     R2,#+1
        LDR.N    R3,??DataTable9_11  ;; 0x4072c000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWMne_2
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_11  ;; 0x4072c000
        STRD     R0,R1,[R6, #+48]
//   85   if(R->errSum<-300)R->errSum=-300;
??PWMne_2:
        LDRD     R0,R1,[R6, #+48]
        MOVS     R2,#+0
        LDR.N    R3,??DataTable9_12  ;; 0xc072c000
        BL       __aeabi_cdcmple
        BCS.N    ??PWMne_3
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_12  ;; 0xc072c000
        STRD     R0,R1,[R6, #+48]
//   86   L_pwm=(L_err*L->kp + L->errSum*L->ki + (L_err-L->lastErr)*L->kd);
??PWMne_3:
        LDR.N    R0,??DataTable9_8
        LDRD     R2,R3,[R0, #+0]
        LDRD     R0,R1,[R5, #+0]
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R2,R3,[R5, #+48]
        LDRD     R0,R1,[R5, #+8]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R2,??DataTable9_8
        LDRD     R0,R1,[R2, #+0]
        LDRD     R2,R3,[R5, #+24]
        BL       __aeabi_dsub
        LDRD     R2,R3,[R5, #+16]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   87   R_pwm=(R_err*R->kp + R->errSum*R->ki + (R_err-R->lastErr)*R->kd);
        LDR.N    R0,??DataTable9_10
        LDRD     R2,R3,[R0, #+0]
        LDRD     R0,R1,[R6, #+0]
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R2,R3,[R6, #+48]
        LDRD     R0,R1,[R6, #+8]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        MOV      R8,R0
        MOV      R9,R1
        LDR.N    R2,??DataTable9_10
        LDRD     R0,R1,[R2, #+0]
        LDRD     R2,R3,[R6, #+24]
        BL       __aeabi_dsub
        LDRD     R2,R3,[R6, #+16]
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   88   L->lastErr=L_err;
        LDR.N    R0,??DataTable9_8
        LDRD     R2,R3,[R0, #+0]
        STRD     R2,R3,[R5, #+24]
//   89   R->lastErr=R_err;
        LDR.N    R0,??DataTable9_10
        LDRD     R2,R3,[R0, #+0]
        STRD     R2,R3,[R6, #+24]
//   90   
//   91   if(L_pwm>700)  L_pwm=700;
        LDR.N    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+1
        LDR.N    R3,??DataTable9_15  ;; 0x4085e000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWMne_4
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_15  ;; 0x4085e000
        LDR.N    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   92   if(R_pwm>700)  R_pwm=700;
??PWMne_4:
        LDR.N    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+1
        LDR.N    R3,??DataTable9_15  ;; 0x4085e000
        BL       __aeabi_cdrcmple
        BHI.N    ??PWMne_5
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_15  ;; 0x4085e000
        LDR.N    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   93   if(L_pwm<-700)  L_pwm=-700;
??PWMne_5:
        LDR.N    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+0
        LDR.N    R3,??DataTable9_16  ;; 0xc085e000
        BL       __aeabi_cdcmple
        BCS.N    ??PWMne_6
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_16  ;; 0xc085e000
        LDR.N    R2,??DataTable9_13
        STRD     R0,R1,[R2, #+0]
//   94   if(R_pwm<-700)  R_pwm=-700;
??PWMne_6:
        LDR.N    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        MOVS     R2,#+0
        LDR.N    R3,??DataTable9_16  ;; 0xc085e000
        BL       __aeabi_cdcmple
        BCS.N    ??PWMne_7
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_16  ;; 0xc085e000
        LDR.N    R2,??DataTable9_14
        STRD     R0,R1,[R2, #+0]
//   95   MotorL_Output((int)(L_pwm)); 
??PWMne_7:
        LDR.N    R2,??DataTable9_13
        LDRD     R0,R1,[R2, #+0]
        BL       __aeabi_d2iz
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       MotorL_Output
//   96   MotorR_Output((int)(R_pwm));
        LDR.N    R2,??DataTable9_14
        LDRD     R0,R1,[R2, #+0]
        BL       __aeabi_d2iz
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       MotorR_Output
//   97 }
        POP      {R4-R6,R8,R9,PC}  ;; return
//   98 
//   99 
//  100 
//  101 // =========== PIT 1 ISR =========== 
//  102 // ====  UI Refreshing Loop  ==== ( Low priority ) 
//  103 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  104 void PIT1_IRQHandler(){
PIT1_IRQHandler:
        PUSH     {R7,LR}
//  105   
//  106   PIT->CHANNEL[1].TFLG |= PIT_TFLG_TIF_MASK;
        LDR.N    R0,??DataTable9_17  ;; 0x4003711c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_17  ;; 0x4003711c
        STR      R0,[R1, #+0]
//  107   
//  108   pit1_time_tmp = PIT2_VAL();
        LDR.N    R0,??DataTable9_18  ;; 0x40037124
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_19
        STR      R0,[R1, #+0]
//  109   
//  110   //------------------------
//  111   
//  112   LED1_Tog();
        BL       LED1_Tog
//  113   
//  114   UI_Operation_Service();
        BL       UI_Operation_Service
//  115   
//  116   Bell_Service();
        BL       Bell_Service
//  117   
//  118   UI_SystemInfo();
        BL       UI_SystemInfo
//  119   
//  120   
//  121   //------------ Other -------------
//  122   
//  123   pit1_time_tmp = pit1_time_tmp - PIT2_VAL();
        LDR.N    R0,??DataTable9_19
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_18  ;; 0x40037124
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable9_19
        STR      R0,[R1, #+0]
//  124   pit1_time_tmp = pit1_time_tmp / (g_bus_clock/10000); //100us
        LDR.N    R0,??DataTable9_20
        LDR      R0,[R0, #+0]
        MOVW     R1,#+10000
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable9_19
        LDR      R1,[R1, #+0]
        UDIV     R0,R1,R0
        LDR.N    R1,??DataTable9_19
        STR      R0,[R1, #+0]
//  125   pit1_time = pit1_time_tmp;
        LDR.N    R0,??DataTable9_19
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_21
        STR      R0,[R1, #+0]
//  126   
//  127 }
        POP      {R0,PC}          ;; return
//  128 
//  129 
//  130 
//  131 //============ PIT 0 ISR  ==========
//  132 // ====  Control  ==== ( High priority )
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void PIT0_IRQHandler(){
PIT0_IRQHandler:
        PUSH     {R7,LR}
//  135   PIT->CHANNEL[0].TFLG |= PIT_TFLG_TIF_MASK;
        LDR.N    R0,??DataTable9_22  ;; 0x4003710c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_22  ;; 0x4003710c
        STR      R0,[R1, #+0]
//  136   
//  137   time_us += PIT0_PERIOD_US;
        LDR.N    R0,??DataTable9_23
        LDR      R0,[R0, #+0]
        ADDW     R0,R0,#+2500
        LDR.N    R1,??DataTable9_23
        STR      R0,[R1, #+0]
//  138 
//  139   
//  140   
//  141   //-------- System info -----
//  142   
//  143   pit0_time = PIT2_VAL();
        LDR.N    R0,??DataTable9_18  ;; 0x40037124
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_24
        STR      R0,[R1, #+0]
//  144     
//  145   battery = Battery();
        BL       Battery
        LDR.N    R1,??DataTable9_25
        STRH     R0,[R1, #+0]
//  146   
//  147   
//  148   
//  149   
//  150   //-------- Get Sensers -----
//  151   
//  152   
//  153   // Tacho
//  154   Tacho0_Get();
        BL       Tacho0_Get
//  155   Tacho1_Get();
        BL       Tacho1_Get
//  156   
//  157   // UI operation input
//  158   ui_operation_cnt += tacho0;  // use tacho0 or tacho1
        LDR.N    R0,??DataTable9_26
        LDRH     R0,[R0, #+0]
        LDR.N    R1,??DataTable9_7
        LDRH     R1,[R1, #+0]
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable9_26
        STRH     R0,[R1, #+0]
//  159     
//  160 
//  161   
//  162 #if (CAR_TYPE==0)   // Magnet and Balance
//  163   
//  164   Mag_Sample();
//  165   
//  166   gyro1 = Gyro1();
//  167   gyro2 = Gyro2();
//  168   
//  169   
//  170   
//  171 #elif (CAR_TYPE==1)     // CCD
//  172   
//  173   CCD1_GetLine(ccd1_line);
//  174   CCD2_GetLine(ccd2_line);
//  175   
//  176   
//  177   
//  178   
//  179 #else               // Camera
//  180   
//  181   // Results of camera are automatically put in cam_buffer[].
//  182   
//  183   
//  184 #endif
//  185   
//  186   
//  187   
//  188   // -------- Sensor Algorithm --------- ( Users need to realize this )
//  189   
//  190   // mag example : dir_error = Mag_Algorithm(mag_val);
//  191   // ccd example : dir_error = CCD_Algorithm(ccd1_line,ccd2_line);
//  192   // cam is complex. realize it in Cam_Algorithm() in Cam.c
//  193   
//  194   //-------- Controller --------
//  195 
//  196 
//  197 
//  198   
//  199   // not balance example : dir_output = Dir_PIDController(dir_error);
//  200   // example : get 'motorL_output' and  'motorR_output'
//  201  
//  202   //motorControl();
//  203  
//  204   // ------- Output -----
//  205   
//  206   
//  207   // not balance example : Servo_Output(dir_output);  
//  208   // example : MotorL_Output(motorL_output); MotorR_Output(motorR_output);
//  209  //MotorL_Output(550); MotorR_Output(-550);
//  210   
//  211   
//  212   // ------- UART ---------
//  213   
//  214   
//  215   //UART_SendDataHead();
//  216   //UART_SendData(battery);
//  217   
//  218   
//  219   
//  220   // ------- other --------
//  221   
//  222   pit0_time = pit0_time - PIT2_VAL();
        LDR.N    R0,??DataTable9_24
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_18  ;; 0x40037124
        LDR      R1,[R1, #+0]
        SUBS     R0,R0,R1
        LDR.N    R1,??DataTable9_24
        STR      R0,[R1, #+0]
//  223   pit0_time = pit0_time / (g_bus_clock/1000000); //us
        LDR.N    R0,??DataTable9_20
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable9_27  ;; 0xf4240
        UDIV     R0,R0,R1
        LDR.N    R1,??DataTable9_24
        LDR      R1,[R1, #+0]
        UDIV     R0,R1,R0
        LDR.N    R1,??DataTable9_24
        STR      R0,[R1, #+0]
//  224   
//  225 }
        POP      {R0,PC}          ;; return
//  226 
//  227 
//  228 
//  229 
//  230 // ======= INIT ========
//  231 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  232 void PIT0_Init(u32 period_us)
//  233 { 
PIT0_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  234                    
//  235   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
        LDR.N    R0,??DataTable9_28  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable9_28  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  236   
//  237   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_29  ;; 0x40037000
        STR      R0,[R1, #+0]
//  238  
//  239   NVIC_EnableIRQ(PIT0_IRQn); 
        MOVS     R0,#+68
        BL       NVIC_EnableIRQ
//  240   NVIC_SetPriority(PIT0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+68
        BL       NVIC_SetPriority
//  241 
//  242   //period = (period_ns/bus_period_ns)-1
//  243   PIT->CHANNEL[0].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
        LDR.N    R0,??DataTable9_30  ;; 0x40037100
        LDR      R0,[R0, #+0]
        MOVS     R1,#+100
        UDIV     R1,R4,R1
        LDR.N    R2,??DataTable9_20
        LDR      R2,[R2, #+0]
        MOV      R3,#+1000
        UDIV     R2,R2,R3
        MULS     R1,R2,R1
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        SUBS     R1,R1,#+1
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable9_30  ;; 0x40037100
        STR      R0,[R1, #+0]
//  244   
//  245   PIT->CHANNEL[0].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable9_31  ;; 0x40037108
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable9_31  ;; 0x40037108
        STR      R0,[R1, #+0]
//  246 
//  247 };
        POP      {R4,PC}          ;; return
//  248 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  249 void PIT1_Init(u32 period_us)
//  250 { 
PIT1_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  251                    
//  252   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
        LDR.N    R0,??DataTable9_28  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable9_28  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  253   
//  254   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_29  ;; 0x40037000
        STR      R0,[R1, #+0]
//  255  
//  256   NVIC_EnableIRQ(PIT1_IRQn); 
        MOVS     R0,#+69
        BL       NVIC_EnableIRQ
//  257   NVIC_SetPriority(PIT1_IRQn, NVIC_EncodePriority(NVIC_GROUP, 3, 0));
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+69
        BL       NVIC_SetPriority
//  258 
//  259   //period = (period_ns/bus_period_ns)-1
//  260   PIT->CHANNEL[1].LDVAL |= period_us/100*(g_bus_clock/1000)/10-1; 
        LDR.N    R0,??DataTable9_32  ;; 0x40037110
        LDR      R0,[R0, #+0]
        MOVS     R1,#+100
        UDIV     R1,R4,R1
        LDR.N    R2,??DataTable9_20
        LDR      R2,[R2, #+0]
        MOV      R3,#+1000
        UDIV     R2,R2,R3
        MULS     R1,R2,R1
        MOVS     R2,#+10
        UDIV     R1,R1,R2
        SUBS     R1,R1,#+1
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable9_32  ;; 0x40037110
        STR      R0,[R1, #+0]
//  261   
//  262   PIT->CHANNEL[1].TCTRL |= PIT_TCTRL_TIE_MASK |PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable9_33  ;; 0x40037118
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable9_33  ;; 0x40037118
        STR      R0,[R1, #+0]
//  263 
//  264 }
        POP      {R4,PC}          ;; return
//  265 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  266 void PIT2_Init()
//  267 { 
//  268                    
//  269   SIM->SCGC6 |= SIM_SCGC6_PIT_MASK;
PIT2_Init:
        LDR.N    R0,??DataTable9_28  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable9_28  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  270   
//  271   PIT->MCR = 0x00;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable9_29  ;; 0x40037000
        STR      R0,[R1, #+0]
//  272 
//  273   //period = (period_ns/bus_period_ns)-1
//  274   PIT->CHANNEL[2].LDVAL = 0xffffffff; 
        MOVS     R0,#-1
        LDR.N    R1,??DataTable9_34  ;; 0x40037120
        STR      R0,[R1, #+0]
//  275   
//  276   PIT->CHANNEL[2].TCTRL |= PIT_TCTRL_TEN_MASK;
        LDR.N    R0,??DataTable9_35  ;; 0x40037128
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable9_35  ;; 0x40037128
        STR      R0,[R1, #+0]
//  277 
//  278 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0xe000ed18

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x40140000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     L

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     R

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_6:
        DC32     debug_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_7:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_8:
        DC32     L_err

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_9:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_10:
        DC32     R_err

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_11:
        DC32     0x4072c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_12:
        DC32     0xc072c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_13:
        DC32     L_pwm

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_14:
        DC32     R_pwm

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_15:
        DC32     0x4085e000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_16:
        DC32     0xc085e000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_17:
        DC32     0x4003711c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_18:
        DC32     0x40037124

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_19:
        DC32     pit1_time_tmp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_20:
        DC32     g_bus_clock

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_21:
        DC32     pit1_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_22:
        DC32     0x4003710c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_23:
        DC32     time_us

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_24:
        DC32     pit0_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_25:
        DC32     battery

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_26:
        DC32     ui_operation_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_27:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_28:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_29:
        DC32     0x40037000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_30:
        DC32     0x40037100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_31:
        DC32     0x40037108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_32:
        DC32     0x40037110

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_33:
        DC32     0x40037118

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_34:
        DC32     0x40037120

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_35:
        DC32     0x40037128

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
//   162 bytes in section .bss
// 1 928 bytes in section .text
// 
// 1 928 bytes of CODE memory
//   162 bytes of DATA memory
//
//Errors: none
//Warnings: 2
