///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:43
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\CCD.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\CCD.c -D LPLD_K60 -lCN
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\CCD.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN ADC1_enabled

        PUBLIC AD_Sample_CCD1
        PUBLIC AD_Sample_CCD2
        PUBLIC CCD1_CLK
        PUBLIC CCD1_GetLine
        PUBLIC CCD1_SI
        PUBLIC CCD2_CLK
        PUBLIC CCD2_GetLine
        PUBLIC CCD2_SI
        PUBLIC CCD_Init
        PUBLIC ccd1_line
        PUBLIC ccd2_line

// D:\GitHub_pository\FuYing_Car2\source\CCD.c
//    1 /*
//    2 Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
//    3 Date : 2015/12/01
//    4 License : MIT
//    5 */
//    6 
//    7 #include "includes.h"
//    8 
//    9 
//   10 
//   11 // ===== Variables ======
//   12 //---- GLOBAL ----
//   13 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 U8 ccd1_line[128];
ccd1_line:
        DS8 128

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 U8 ccd2_line[128];
ccd2_line:
        DS8 128
//   16 
//   17 //---- LOCAL ---
//   18 
//   19 
//   20 
//   21 // ===== Function Declaration ===== ( Local ) ( No need for users to use)
//   22 
//   23   // -- Basic Drivers --
//   24 u32 AD_Sample_CCD1();
//   25 u32 AD_Sample_CCD2();
//   26 
//   27   // --  Hardware Interface --
//   28 void CCD1_SI(u8 x);
//   29 void CCD2_SI(u8 x);
//   30 void CCD1_CLK(u8 x);
//   31 void CCD2_CLK(u8 x);
//   32 
//   33 
//   34 
//   35 // =======  Function Realization ======
//   36 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   37 void CCD1_GetLine(U8 * ccd_line)
//   38 {
CCD1_GetLine:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   39   u8 i;
//   40  	
//   41   //Collect pixels.
//   42   //Sned SI
//   43   CCD1_SI(1);  //SI = 1, t = 0
        MOVS     R0,#+1
        BL       CCD1_SI
//   44   
//   45   asm("nop");asm("nop");
        nop
        nop
//   46   
//   47   CCD1_CLK(1); //CLK = 1, dt = 75ns
        MOVS     R0,#+1
        BL       CCD1_CLK
//   48   CCD1_SI(0);  //SI = 0, dt = 50ns
        MOVS     R0,#+0
        BL       CCD1_SI
//   49   
//   50   //First pixel.
//   51   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//   52   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//   53   
//   54   ccd_line[0] = AD_Sample_CCD1();
        BL       AD_Sample_CCD1
        STRB     R0,[R4, #+0]
//   55   
//   56   CCD1_CLK(0); //CLK = 0
        MOVS     R0,#+0
        BL       CCD1_CLK
//   57  
//   58   //2~128 CLK
//   59   for(i=1; i<128; i++)
        MOVS     R5,#+1
        B.N      ??CCD1_GetLine_0
//   60   {
//   61     
//   62     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
??CCD1_GetLine_1:
        nop
        nop
        nop
        nop
        nop
        nop
//   63     
//   64     CCD1_CLK(1);  //CLK = 1, dt = 125ns
        MOVS     R0,#+1
        BL       CCD1_CLK
//   65     
//   66     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//   67     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//   68     
//   69     ccd_line[i] = AD_Sample_CCD1();
        BL       AD_Sample_CCD1
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STRB     R0,[R5, R4]
//   70     
//   71     CCD1_CLK(0);  //CLK = 0.
        MOVS     R0,#+0
        BL       CCD1_CLK
//   72   }
        ADDS     R5,R5,#+1
??CCD1_GetLine_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+128
        BLT.N    ??CCD1_GetLine_1
//   73  
//   74   //129 CLK
//   75   
//   76   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
        nop
//   77   
//   78   CCD1_CLK(1);  //CLK = 1.
        MOVS     R0,#+1
        BL       CCD1_CLK
//   79   
//   80   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
        nop
//   81   
//   82   CCD1_CLK(0);  //CLK = 0.
        MOVS     R0,#+0
        BL       CCD1_CLK
//   83 }
        POP      {R0,R4,R5,PC}    ;; return
//   84 
//   85 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   86 void CCD2_GetLine(U8 * ccd_line)
//   87 {
CCD2_GetLine:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   88   u8 i;
//   89  	
//   90   //Collect pixels.
//   91   //Sned SI
//   92   CCD2_SI(1);  //SI = 1, t = 0
        MOVS     R0,#+1
        BL       CCD2_SI
//   93   
//   94   asm("nop");asm("nop");
        nop
        nop
//   95   
//   96   CCD2_CLK(1); //CLK = 1, dt = 75ns
        MOVS     R0,#+1
        BL       CCD2_CLK
//   97   CCD2_SI(0);  //SI = 0, dt = 50ns
        MOVS     R0,#+0
        BL       CCD2_SI
//   98   
//   99   //First pixel.
//  100   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//  101   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//  102   
//  103   ccd_line[0] = AD_Sample_CCD2();
        BL       AD_Sample_CCD2
        STRB     R0,[R4, #+0]
//  104   
//  105   CCD2_CLK(0); //CLK = 0
        MOVS     R0,#+0
        BL       CCD2_CLK
//  106  
//  107   //2~128 CLK
//  108   for(i=1; i<128; i++)
        MOVS     R5,#+1
        B.N      ??CCD2_GetLine_0
//  109   {
//  110     
//  111     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
??CCD2_GetLine_1:
        nop
        nop
        nop
        nop
        nop
        nop
//  112     
//  113     CCD2_CLK(1);  //CLK = 1, dt = 125ns
        MOVS     R0,#+1
        BL       CCD2_CLK
//  114     
//  115     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//  116     asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
//  117     
//  118     ccd_line[i] = AD_Sample_CCD2();
        BL       AD_Sample_CCD2
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STRB     R0,[R5, R4]
//  119     
//  120     CCD2_CLK(0);  //CLK = 0.
        MOVS     R0,#+0
        BL       CCD2_CLK
//  121   }
        ADDS     R5,R5,#+1
??CCD2_GetLine_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+128
        BLT.N    ??CCD2_GetLine_1
//  122  
//  123   //129 CLK
//  124   
//  125   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
        nop
//  126   
//  127   CCD2_CLK(1);  //CLK = 1.
        MOVS     R0,#+1
        BL       CCD2_CLK
//  128   
//  129   asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");asm("nop");
        nop
        nop
        nop
        nop
        nop
        nop
//  130   
//  131   CCD2_CLK(0);  //CLK = 0.
        MOVS     R0,#+0
        BL       CCD2_CLK
//  132 }
        POP      {R0,R4,R5,PC}    ;; return
//  133 
//  134   //  INIT 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  135 void CCD_Init(){
//  136   
//  137   PORTB->PCR[20] |= PORT_PCR_MUX(1);    // 2 SI
CCD_Init:
        LDR.N    R0,??DataTable6  ;; 0x4004a050
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable6  ;; 0x4004a050
        STR      R0,[R1, #+0]
//  138   PORTB->PCR[21] |= PORT_PCR_MUX(1);    // 1 SI
        LDR.N    R0,??DataTable6_1  ;; 0x4004a054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable6_1  ;; 0x4004a054
        STR      R0,[R1, #+0]
//  139   PORTB->PCR[22] |= PORT_PCR_MUX(1);    // 2 CLK
        LDR.N    R0,??DataTable6_2  ;; 0x4004a058
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable6_2  ;; 0x4004a058
        STR      R0,[R1, #+0]
//  140   PORTB->PCR[23] |= PORT_PCR_MUX(1);    // 1 CLK
        LDR.N    R0,??DataTable6_3  ;; 0x4004a05c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable6_3  ;; 0x4004a05c
        STR      R0,[R1, #+0]
//  141   PTB->PDDR |= (0xf<<20);
        LDR.N    R0,??DataTable6_4  ;; 0x400ff054
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0xF00000
        LDR.N    R1,??DataTable6_4  ;; 0x400ff054
        STR      R0,[R1, #+0]
//  142   
//  143   SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK;//ADC0 Clock Enable
        LDR.N    R0,??DataTable6_5  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable6_5  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  144   /*
//  145   ADC0->CFG1 |= 0
//  146              //|ADC_CFG1_ADLPC_MASK
//  147              | ADC_CFG1_ADICLK(1)
//  148              | ADC_CFG1_MODE(0);
//  149              //| ADC_CFG1_ADIV(0);
//  150   ADC0->CFG2 |= //ADC_CFG2_ADHSC_MASK |
//  151                 ADC_CFG2_ADACKEN_MASK; 
//  152   
//  153   ADC0->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
//  154   
//  155   PORTC->PCR[0]|=PORT_PCR_MUX(0);//adc0-14
//  156   PORTC->PCR[1]|=PORT_PCR_MUX(0);//adc0-15
//  157   */
//  158     if(!ADC1_enabled){
        LDR.N    R0,??DataTable6_6
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??CCD_Init_0
//  159     SIM->SCGC3 |= SIM_SCGC3_ADC1_MASK;  //ADC1 Clock Enable
        LDR.N    R0,??DataTable6_7  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable6_7  ;; 0x40048030
        STR      R0,[R1, #+0]
//  160     ADC1->CFG1 |= 0
//  161                //|ADC_CFG1_ADLPC_MASK
//  162                | ADC_CFG1_ADICLK(1)
//  163                | ADC_CFG1_MODE(0)
//  164                | ADC_CFG1_ADIV(0);
        LDR.N    R0,??DataTable6_8  ;; 0x400bb008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_8  ;; 0x400bb008
        STR      R0,[R1, #+0]
//  165     ADC1->CFG2 |= //ADC_CFG2_ADHSC_MASK |
//  166                   ADC_CFG2_ADACKEN_MASK;
        LDR.N    R0,??DataTable6_9  ;; 0x400bb00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable6_9  ;; 0x400bb00c
        STR      R0,[R1, #+0]
//  167     ADC1_enabled = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable6_6
        STRB     R0,[R1, #+0]
//  168   }
//  169   
//  170 }
??CCD_Init_0:
        BX       LR               ;; return
//  171 
//  172 
//  173 // ======= Basic Drivers ======
//  174 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  175 u32 AD_Sample_CCD1(){
//  176   /*ADC0->SC1[0] = ADC_SC1_ADCH(15);
//  177   while((ADC0->SC1[0]&ADC_SC1_COCO_MASK)==0);
//  178   return ADC0->R[0];*/
//  179   
//  180   ADC1->SC1[0] = ADC_SC1_ADCH(15);
AD_Sample_CCD1:
        MOVS     R0,#+15
        LDR.N    R1,??DataTable6_10  ;; 0x400bb000
        STR      R0,[R1, #+0]
//  181   while((ADC1->SC1[0]&ADC_SC1_COCO_MASK)==0);
??AD_Sample_CCD1_0:
        LDR.N    R0,??DataTable6_10  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??AD_Sample_CCD1_0
//  182   return ADC1->R[0];
        LDR.N    R0,??DataTable6_11  ;; 0x400bb010
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  183 }

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  184 u32 AD_Sample_CCD2(){
//  185   ADC0->SC1[0] = ADC_SC1_ADCH(14);
AD_Sample_CCD2:
        MOVS     R0,#+14
        LDR.N    R1,??DataTable6_12  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  186   while((ADC0->SC1[0]&ADC_SC1_COCO_MASK)==0);
??AD_Sample_CCD2_0:
        LDR.N    R0,??DataTable6_12  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??AD_Sample_CCD2_0
//  187   return ADC0->R[0];
        LDR.N    R0,??DataTable6_13  ;; 0x4003b010
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  188 }
//  189    
//  190 // ===== Hardware Interface =====

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  191 void CCD1_SI(u8 x){
//  192   if(x)
CCD1_SI:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??CCD1_SI_0
//  193     PTB->PSOR |= 1<<21;
        LDR.N    R0,??DataTable6_14  ;; 0x400ff044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200000
        LDR.N    R1,??DataTable6_14  ;; 0x400ff044
        STR      R0,[R1, #+0]
        B.N      ??CCD1_SI_1
//  194   else
//  195     PTB->PCOR |= 1<<21;
??CCD1_SI_0:
        LDR.N    R0,??DataTable6_15  ;; 0x400ff048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200000
        LDR.N    R1,??DataTable6_15  ;; 0x400ff048
        STR      R0,[R1, #+0]
//  196 }
??CCD1_SI_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 void CCD2_SI(u8 x){
//  198   if(x)
CCD2_SI:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??CCD2_SI_0
//  199     PTB->PSOR |= 1<<20;
        LDR.N    R0,??DataTable6_14  ;; 0x400ff044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100000
        LDR.N    R1,??DataTable6_14  ;; 0x400ff044
        STR      R0,[R1, #+0]
        B.N      ??CCD2_SI_1
//  200   else
//  201     PTB->PCOR |= 1<<20;
??CCD2_SI_0:
        LDR.N    R0,??DataTable6_15  ;; 0x400ff048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100000
        LDR.N    R1,??DataTable6_15  ;; 0x400ff048
        STR      R0,[R1, #+0]
//  202 }
??CCD2_SI_1:
        BX       LR               ;; return
//  203 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  204 void CCD1_CLK(u8 x){
//  205   if(x)
CCD1_CLK:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??CCD1_CLK_0
//  206     PTB->PSOR |= 1<<23;
        LDR.N    R0,??DataTable6_14  ;; 0x400ff044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable6_14  ;; 0x400ff044
        STR      R0,[R1, #+0]
        B.N      ??CCD1_CLK_1
//  207   else
//  208     PTB->PCOR |= 1<<23;
??CCD1_CLK_0:
        LDR.N    R0,??DataTable6_15  ;; 0x400ff048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable6_15  ;; 0x400ff048
        STR      R0,[R1, #+0]
//  209 }
??CCD1_CLK_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  210 void CCD2_CLK(u8 x){
//  211   if(x)
CCD2_CLK:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??CCD2_CLK_0
//  212     PTB->PSOR |= 1<<22;
        LDR.N    R0,??DataTable6_14  ;; 0x400ff044
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400000
        LDR.N    R1,??DataTable6_14  ;; 0x400ff044
        STR      R0,[R1, #+0]
        B.N      ??CCD2_CLK_1
//  213   else
//  214     PTB->PCOR |= 1<<22;
??CCD2_CLK_0:
        LDR.N    R0,??DataTable6_15  ;; 0x400ff048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400000
        LDR.N    R1,??DataTable6_15  ;; 0x400ff048
        STR      R0,[R1, #+0]
//  215 }
??CCD2_CLK_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x4004a050

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0x4004a054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x4004a058

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x4004a05c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     0x400ff054

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     ADC1_enabled

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     0x400bb008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     0x400bb00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     0x400bb000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     0x400bb010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     0x4003b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_14:
        DC32     0x400ff044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_15:
        DC32     0x400ff048

        SECTION `.iar_vfe_header`:DATA:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  216 
// 
// 256 bytes in section .bss
// 684 bytes in section .text
// 
// 684 bytes of CODE memory
// 256 bytes of DATA memory
//
//Errors: none
//Warnings: none
