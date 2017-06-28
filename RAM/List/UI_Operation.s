///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:51
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\UI_Operation.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\UI_Operation.c -D LPLD_K60 -lCN
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\UI_Operation.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN car_state
        EXTERN oled_menu
        EXTERN speed_set

        PUBLIC Key1_Downspin_Func
        PUBLIC Key1_Read
        PUBLIC Key1_Rise_Func
        PUBLIC Key1_cnt
        PUBLIC Key1_down
        PUBLIC Key1_rise
        PUBLIC Key1_risemask
        PUBLIC Key2_Downspin_Func
        PUBLIC Key2_Read
        PUBLIC Key2_Rise_Func
        PUBLIC Key2_cnt
        PUBLIC Key2_down
        PUBLIC Key2_rise
        PUBLIC Key2_risemask
        PUBLIC Key3_Downspin_Func
        PUBLIC Key3_Read
        PUBLIC Key3_Rise_Func
        PUBLIC Key3_cnt
        PUBLIC Key3_down
        PUBLIC Key3_rise
        PUBLIC Key3_risemask
        PUBLIC Spin_Func
        PUBLIC UI_Operation_Service
        PUBLIC ch
        PUBLIC set_car_state
        PUBLIC set_oled_menu
        PUBLIC ui_operation_cnt
        PUBLIC ui_operation_shift

// D:\GitHub_pository\FuYing_Car2\source\UI_Operation.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/04
//    4 License : MIT
//    5 */
//    6 
//    7 
//    8 #include "includes.h"
//    9 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   10 char ch;
ch:
        DS8 1
//   11 
//   12 
//   13 
//   14 // ====== Settings ======
//   15 
//   16   // Sensibility of operation
//   17   // smaller, more sensitive
//   18 #define SENSIBILITY 8
//   19 
//   20   // Strength to debounce
//   21   // depends on period of UI Refreshing Loop
//   22 #define DEBOUNCE_CNT 6 
//   23 
//   24 
//   25 
//   26 
//   27 // ====== Variables ======
//   28 
//   29 // ---- Global ----

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   30 int16 ui_operation_shift, ui_operation_cnt;
ui_operation_shift:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
ui_operation_cnt:
        DS8 2
//   31 
//   32 // ---- Local ----

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   33 u8 Key3_down,Key1_down,Key2_down;   // flag : state of pushed down
Key3_down:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key1_down:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key2_down:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   34 u8 Key3_rise,Key1_rise,Key2_rise;   // flag : transient state of rising
Key3_rise:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key1_rise:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key2_rise:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   35 u8 Key3_cnt,Key1_cnt,Key2_cnt;      // counter to debounce
Key3_cnt:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key1_cnt:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key2_cnt:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   36 u8 Key1_risemask,Key2_risemask,Key3_risemask;   // flag to mask Rise_Func after DownSpin_Func
Key1_risemask:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key2_risemask:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
Key3_risemask:
        DS8 1
//   37 
//   38 
//   39 
//   40 // ====== Local Func Declaration ====
//   41 
//   42   // --- API ---
//   43 void Key1_Rise_Func();
//   44 void Key2_Rise_Func();
//   45 void Key3_Rise_Func();
//   46 void Key1_Downspin_Func();
//   47 void Key2_Downspin_Func();
//   48 void Key3_Downspin_Func();
//   49 void Spin_Func();
//   50 
//   51   // --- Baisc Drivers ---
//   52 void Key1_Read();
//   53 void Key2_Read();
//   54 void Key3_Read();
//   55 
//   56 
//   57 
//   58 
//   59 // ====== APIs =======
//   60 // write your codes in certain Func you wanna realize.
//   61 
//   62 
//   63   // --- Keyn_Rise_Func ---
//   64   // triggered when Keyn rises after push with no spin of tacho.
//   65 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 void Key1_Rise_Func(){
//   67   //if(!SW4()) MotorL_Output(-530);
//   68 }
Key1_Rise_Func:
        BX       LR               ;; return
//   69 
//   70 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   71 void Key2_Rise_Func(){
//   72  // if(!SW4()) MotorR_Output(-530);
//   73 }
Key2_Rise_Func:
        BX       LR               ;; return
//   74 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   75 void Key3_Rise_Func(){ 
//   76  // if(!SW4()) Servo_Output(-70);  
//   77 }
Key3_Rise_Func:
        BX       LR               ;; return
//   78 
//   79 
//   80   // --- Keyn_Downspin_Func ---
//   81   // triggered when Keyn is pushed down and spinning tacho.
//   82   // if triggered , Rise_Func won't be trigger when rises.
//   83 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void Key1_Downspin_Func(){
//   85   
//   86   if(SW4() && SW3() && SW2() ) 
Key1_Downspin_Func:
        LDR.W    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+7,#+1
        CMP      R0,#+0
        BEQ.N    ??Key1_Downspin_Func_0
        LDR.W    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+6,#+1
        CMP      R0,#+0
        BEQ.N    ??Key1_Downspin_Func_0
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BEQ.N    ??Key1_Downspin_Func_0
//   87   {
//   88     if (ui_operation_shift>0) speed_set++;
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Key1_Downspin_Func_1
        LDR.N    R0,??DataTable6_2
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable6_2
        STRH     R0,[R1, #+0]
        B.N      ??Key1_Downspin_Func_0
//   89     else if (ui_operation_shift<0) speed_set--;
??Key1_Downspin_Func_1:
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BPL.N    ??Key1_Downspin_Func_0
        LDR.N    R0,??DataTable6_2
        LDRH     R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable6_2
        STRH     R0,[R1, #+0]
//   90   }
//   91 }
??Key1_Downspin_Func_0:
        BX       LR               ;; return
//   92 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 void Key2_Downspin_Func(){
//   94   
//   95 }
Key2_Downspin_Func:
        BX       LR               ;; return
//   96 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   97 void Key3_Downspin_Func(){
Key3_Downspin_Func:
        PUSH     {R7,LR}
//   98   
//   99   Spin_Func();
        BL       Spin_Func
//  100 }
        POP      {R0,PC}          ;; return
//  101 
//  102 
//  103   // --- Spin_Func ---
//  104   // triggered when spinning tacho with no Key pushed.

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  105 void Spin_Func(){
//  106 
//  107 }
Spin_Func:
        BX       LR               ;; return
//  108 
//  109 
//  110 
//  111 
//  112 // ========= Service ======= 
//  113 
//  114   // Put this in UI refreshing loop (PIT1_ISR)
//  115 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  116 void UI_Operation_Service(){
UI_Operation_Service:
        PUSH     {R7,LR}
//  117   Key3_Read();
        BL       Key3_Read
//  118   Key1_Read();
        BL       Key1_Read
//  119   Key2_Read();
        BL       Key2_Read
//  120   
//  121   ui_operation_shift = ui_operation_cnt/SENSIBILITY;
        LDR.N    R0,??DataTable6_3
        LDRSH    R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R0,R0,R1
        LDR.N    R1,??DataTable6_1
        STRH     R0,[R1, #+0]
//  122   ui_operation_cnt %= SENSIBILITY;
        LDR.N    R0,??DataTable6_3
        LDRSH    R0,[R0, #+0]
        MOVS     R1,#+8
        SDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        LDR.N    R0,??DataTable6_3
        STRH     R2,[R0, #+0]
//  123   
//  124   if(Key1_rise){
        LDR.N    R0,??DataTable6_4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_0
//  125     Key1_rise=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
//  126     Key1_Rise_Func();
        BL       Key1_Rise_Func
//  127   }
//  128   if(Key2_rise){
??UI_Operation_Service_0:
        LDR.N    R0,??DataTable6_5
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_1
//  129     Key2_rise=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_5
        STRB     R0,[R1, #+0]
//  130     Key2_Rise_Func();
        BL       Key2_Rise_Func
//  131   }
//  132   if(Key3_rise){
??UI_Operation_Service_1:
        LDR.N    R0,??DataTable6_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_2
//  133     Key3_rise=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_6
        STRB     R0,[R1, #+0]
//  134     Key3_Rise_Func();
        BL       Key3_Rise_Func
//  135   }
//  136   if(Key1_down && ui_operation_shift!=0 ){       // 
??UI_Operation_Service_2:
        LDR.N    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_3
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_3
//  137     Key1_risemask=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_8
        STRB     R0,[R1, #+0]
//  138     Key1_Downspin_Func();
        BL       Key1_Downspin_Func
        B.N      ??UI_Operation_Service_4
//  139   }
//  140   else if(Key2_down && ui_operation_shift!=0 ){       // 
??UI_Operation_Service_3:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_5
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_5
//  141     Key2_risemask=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_10
        STRB     R0,[R1, #+0]
//  142     Key2_Downspin_Func();
        BL       Key2_Downspin_Func
        B.N      ??UI_Operation_Service_4
//  143   }
//  144   else if(Key3_down && ui_operation_shift!=0 ){       // 
??UI_Operation_Service_5:
        LDR.N    R0,??DataTable6_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_6
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_6
//  145     Key3_risemask=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_12
        STRB     R0,[R1, #+0]
//  146     Key3_Downspin_Func();
        BL       Key3_Downspin_Func
        B.N      ??UI_Operation_Service_4
//  147   }
//  148   else if(ui_operation_shift!=0){
??UI_Operation_Service_6:
        LDR.N    R0,??DataTable6_1
        LDRSH    R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_Operation_Service_4
//  149     Spin_Func();
        BL       Spin_Func
//  150   }
//  151 }
??UI_Operation_Service_4:
        POP      {R0,PC}          ;; return
//  152 
//  153 
//  154 
//  155 
//  156 // ===== Basic Drivers ====
//  157 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 void Key1_Read(){
//  159   if(Key1()==0){
Key1_Read:
        LDR.N    R0,??DataTable6_13  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??Key1_Read_0
//  160     Key1_down=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
//  161     Key1_cnt=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
        B.N      ??Key1_Read_1
//  162   }
//  163   else if(Key1_down && Key1_cnt<DEBOUNCE_CNT)
??Key1_Read_0:
        LDR.N    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key1_Read_2
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BGE.N    ??Key1_Read_2
//  164     Key1_cnt++;
        LDR.N    R0,??DataTable6_14
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable6_14
        STRB     R0,[R1, #+0]
        B.N      ??Key1_Read_1
//  165   else if(Key1_down){
??Key1_Read_2:
        LDR.N    R0,??DataTable6_7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key1_Read_3
//  166     Key1_down=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
//  167     Key1_rise=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_4
        STRB     R0,[R1, #+0]
        B.N      ??Key1_Read_1
//  168   }
//  169   else
//  170     Key1_down=0;
??Key1_Read_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_7
        STRB     R0,[R1, #+0]
//  171 }
??Key1_Read_1:
        BX       LR               ;; return
//  172 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  173 void Key2_Read(){
//  174   if(Key2()==0){
Key2_Read:
        LDR.N    R0,??DataTable6_13  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??Key2_Read_0
//  175     Key2_down=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
//  176     Key2_cnt=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_15
        STRB     R0,[R1, #+0]
        B.N      ??Key2_Read_1
//  177   }
//  178   else if(Key2_down && Key2_cnt<DEBOUNCE_CNT)
??Key2_Read_0:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key2_Read_2
        LDR.N    R0,??DataTable6_15
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BGE.N    ??Key2_Read_2
//  179     Key2_cnt++;
        LDR.N    R0,??DataTable6_15
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable6_15
        STRB     R0,[R1, #+0]
        B.N      ??Key2_Read_1
//  180   else if(Key2_down){
??Key2_Read_2:
        LDR.N    R0,??DataTable6_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key2_Read_3
//  181     Key2_down=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
//  182     Key2_rise=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_5
        STRB     R0,[R1, #+0]
        B.N      ??Key2_Read_1
//  183   }
//  184   else
//  185     Key2_down=0;
??Key2_Read_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_9
        STRB     R0,[R1, #+0]
//  186 }
??Key2_Read_1:
        BX       LR               ;; return
//  187 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  188 void Key3_Read(){
//  189   if(Key3()==0){
Key3_Read:
        LDR.N    R0,??DataTable6_13  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??Key3_Read_0
//  190     Key3_down=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_11
        STRB     R0,[R1, #+0]
//  191     Key3_cnt=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_16
        STRB     R0,[R1, #+0]
        B.N      ??Key3_Read_1
//  192   }
//  193   else if(Key3_down && Key3_cnt<DEBOUNCE_CNT)
??Key3_Read_0:
        LDR.N    R0,??DataTable6_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key3_Read_2
        LDR.N    R0,??DataTable6_16
        LDRB     R0,[R0, #+0]
        CMP      R0,#+6
        BGE.N    ??Key3_Read_2
//  194     Key3_cnt++;
        LDR.N    R0,??DataTable6_16
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable6_16
        STRB     R0,[R1, #+0]
        B.N      ??Key3_Read_1
//  195   else if(Key3_down){
??Key3_Read_2:
        LDR.N    R0,??DataTable6_11
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Key3_Read_3
//  196     Key3_down=0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_11
        STRB     R0,[R1, #+0]
//  197     if(Key3_risemask==0)
        LDR.N    R0,??DataTable6_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Key3_Read_4
//  198       Key3_rise=1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_6
        STRB     R0,[R1, #+0]
        B.N      ??Key3_Read_1
//  199     else
//  200       Key3_risemask=0;
??Key3_Read_4:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_12
        STRB     R0,[R1, #+0]
        B.N      ??Key3_Read_1
//  201   }
//  202   else
//  203     Key3_down=0;
??Key3_Read_3:
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_11
        STRB     R0,[R1, #+0]
//  204 }
??Key3_Read_1:
        BX       LR               ;; return
//  205 
//  206 //============ some new functions ===============

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  207 void set_car_state()
//  208 {
//  209   if(SW4()==1)          car_state=0;
set_car_state:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+7,#+1
        CMP      R0,#+0
        BEQ.N    ??set_car_state_0
        MOVS     R0,#+0
        LDR.N    R1,??DataTable6_17
        STRB     R0,[R1, #+0]
        B.N      ??set_car_state_1
//  210   else if(SW3()==1)     car_state=1;
??set_car_state_0:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+6,#+1
        CMP      R0,#+0
        BEQ.N    ??set_car_state_2
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_17
        STRB     R0,[R1, #+0]
        B.N      ??set_car_state_1
//  211   else if(SW3()==0)     car_state=2;
??set_car_state_2:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+6,#+1
        CMP      R0,#+0
        BNE.N    ??set_car_state_1
        MOVS     R0,#+2
        LDR.N    R1,??DataTable6_17
        STRB     R0,[R1, #+0]
//  212 }
??set_car_state_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  213 void set_oled_menu()
//  214 {
//  215   if(SW1()==1 && SW2()==1) oled_menu=1;
set_oled_menu:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BEQ.N    ??set_oled_menu_0
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BEQ.N    ??set_oled_menu_0
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_18
        STRB     R0,[R1, #+0]
//  216   if(SW1()==1 && SW2()==0) oled_menu=1;
??set_oled_menu_0:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BEQ.N    ??set_oled_menu_1
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BNE.N    ??set_oled_menu_1
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_18
        STRB     R0,[R1, #+0]
//  217   if(SW1()==0 && SW2()==1) oled_menu=2;
??set_oled_menu_1:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BNE.N    ??set_oled_menu_2
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BEQ.N    ??set_oled_menu_2
        MOVS     R0,#+2
        LDR.N    R1,??DataTable6_18
        STRB     R0,[R1, #+0]
//  218   if(SW1()==0 && SW2()==0) oled_menu=3;
??set_oled_menu_2:
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BNE.N    ??set_oled_menu_3
        LDR.N    R0,??DataTable6  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+5,#+1
        CMP      R0,#+0
        BNE.N    ??set_oled_menu_3
        MOVS     R0,#+3
        LDR.N    R1,??DataTable6_18
        STRB     R0,[R1, #+0]
//  219 
//  220 }
??set_oled_menu_3:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x400ff090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     ui_operation_shift

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     speed_set

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     ui_operation_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     Key1_rise

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     Key2_rise

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     Key3_rise

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     Key1_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     Key1_risemask

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     Key2_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     Key2_risemask

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     Key3_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     Key3_risemask

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_14:
        DC32     Key1_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_15:
        DC32     Key2_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_16:
        DC32     Key3_cnt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_17:
        DC32     car_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_18:
        DC32     oled_menu

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
//  17 bytes in section .bss
// 838 bytes in section .text
// 
// 838 bytes of CODE memory
//  17 bytes of DATA memory
//
//Errors: none
//Warnings: none
