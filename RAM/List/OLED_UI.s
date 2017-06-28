///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:48
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\OLED_UI.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\OLED_UI.c -D LPLD_K60 -lCN
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\OLED_UI.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN Oled_Clear
        EXTERN Oled_DrawBMP
        EXTERN Oled_Putnum
        EXTERN Oled_Putstr
        EXTERN ServoOut
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_dmul
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_fmul
        EXTERN __aeabi_memcpy4
        EXTERN battery
        EXTERN cam_buffer
        EXTERN car_state
        EXTERN debug_dir
        EXTERN debug_speed
        EXTERN margin
        EXTERN mid_ave
        EXTERN motor_L
        EXTERN motor_R
        EXTERN pit0_time
        EXTERN pit1_time
        EXTERN road_B
        EXTERN road_state
        EXTERN tacho0
        EXTERN tacho1
        EXTERN valid_row
        EXTERN weight

        PUBLIC UI_Graph
        PUBLIC UI_SystemInfo
        PUBLIC displayCamera
        PUBLIC displayDebug
        PUBLIC displayMenu
        PUBLIC displayParameters
        PUBLIC drawCam
        PUBLIC flag_down
        PUBLIC isWhite
        PUBLIC oled_menu

// D:\GitHub_pository\FuYing_Car2\source\OLED_UI.c
//    1 
//    2 #include "includes.h"
//    3 
//    4 // ====== Variables ======
//    5 // ---- Global ----

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//    6 u8 oled_menu=0;
oled_menu:
        DS8 1
//    7 // ---- Local ----

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//    8 bool flag_down=0;
flag_down:
        DS8 1
//    9 
//   10 
//   11 
//   12   /*
//   13   UI_Page homepage;
//   14   UI_Page subpage0;
//   15   homepage.sub_type = (enum Item_Type *) malloc (4*2);
//   16   homepage.sub_type[0] = Item_Type_Menu;
//   17   homepage.sub = (void **)malloc (4*2); // (void **)(UI_Page **)
//   18   *((UI_Page **)(homepage.sub)+0) = (UI_Page *) &subpage0;
//   19   subpage0.parent = (void *) &homepage;
//   20   
//   21   subpage0.sub = (void **)123;
//   22   Oled_Putnum(0,0,(s16)((*((UI_Page **)homepage.sub+0))->sub));
//   23   */
//   24   //free(homepage.sub);
//   25   //free(homepage.sub_type);
//   26 
//   27 
//   28 enum Item_Type{
//   29     Item_Type_Menu,
//   30     Item_Type_Para,
//   31     Item_Type_Show,
//   32     Item_Type_Func,
//   33 };
//   34 
//   35 typedef struct {
//   36   void * parent;   // UI_Page *
//   37   enum Item_Type * sub_type; 
//   38   void ** sub;  // UI_Page **
//   39 }UI_Page;
//   40 
//   41 typedef struct {
//   42   u8 * category;
//   43   s16  data;
//   44 }Putboth;
//   45 
//   46 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   47 void UI_SystemInfo(){
UI_SystemInfo:
        PUSH     {R7,LR}
//   48   
//   49   Oled_Clear();//删掉什么后果？
        BL       Oled_Clear
//   50   
//   51   switch(oled_menu)
        LDR.W    R0,??DataTable4
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??UI_SystemInfo_0
        CMP      R0,#+2
        BEQ.N    ??UI_SystemInfo_1
        BCC.N    ??UI_SystemInfo_2
        CMP      R0,#+3
        BEQ.N    ??UI_SystemInfo_3
        B.N      ??UI_SystemInfo_4
//   52   {
//   53   case 0:displayMenu();break;
??UI_SystemInfo_0:
        BL       displayMenu
        B.N      ??UI_SystemInfo_5
//   54   case 1:displayParameters();break;
??UI_SystemInfo_2:
        BL       displayParameters
        B.N      ??UI_SystemInfo_5
//   55   case 2:displayCamera();break;
??UI_SystemInfo_1:
        BL       displayCamera
        B.N      ??UI_SystemInfo_5
//   56   case 3:displayDebug();break;
??UI_SystemInfo_3:
        BL       displayDebug
        B.N      ??UI_SystemInfo_5
//   57   default:Oled_Clear();
??UI_SystemInfo_4:
        BL       Oled_Clear
//   58   }
//   59   
//   60   
//   61  // if(SW1()){
//   62   //Oled_Putstr(0,0,"Car Type"); Oled_Putnum(0,11,CAR_TYPE);
//   63   //Oled_Putstr(1,0,"battery"); Oled_Putnum(1,11,battery);
//   64   //Oled_Putstr(2,0,"mid[6]"); Oled_Putnum(2,11,road_B[6].mid);
//   65   //Oled_Putstr(3,0,"mid[7]"); Oled_Putnum(3,11,road_B[7].mid);
//   66   //Oled_Putstr(4,0,"mid[8]"); Oled_Putnum(4,11,road_B[8].mid);
//   67   //Oled_Putstr(5,0,"mid[9]"); Oled_Putnum(5,11,road_B[9].mid);
//   68   //Oled_Putstr(6,0,"servo"); Oled_Putnum(6,11,ServoOut);
//   69   //Oled_Putstr(7,0,"safe_point"); Oled_Putnum(7,11,safe_point);
//   70   //Oled_Putstr(6,0,"40"); Oled_Putnum(6,11,cam_buffer[40][10]);
//   71   //Oled_Putstr(3,0,"pit0 time"); Oled_Putnum(3,11,(s16)pit0_time);
//   72  // Oled_Putstr(4,0,"pit1 time"); Oled_Putnum(4,11,(s16)pit1_time);
//   73   //Oled_Putstr(5,0,"speeds"); Oled_Putnum(5,11,speed_set);
//   74   //Oled_Putstr(6,0,"tacho0"); Oled_Putnum(6,11,tacho0);
//   75   //Oled_Putstr(7,0,"tacho1"); Oled_Putnum(7,11,tacho1);
//   76   //Oled_Putstr(5,0,"10"); Oled_Putnum(5,11,cam_buffer[10][10]);
//   77   //Oled_Putstr(6,0,"40"); Oled_Putnum(6,11,cam_buffer[40][10]);
//   78   //Oled_Putstr(7,0,"70"); Oled_Putnum(7,11,cam_buffer[70][10]);
//   79 }
??UI_SystemInfo_5:
        POP      {R0,PC}          ;; return
//   80 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   81 void displayMenu()//menu==0
//   82 {
displayMenu:
        PUSH     {R7,LR}
//   83   Oled_Putstr(0,1,"<Start-Menu>");
        LDR.W    R2,??DataTable4_1
        MOVS     R1,#+1
        MOVS     R0,#+0
        BL       Oled_Putstr
//   84   Oled_Putstr(1,1,"car type"); Oled_Putnum(1,11,CAR_TYPE); 
        LDR.W    R2,??DataTable4_2
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       Oled_Putstr
        MOVS     R2,#+2
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       Oled_Putnum
//   85  // Oled_Putstr(1,1,"Press Key1: Display Parameters");
//   86  // Oled_Putstr(2,1,"Press Key2: Display Camera");
//   87  // Oled_Putstr(3,1,"Press Key3: Debug Parameters");
//   88   Oled_Putstr(6,1,"battery"); Oled_Putnum(6,11,battery);
        LDR.W    R2,??DataTable4_3
        MOVS     R1,#+1
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.W    R0,??DataTable4_4
        LDRSH    R2,[R0, #+0]
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+6
        BL       Oled_Putnum
//   89   Oled_Putstr(7,1,"car_state"); Oled_Putnum(7,11,car_state);
        LDR.W    R2,??DataTable4_5
        MOVS     R1,#+1
        MOVS     R0,#+7
        BL       Oled_Putstr
        LDR.W    R0,??DataTable4_6
        LDRB     R2,[R0, #+0]
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//   90 }
        POP      {R0,PC}          ;; return
//   91 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   92 void displayParameters()//menu==1
//   93 {
displayParameters:
        PUSH     {R4,LR}
        SUB      SP,SP,#+624
//   94    //按键下拉上拉功能
//   95   //最大行数需要在头文件中修改
//   96   static int start=0;
//   97   static int page=0;
//   98   Putboth outpair[Pages][Rows]={
//   99     {
//  100       {"road_state",road_state},
//  101       {"valid_row",valid_row}, 
//  102       {"battery",battery},      {"pit0 time",pit0_time},  {"pit1 time",pit1_time},  
//  103       {"servo",ServoOut},       {"mid_ave",mid_ave},       
//  104       {"car_state",car_state},
//  105       {"tacho0",tacho0},{"tacho1",tacho1},
//  106       {"motor_L",motor_L},{"motor_R",motor_R}
//  107 
//  108       //{"C.r",C.r},{"C.sign",C.sign}
//  109     },
//  110     { 
//  111       {"mid_ave_x",mid_ave},
//  112       {"mid[0]",road_B[0].mid},     {"mid[1]",road_B[1].mid},         {"mid[2]",road_B[2].mid}, 
//  113       {"mid[3]",road_B[3].mid},     {"mid[4]",road_B[4].mid},         {"mid[5]",road_B[5].mid}, 
//  114       {"mid[6]",road_B[6].mid},     {"mid[7]",road_B[7].mid},         {"mid[8]",road_B[8].mid},
//  115       {"mid[9]",road_B[9].mid},     {"mid[10]",road_B[10].mid},       {"mid[11]",road_B[11].mid},
//  116       {"mid[12]",road_B[12].mid},   {"mid[13]",road_B[13].mid},       {"mid[14]",road_B[14].mid},
//  117       {"mid[15]",road_B[15].mid},   {"mid[16]",road_B[16].mid},       {"mid[17]",road_B[17].mid},
//  118       {"mid[18]",road_B[18].mid},   {"mid[19]",road_B[19].mid},       {"mid[20]",road_B[20].mid},
//  119       {"mid[21]",road_B[21].mid},   {"mid[22]",road_B[22].mid},       {"mid[23]",road_B[23].mid}, 
//  120       {"mid[24]",road_B[24].mid}
//  121     },
//  122     {
//  123           
//  124       {"weight[road_state][0]",weight[road_state][0]*10},      {"weight[road_state][1]",weight[road_state][1]*10},        {"weight[road_state][2]",weight[road_state][2]*10},
//  125       {"weight[road_state][3]",weight[road_state][3]*10},      {"weight[road_state][4]",weight[road_state][4]*10},        {"weight[road_state][5]",weight[road_state][5]*10},
//  126       {"weight[road_state][6]",weight[road_state][6]*10},      {"weight[road_state][7]",weight[road_state][6]*10},        {"weight[road_state][8]",weight[road_state][8]*10},
//  127       {"weight[road_state][9]",weight[road_state][9]*10},          {"",0}
//  128     }
//  129    /* {
//  130       {"cam_buf[60]",cam_buffer[60][60]},
//  131       {"cam_buf[55]",cam_buffer[55][60]},
//  132       {"cam_buf[50]",cam_buffer[50][60]},  
//  133       {"cam_buf[45]",cam_buffer[45][60]},
//  134       {"cam_buf[40]",cam_buffer[40][60]},
//  135       {"cam_buf[35]",cam_buffer[35][60]},  
//  136       {"cam_buf[30]",cam_buffer[30][60]},
//  137       {"cam_buf[25]",cam_buffer[25][60]},
//  138       {"cam_buf[20]",cam_buffer[20][60]},
//  139       {"cam_buf[15]",cam_buffer[15][60]},
//  140       {"cam_buf[10]",cam_buffer[10][60]}
//  141     }*/
//  142   };
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable4_7
        MOV      R2,#+624
        BL       __aeabi_memcpy4
        LDR.W    R0,??DataTable4_8
        LDRB     R0,[R0, #+0]
        STRH     R0,[SP, #+4]
        LDR.W    R0,??DataTable4_9
        LDR      R0,[R0, #+0]
        STRH     R0,[SP, #+12]
        LDR.W    R0,??DataTable4_4
        LDRSH    R0,[R0, #+0]
        STRH     R0,[SP, #+20]
        LDR.W    R0,??DataTable4_10
        LDR      R0,[R0, #+0]
        STRH     R0,[SP, #+28]
        LDR.W    R0,??DataTable4_11
        LDR      R0,[R0, #+0]
        STRH     R0,[SP, #+36]
        LDR.W    R0,??DataTable4_12
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+44]
        LDR.W    R0,??DataTable4_13
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+52]
        LDR.W    R0,??DataTable4_6
        LDRB     R0,[R0, #+0]
        STRH     R0,[SP, #+60]
        LDR.W    R0,??DataTable4_14
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+68]
        LDR.W    R0,??DataTable4_15
        LDRH     R0,[R0, #+0]
        STRH     R0,[SP, #+76]
        LDR.W    R0,??DataTable4_16
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+84]
        LDR.W    R0,??DataTable4_17
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+92]
        LDR.W    R0,??DataTable4_13
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+212]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+8]
        STRH     R0,[SP, #+220]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+20]
        STRH     R0,[SP, #+228]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+32]
        STRH     R0,[SP, #+236]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+44]
        STRH     R0,[SP, #+244]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+56]
        STRH     R0,[SP, #+252]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+68]
        STRH     R0,[SP, #+260]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+80]
        STRH     R0,[SP, #+268]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+92]
        STRH     R0,[SP, #+276]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+104]
        STRH     R0,[SP, #+284]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+116]
        STRH     R0,[SP, #+292]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+128]
        STRH     R0,[SP, #+300]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+140]
        STRH     R0,[SP, #+308]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+152]
        STRH     R0,[SP, #+316]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+164]
        STRH     R0,[SP, #+324]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+176]
        STRH     R0,[SP, #+332]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+188]
        STRH     R0,[SP, #+340]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+200]
        STRH     R0,[SP, #+348]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+212]
        STRH     R0,[SP, #+356]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+224]
        STRH     R0,[SP, #+364]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+236]
        STRH     R0,[SP, #+372]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+248]
        STRH     R0,[SP, #+380]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+260]
        STRH     R0,[SP, #+388]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+272]
        STRH     R0,[SP, #+396]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+284]
        STRH     R0,[SP, #+404]
        LDR.W    R0,??DataTable4_18
        LDR      R0,[R0, #+296]
        STRH     R0,[SP, #+412]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+420]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+4]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+428]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+8]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+436]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+12]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+444]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+16]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+452]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+20]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+460]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+24]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+468]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+24]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+476]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+32]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+484]
        LDR.W    R0,??DataTable4_19
        LDR.W    R1,??DataTable4_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R1,[R0, #+36]
        LDR.W    R0,??DataTable4_20  ;; 0x41200000
        BL       __aeabi_fmul
        BL       __aeabi_f2iz
        STRH     R0,[SP, #+492]
//  143   
//  144   for (int i=1;i<=7;i++)                           
        MOVS     R4,#+1
        B.N      ??displayParameters_0
//  145   { 
//  146     Oled_Putstr(i,0,outpair[page][start+i-1].category); Oled_Putnum(i,11,outpair[page][start+i-1].data);
??displayParameters_1:
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable4_21
        LDR      R1,[R1, #+0]
        MOVS     R2,#+208
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable4_22
        LDR      R1,[R1, #+0]
        ADDS     R1,R4,R1
        ADDS     R0,R0,R1, LSL #+3
        LDR      R2,[R0, #-8]
        MOVS     R1,#+0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_Putstr
        ADD      R0,SP,#+0
        LDR.W    R1,??DataTable4_21
        LDR      R1,[R1, #+0]
        MOVS     R2,#+208
        MLA      R0,R2,R1,R0
        LDR.W    R1,??DataTable4_22
        LDR      R1,[R1, #+0]
        ADDS     R1,R4,R1
        ADDS     R0,R0,R1, LSL #+3
        LDRSH    R2,[R0, #-4]
        MOVS     R1,#+11
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       Oled_Putnum
//  147   }
        ADDS     R4,R4,#+1
??displayParameters_0:
        CMP      R4,#+8
        BLT.N    ??displayParameters_1
//  148   
//  149   if(Key2() && Key3() && Key1())  flag_down=0;//检测是否按下key2 key3
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BEQ.N    ??displayParameters_2
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BEQ.N    ??displayParameters_2
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BEQ.N    ??displayParameters_2
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  150   //改变OLED显示内容
//  151   //上下拉
//  152   if (!Key3() && Key1() && start<Rows-7 ){ start++; flag_down=1; }//下拉
??displayParameters_2:
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??displayParameters_3
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BEQ.N    ??displayParameters_3
        LDR.W    R0,??DataTable4_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+19
        BGE.N    ??displayParameters_3
        LDR.W    R0,??DataTable4_22
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable4_22
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  153   if (!Key2() && Key1() && start>0 ){ start--; flag_down=1; }//上拉
??displayParameters_3:
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??displayParameters_4
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BEQ.N    ??displayParameters_4
        LDR.W    R0,??DataTable4_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??displayParameters_4
        LDR.W    R0,??DataTable4_22
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.W    R1,??DataTable4_22
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  154   //下一页
//  155   if(!Key1() && flag_down==0)
??displayParameters_4:
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??displayParameters_5
        LDR.W    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayParameters_5
//  156   {
//  157     page++;
        LDR.W    R0,??DataTable4_21
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable4_21
        STR      R0,[R1, #+0]
//  158     page%=Pages;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable4_21
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable4_21
        LDR      R2,[R2, #+0]
        SDIV     R2,R2,R0
        MLS      R0,R0,R2,R1
        LDR.W    R1,??DataTable4_21
        STR      R0,[R1, #+0]
//  159     start=0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4_22
        STR      R0,[R1, #+0]
//  160     flag_down=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  161   }
//  162 }
??displayParameters_5:
        ADD      SP,SP,#+624
        POP      {R4,PC}          ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??start:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??page:
        DS8 4
//  163 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  164 void displayCamera()//menu==2
//  165 {
displayCamera:
        PUSH     {R7,LR}
//  166 //  if(!Key1())
//  167     drawCam(isWhite);
        ADR.W    R0,isWhite
        BL       drawCam
//  168  // else
//  169   //  drawCam2(isWhite);
//  170 }
        POP      {R0,PC}          ;; return
//  171 
//  172 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  173 void displayDebug()//menu==3
//  174 {
displayDebug:
        PUSH     {R7,LR}
//  175   static int para_state=0;
//  176   if(Key1() && Key2() && Key3()) flag_down=0;
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BEQ.N    ??displayDebug_0
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BEQ.N    ??displayDebug_0
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BEQ.N    ??displayDebug_0
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
        B.N      ??displayDebug_1
//  177   else if(!Key1() && flag_down==0)
??displayDebug_0:
        LDR.W    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+8,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_1
        LDR.W    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_1
//  178   {
//  179     para_state++;
        LDR.W    R0,??DataTable4_25
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable4_25
        STR      R0,[R1, #+0]
//  180     para_state%=4;
        LDR.W    R0,??DataTable4_25
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        SDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        LDR.W    R0,??DataTable4_25
        STR      R2,[R0, #+0]
//  181     flag_down=1;
        MOVS     R0,#+1
        LDR.W    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  182   }
//  183   switch(para_state)
??displayDebug_1:
        LDR.W    R0,??DataTable4_25
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??displayDebug_2
        CMP      R0,#+2
        BEQ.W    ??displayDebug_3
        BCC.N    ??displayDebug_4
        CMP      R0,#+3
        BEQ.W    ??displayDebug_5
        B.N      ??displayDebug_6
//  184   {
//  185   /*  case 0:
//  186     Oled_Putstr(6,0,"Debugging CAM_HOLE_ROW"); Oled_Putnum(7,11,CAM_HOLE_ROW);
//  187     if(!Key2() && flag_down==0) {CAM_HOLE_ROW+=1;flag_down=1;}
//  188     if(!Key3() && flag_down==0) {CAM_HOLE_ROW-=1;flag_down=1;}
//  189     break;
//  190   case 1:
//  191     Oled_Putstr(6,0,"Debugging ROAD_OBST_ROW"); Oled_Putnum(7,11,ROAD_OBST_ROW);
//  192     if(!Key2() && flag_down==0) {ROAD_OBST_ROW+=1;flag_down=1;}
//  193     if(!Key3() && flag_down==0) {ROAD_OBST_ROW-=1;flag_down=1;}
//  194     break;
//  195   case 2:
//  196     Oled_Putstr(6,0,"Debugging OBSTACLE_THR"); Oled_Putnum(7,11,OBSTACLE_THR);
//  197     if(!Key2() && flag_down==0) {OBSTACLE_THR+=1;flag_down=1;}
//  198     if(!Key3() && flag_down==0) {OBSTACLE_THR-=1;flag_down=1;}
//  199     break;*/
//  200   case 0:
//  201     Oled_Putstr(6,0,"Debugging dir.kp"); Oled_Putnum(7,11,debug_dir.kp*10);
??displayDebug_2:
        LDR.W    R2,??DataTable4_26
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.W    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable4_28  ;; 0x40240000
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//  202     if(!Key2() && flag_down==0) {debug_dir.kp+=0.1;flag_down=1;}
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_7
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_7
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable4_29  ;; 0x9999999a
        LDR.N    R1,??DataTable4_30  ;; 0x3fb99999
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable4_27
        STRD     R0,R1,[R2, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  203     if(!Key3() && flag_down==0) {debug_dir.kp-=0.1;flag_down=1;}
??displayDebug_7:
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_8
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_8
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+0]
        LDR.N    R0,??DataTable4_29  ;; 0x9999999a
        LDR.N    R1,??DataTable4_31  ;; 0xbfb99999
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable4_27
        STRD     R0,R1,[R2, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  204     break;
??displayDebug_8:
        B.N      ??displayDebug_9
//  205   case 1:
//  206     Oled_Putstr(6,0,"Debugging dir.kd"); Oled_Putnum(7,11,debug_dir.kd*10);
??displayDebug_4:
        LDR.N    R2,??DataTable4_32
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+16]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_28  ;; 0x40240000
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//  207     if(!Key2() && flag_down==0) {debug_dir.kd+=0.1;flag_down=1;}
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_10
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_10
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+16]
        LDR.N    R0,??DataTable4_29  ;; 0x9999999a
        LDR.N    R1,??DataTable4_30  ;; 0x3fb99999
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable4_27
        STRD     R0,R1,[R2, #+16]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  208     if(!Key3() && flag_down==0) {debug_dir.kd-=0.1;flag_down=1;}
??displayDebug_10:
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_11
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_11
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+16]
        LDR.N    R0,??DataTable4_29  ;; 0x9999999a
        LDR.N    R1,??DataTable4_31  ;; 0xbfb99999
        BL       __aeabi_dadd
        LDR.N    R2,??DataTable4_27
        STRD     R0,R1,[R2, #+16]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  209     break;
??displayDebug_11:
        B.N      ??displayDebug_9
//  210   case 2:
//  211     Oled_Putstr(6,0,"Debugging MaxSpeed"); Oled_Putnum(7,11,debug_speed);
??displayDebug_3:
        LDR.N    R2,??DataTable4_33
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_34
        LDR      R2,[R0, #+0]
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//  212     if(!Key2() && flag_down==0) {debug_speed+=1;flag_down=1;}
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_12
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_12
        LDR.N    R0,??DataTable4_34
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_34
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  213     if(!Key3() && flag_down==0 && MAX_SPEED+debug_speed>MIN_SPEED+2) {debug_speed-=1;flag_down=1;}
??displayDebug_12:
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_13
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_13
        LDR.N    R0,??DataTable4_34
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+20
        CMP      R0,#+15
        BLT.N    ??displayDebug_13
        LDR.N    R0,??DataTable4_34
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable4_34
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  214     break;
??displayDebug_13:
        B.N      ??displayDebug_9
//  215   case 3:
//  216     Oled_Putstr(6,0,"Debugging Margin"); Oled_Putnum(7,11,margin);
??displayDebug_5:
        LDR.N    R2,??DataTable4_35
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_36
        LDR      R2,[R0, #+0]
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+7
        BL       Oled_Putnum
//  217     if(!Key2() && flag_down==0) {margin+=1;flag_down=1;}
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+9,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_14
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_14
        LDR.N    R0,??DataTable4_36
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable4_36
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  218     if(!Key3() && flag_down==0 && margin>0) {margin-=1;flag_down=1;}
??displayDebug_14:
        LDR.N    R0,??DataTable4_23  ;; 0x400ff010
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+10,#+1
        CMP      R0,#+0
        BNE.N    ??displayDebug_15
        LDR.N    R0,??DataTable4_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??displayDebug_15
        LDR.N    R0,??DataTable4_36
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??displayDebug_15
        LDR.N    R0,??DataTable4_36
        LDR      R0,[R0, #+0]
        SUBS     R0,R0,#+1
        LDR.N    R1,??DataTable4_36
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        LDR.N    R1,??DataTable4_24
        STRB     R0,[R1, #+0]
//  219     break;
??displayDebug_15:
        B.N      ??displayDebug_9
//  220 /*  case 4:
//  221     Oled_Putstr(6,0,"Debugging c1"); Oled_Putnum(7,11,c1);
//  222     if(!Key2() && flag_down==0) {c1+=1;flag_down=1;}
//  223     if(!Key3() && flag_down==0) {c1-=1;flag_down=1;}
//  224     break;
//  225   case 5:
//  226     Oled_Putstr(6,0,"Debugging c2"); Oled_Putnum(7,11,c2);
//  227     if(!Key2() && flag_down==0) {c2+=1;flag_down=1;}
//  228     if(!Key3() && flag_down==0) {c2-=1;flag_down=1;}
//  229     break;
//  230   case 6:
//  231     Oled_Putstr(6,0,"Debugging c3"); Oled_Putnum(7,11,c3);
//  232     if(!Key2() && flag_down==0) {c3+=1;flag_down=1;}
//  233     if(!Key3() && flag_down==0) {c3-=1;flag_down=1;}
//  234     break;*/
//  235   default:break;
//  236   }
//  237   
//  238   Oled_Putstr(0,0,"dir.kp*10"); Oled_Putnum(0,11,(Dir_Kp+debug_dir.kp)*10);
??displayDebug_6:
??displayDebug_9:
        LDR.N    R2,??DataTable4_37
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_38  ;; 0x40100000
        BL       __aeabi_dadd
        MOVS     R2,#+0
        LDR.N    R3,??DataTable4_28  ;; 0x40240000
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+0
        BL       Oled_Putnum
//  239   Oled_Putstr(1,0,"dir.kd*10"); Oled_Putnum(1,11,(Dir_Kd+debug_dir.kd)*10);
        LDR.N    R2,??DataTable4_39
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_27
        LDRD     R2,R3,[R0, #+16]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable4_40  ;; 0x40080000
        BL       __aeabi_dadd
        MOVS     R2,#+0
        LDR.N    R3,??DataTable4_28  ;; 0x40240000
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        MOVS     R2,R0
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       Oled_Putnum
//  240   Oled_Putstr(2,0,"MaxSpeed"); Oled_Putnum(2,11,MAX_SPEED+debug_speed);
        LDR.N    R2,??DataTable4_41
        MOVS     R1,#+0
        MOVS     R0,#+2
        BL       Oled_Putstr
        LDR.N    R0,??DataTable4_34
        LDR      R0,[R0, #+0]
        ADDS     R2,R0,#+20
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        MOVS     R1,#+11
        MOVS     R0,#+2
        BL       Oled_Putnum
//  241     
//  242 }
        POP      {R0,PC}          ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??para_state:
        DS8 4
//  243 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  244 void drawCam(bool(*isTarget)(u8 x)) {
drawCam:
        PUSH     {R4-R9,LR}
        SUBW     SP,SP,#+1028
        MOVS     R4,R0
//  245   int row, col, i;
//  246   u8 buf[1024];
//  247   u8 *p = buf;
        ADD      R5,SP,#+4
//  248     
//  249   for (row = IMG_ROWS-1; row >= 0; row -= 8) {
        MOVS     R6,#+63
        B.N      ??drawCam_0
??drawCam_1:
        SUBS     R6,R6,#+8
??drawCam_0:
        CMP      R6,#+0
        BMI.N    ??drawCam_2
//  250     for (col = IMG_COLS-1; col >= 0 ; col--) {
        MOVS     R7,#+127
        B.N      ??drawCam_3
//  251       u8 tmp = 0;
//  252       for (i = 0; i < 8; i++) {
//  253         tmp <<= 1;
??drawCam_4:
        LSLS     R9,R9,#+1
//  254         if (isTarget(cam_buffer[row-i][col]))
        LDR.N    R0,??DataTable4_42
        SUBS     R1,R6,R8
        MOVS     R2,#+155
        MLA      R0,R2,R1,R0
        LDRB     R0,[R7, R0]
        BLX      R4
        CMP      R0,#+0
        BEQ.N    ??drawCam_5
//  255           tmp |= 0x01;
        ORRS     R9,R9,#0x1
//  256       }
??drawCam_5:
        ADDS     R8,R8,#+1
??drawCam_6:
        CMP      R8,#+8
        BLT.N    ??drawCam_4
//  257       *p++ = tmp;
        STRB     R9,[R5, #+0]
        ADDS     R5,R5,#+1
        SUBS     R7,R7,#+1
??drawCam_3:
        CMP      R7,#+0
        BMI.N    ??drawCam_1
        MOVS     R9,#+0
        MOVS     R8,#+0
        B.N      ??drawCam_6
//  258     }
//  259   }
//  260   Oled_DrawBMP(0, 0, 128, 64, buf);
??drawCam_2:
        ADD      R0,SP,#+4
        STR      R0,[SP, #+0]
        MOVS     R3,#+64
        MOVS     R2,#+128
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       Oled_DrawBMP
//  261 }
        ADDW     SP,SP,#+1028
        POP      {R4-R9,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     oled_menu

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     ?_0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     ?_1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     ?_2

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     battery

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     ?_3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     car_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     ?_51

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     road_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     valid_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     pit0_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     pit1_time

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     ServoOut

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     mid_ave

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_14:
        DC32     tacho0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_15:
        DC32     tacho1

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_16:
        DC32     motor_L

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_17:
        DC32     motor_R

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_18:
        DC32     road_B

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_19:
        DC32     weight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_20:
        DC32     0x41200000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_21:
        DC32     ??page

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_22:
        DC32     ??start

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_23:
        DC32     0x400ff010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_24:
        DC32     flag_down

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_25:
        DC32     ??para_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_26:
        DC32     ?_52

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_27:
        DC32     debug_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_28:
        DC32     0x40240000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_29:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_30:
        DC32     0x3fb99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_31:
        DC32     0xbfb99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_32:
        DC32     ?_53

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_33:
        DC32     ?_54

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_34:
        DC32     debug_speed

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_35:
        DC32     ?_55

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_36:
        DC32     margin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_37:
        DC32     ?_56

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_38:
        DC32     0x40100000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_39:
        DC32     ?_57

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_40:
        DC32     0x40080000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_41:
        DC32     ?_58

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_42:
        DC32     cam_buffer
//  262 /*
//  263 void drawCam2(bool(*isTarget)(u8 x)) {
//  264   int row, col, i;
//  265   u8 buf[1024];
//  266   u8 *p = buf;
//  267     
//  268   for (row = IMG_ROWS-1; row >= 0; row -= 8) {
//  269     for (col = IMG_COLS-1; col >= 0 ; col--) {
//  270       u8 tmp = 0;
//  271       for (i = 0; i < 8; i++) {
//  272         tmp <<= 1;
//  273         if (isTarget(cam_buffer2[row-i][col]))
//  274           tmp |= 0x01;
//  275       }
//  276       *p++ = tmp;
//  277     }
//  278   }
//  279   Oled_DrawBMP(0, 0, 128, 64, buf);
//  280 }
//  281 */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  282 bool isWhite(u8 x) {     //白色阈值，场地理想后好像没什么用
//  283   return x > 70;
isWhite:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+71
        BLT.N    ??isWhite_0
        MOVS     R0,#+1
        B.N      ??isWhite_1
??isWhite_0:
        MOVS     R0,#+0
??isWhite_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  284 }
//  285 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  286 void UI_Graph(u8* data){
//  287   
//  288 }
UI_Graph:
        BX       LR               ;; return

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
        DC8 "<Start-Menu>"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_1:
        DATA
        DC8 "car type"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_2:
        DATA
        DC8 "battery"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_3:
        DATA
        DC8 "car_state"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_4:
        DATA
        DC8 "road_state"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_5:
        DATA
        DC8 "valid_row"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_6:
        DATA
        DC8 "pit0 time"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_7:
        DATA
        DC8 "pit1 time"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_8:
        DATA
        DC8 "servo"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_9:
        DATA
        DC8 "mid_ave"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_10:
        DATA
        DC8 "tacho0"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_11:
        DATA
        DC8 "tacho1"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_12:
        DATA
        DC8 "motor_L"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_13:
        DATA
        DC8 "motor_R"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_14:
        DATA
        DC8 "mid_ave_x"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_15:
        DATA
        DC8 "mid[0]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_16:
        DATA
        DC8 "mid[1]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_17:
        DATA
        DC8 "mid[2]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_18:
        DATA
        DC8 "mid[3]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_19:
        DATA
        DC8 "mid[4]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_20:
        DATA
        DC8 "mid[5]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_21:
        DATA
        DC8 "mid[6]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_22:
        DATA
        DC8 "mid[7]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_23:
        DATA
        DC8 "mid[8]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_24:
        DATA
        DC8 "mid[9]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_25:
        DATA
        DC8 "mid[10]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_26:
        DATA
        DC8 "mid[11]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_27:
        DATA
        DC8 "mid[12]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_28:
        DATA
        DC8 "mid[13]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_29:
        DATA
        DC8 "mid[14]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_30:
        DATA
        DC8 "mid[15]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_31:
        DATA
        DC8 "mid[16]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_32:
        DATA
        DC8 "mid[17]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_33:
        DATA
        DC8 "mid[18]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_34:
        DATA
        DC8 "mid[19]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_35:
        DATA
        DC8 "mid[20]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_36:
        DATA
        DC8 "mid[21]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_37:
        DATA
        DC8 "mid[22]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_38:
        DATA
        DC8 "mid[23]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_39:
        DATA
        DC8 "mid[24]"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_40:
        DATA
        DC8 "weight[road_state][0]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_41:
        DATA
        DC8 "weight[road_state][1]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_42:
        DATA
        DC8 "weight[road_state][2]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_43:
        DATA
        DC8 "weight[road_state][3]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_44:
        DATA
        DC8 "weight[road_state][4]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_45:
        DATA
        DC8 "weight[road_state][5]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_46:
        DATA
        DC8 "weight[road_state][6]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_47:
        DATA
        DC8 "weight[road_state][7]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_48:
        DATA
        DC8 "weight[road_state][8]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_49:
        DATA
        DC8 "weight[road_state][9]"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(0)
?_50:
        DATA
        DC8 ""

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_51:
        DATA
        DC32 ?_4
        DC16 0
        DC8 0, 0
        DC32 ?_5
        DC16 0
        DC8 0, 0
        DC32 ?_2
        DC16 0
        DC8 0, 0
        DC32 ?_6
        DC16 0
        DC8 0, 0
        DC32 ?_7
        DC16 0
        DC8 0, 0
        DC32 ?_8
        DC16 0
        DC8 0, 0
        DC32 ?_9
        DC16 0
        DC8 0, 0
        DC32 ?_3
        DC16 0
        DC8 0, 0
        DC32 ?_10
        DC16 0
        DC8 0, 0
        DC32 ?_11
        DC16 0
        DC8 0, 0
        DC32 ?_12
        DC16 0
        DC8 0, 0
        DC32 ?_13
        DC16 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC32 ?_14
        DC16 0
        DC8 0, 0
        DC32 ?_15
        DC16 0
        DC8 0, 0
        DC32 ?_16
        DC16 0
        DC8 0, 0
        DC32 ?_17
        DC16 0
        DC8 0, 0
        DC32 ?_18
        DC16 0
        DC8 0, 0
        DC32 ?_19
        DC16 0
        DC8 0, 0
        DC32 ?_20
        DC16 0
        DC8 0, 0
        DC32 ?_21
        DC16 0
        DC8 0, 0
        DC32 ?_22
        DC16 0
        DC8 0, 0
        DC32 ?_23
        DC16 0
        DC8 0, 0
        DC32 ?_24
        DC16 0
        DC8 0, 0
        DC32 ?_25
        DC16 0
        DC8 0, 0
        DC32 ?_26
        DC16 0
        DC8 0, 0
        DC32 ?_27
        DC16 0
        DC8 0, 0
        DC32 ?_28
        DC16 0
        DC8 0, 0
        DC32 ?_29
        DC16 0
        DC8 0, 0
        DC32 ?_30
        DC16 0
        DC8 0, 0
        DC32 ?_31
        DC16 0
        DC8 0, 0
        DC32 ?_32
        DC16 0
        DC8 0, 0
        DC32 ?_33
        DC16 0
        DC8 0, 0
        DC32 ?_34
        DC16 0
        DC8 0, 0
        DC32 ?_35
        DC16 0
        DC8 0, 0
        DC32 ?_36
        DC16 0
        DC8 0, 0
        DC32 ?_37
        DC16 0
        DC8 0, 0
        DC32 ?_38
        DC16 0
        DC8 0, 0
        DC32 ?_39
        DC16 0
        DC8 0, 0
        DC32 ?_40
        DC16 0
        DC8 0, 0
        DC32 ?_41
        DC16 0
        DC8 0, 0
        DC32 ?_42
        DC16 0
        DC8 0, 0
        DC32 ?_43
        DC16 0
        DC8 0, 0
        DC32 ?_44
        DC16 0
        DC8 0, 0
        DC32 ?_45
        DC16 0
        DC8 0, 0
        DC32 ?_46
        DC16 0
        DC8 0, 0
        DC32 ?_47
        DC16 0
        DC8 0, 0
        DC32 ?_48
        DC16 0
        DC8 0, 0
        DC32 ?_49
        DC16 0
        DC8 0, 0
        DC32 ?_50
        DC16 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        DC8 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_52:
        DATA
        DC8 "Debugging dir.kp"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_53:
        DATA
        DC8 "Debugging dir.kd"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_54:
        DATA
        DC8 "Debugging MaxSpeed"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_55:
        DATA
        DC8 "Debugging Margin"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_56:
        DATA
        DC8 "dir.kp*10"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_57:
        DATA
        DC8 "dir.kd*10"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
?_58:
        DATA
        DC8 "MaxSpeed"
        DC8 0, 0, 0

        END
//  289 
//  290 
//  291 
//  292 
//  293 
//  294 
//  295 
//  296 
//  297 
//  298 
//  299 
//  300 
//  301 
//  302 
//  303 
//  304 
// 
//    14 bytes in section .bss
// 1 337 bytes in section .rodata
// 2 364 bytes in section .text
// 
// 2 364 bytes of CODE  memory
// 1 337 bytes of CONST memory
//    14 bytes of DATA  memory
//
//Errors: none
//Warnings: 18
