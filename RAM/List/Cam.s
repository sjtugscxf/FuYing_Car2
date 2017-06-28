///////////////////////////////////////////////////////////////////////////////
//
// IAR ANSI C/C++ Compiler V7.20.2.7424/W32 for ARM       28/Jun/2017  11:22:42
// Copyright 1999-2014 IAR Systems AB.
//
//    Cpu mode     =  thumb
//    Endian       =  little
//    Source file  =  D:\GitHub_pository\FuYing_Car2\source\Cam.c
//    Command line =  
//        D:\GitHub_pository\FuYing_Car2\source\Cam.c -D LPLD_K60 -lCN
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
//    List file    =  D:\GitHub_pository\FuYing_Car2\RAM\List\Cam.s
//
///////////////////////////////////////////////////////////////////////////////

        #define SHT_PROGBITS 0x1

        EXTERN L
        EXTERN PWM
        EXTERN R
        EXTERN Servo_Output
        EXTERN UART_SendChar
        EXTERN __aeabi_cdcmpeq
        EXTERN __aeabi_cdrcmple
        EXTERN __aeabi_cfcmple
        EXTERN __aeabi_d2f
        EXTERN __aeabi_d2iz
        EXTERN __aeabi_dadd
        EXTERN __aeabi_ddiv
        EXTERN __aeabi_dmul
        EXTERN __aeabi_dsub
        EXTERN __aeabi_f2d
        EXTERN __aeabi_f2iz
        EXTERN __aeabi_fadd
        EXTERN __aeabi_fdiv
        EXTERN __aeabi_fmul
        EXTERN __aeabi_fsub
        EXTERN __aeabi_i2d
        EXTERN __aeabi_i2f
        EXTERN sqrt

        PUBLIC C
        PUBLIC CAM_HOLE_ROW
        PUBLIC Cam_Algorithm
        PUBLIC Cam_B
        PUBLIC Cam_B_Init
        PUBLIC Cam_Init
        PUBLIC DMA0_IRQHandler
        PUBLIC OBSTACLE_THR
        PUBLIC PORTC_IRQHandler
        PUBLIC ROAD_OBST_ROW
        PUBLIC `c1`
        PUBLIC `c2`
        PUBLIC `c3`
        PUBLIC cam_buffer
        PUBLIC cam_buffer_safe
        PUBLIC cam_row
        PUBLIC car_state
        PUBLIC constrain
        PUBLIC constrainInt
        PUBLIC curvatureL
        PUBLIC curvatureR
        PUBLIC debug_dir
        PUBLIC debug_speed
        PUBLIC getR
        PUBLIC getSlope_
        PUBLIC img_row
        PUBLIC is_stop_line
        PUBLIC margin
        PUBLIC mid_ave
        PUBLIC motor_L
        PUBLIC motor_R
        PUBLIC remote_state
        PUBLIC road_B
        PUBLIC road_state
        PUBLIC slope
        PUBLIC slope_mid
        PUBLIC test
        PUBLIC theta
        PUBLIC theta_d
        PUBLIC valid_row
        PUBLIC valid_row_thr
        PUBLIC weight
        PUBLIC x
        PUBLIC y

// D:\GitHub_pository\FuYing_Car2\source\Cam.c
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
        LDR.W    R2,??DataTable6  ;; 0xe000ed18
        SXTB     R0,R0            ;; SignExt  R0,R0,#+24,#+24
        ANDS     R0,R0,#0xF
        ADDS     R0,R0,R2
        STRB     R1,[R0, #-4]
        B.N      ??NVIC_SetPriority_1
??NVIC_SetPriority_0:
        LSLS     R1,R1,#+4
        LDR.W    R2,??DataTable9_1  ;; 0xe000e400
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
//   10 // ====== Variables ======
//   11 // ---- Global ----

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12 u8 cam_buffer_safe[BLACK_WIDTH*2];
cam_buffer_safe:
        DS8 56

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 u8 cam_buffer[IMG_ROWS][IMG_COLS+BLACK_WIDTH];   //64*155，把黑的部分舍去是59*128
cam_buffer:
        DS8 9920

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 Road road_B[ROAD_SIZE];//由近及远存放
road_B:
        DS8 300

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 s8 slope_mid[ROAD_SIZE];//
slope_mid:
        DS8 28

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   16 s8 curvatureL[ROAD_SIZE],curvatureR[ROAD_SIZE];
curvatureL:
        DS8 28

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
curvatureR:
        DS8 28

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   17 float mid_ave;//road中点加权后的值
mid_ave:
        DS8 4
//   18 //float  weight[10] = {1,1,1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744}; //2.296};//, 1.454};//上一次的权值
//   19 //float weight[10] = {1.04,1.14,1.41,2.01,3.03,4.35,5.52,6,5.52,4.35};//待测试

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20 float weight[4][10] ={ {0,0,0,0,0,0,0,0,0,0},
weight:
        DATA
        DC32 0H, 0H, 0H, 0H, 0H, 0H, 0H, 0H, 0H, 0H, 3F800000H, 3F800000H
        DC32 3F800000H, 3F800000H, 3F800000H, 3F800000H, 3F800000H, 3F800000H
        DC32 3F800000H, 3F800000H, 3F800000H, 3F83D70AH, 3F91EB85H, 3FC51EB8H
        DC32 4023D70AH, 408947AEH, 40C51EB8H, 40E00000H, 40C51EB8H, 408947AEH
        DC32 3F8F1AA0H, 3FBA1CACH, 4012F1AAH, 406F9DB2H, 40A9BA5EH, 40C00000H
        DC32 40A9BA5EH, 406F9DB2H, 4012F1AAH, 3FBA1CACH
//   21                         {1,1,1,1,1,1,1,1,1,1},
//   22                         {1.00,1.03,1.14,1.54,2.56,               4.29,6.16,7.00,6.16,4.29},
//   23                         {1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454}};

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 int valid_row=0;//与有效行相关，未有效识别
valid_row:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   25 int valid_row_thr=10;//有效行阈值
valid_row_thr:
        DATA
        DC32 10

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   26 u8 car_state=0;//智能车状态标志 0：停止  1：测试舵机  2：正常巡线
car_state:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   27 u8 remote_state = 0;//远程控制
remote_state:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   28 u8 road_state = 0;//前方道路状态 1、直道   2、弯道  3、环岛  4、障碍
road_state:
        DS8 1
//   29                   //3 4 状态下权重拉近
//   30                   //2 状态下减速
//   31 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   32 float motor_L=MIN_SPEED;
motor_L:
        DATA
        DC32 41400000H

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   33 float motor_R=MIN_SPEED;
motor_R:
        DATA
        DC32 41400000H
//   34 
//   35 //OLED调参

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   36 int debug_speed=0;
debug_speed:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   37 PIDInfo debug_dir;
debug_dir:
        DS8 56

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   38 int margin=30;
margin:
        DATA
        DC32 30

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   39 circle C;
C:
        DS8 8

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   40 int c1=15, c2=10, c3=5;
`c1`:
        DATA
        DC32 15

        SECTION `.data`:DATA:REORDER:NOROOT(2)
`c2`:
        DATA
        DC32 10

        SECTION `.data`:DATA:REORDER:NOROOT(2)
`c3`:
        DATA
        DC32 5
//   41 
//   42 //=====================

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   43 int CAM_HOLE_ROW=27; //用来向两边扫描检测黑洞·环岛的cam_buffer行位置
CAM_HOLE_ROW:
        DATA
        DC32 27

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   44 int ROAD_OBST_ROW=10; //用来检测障碍物的road_B行位置//不能太远，也不能太近
ROAD_OBST_ROW:
        DATA
        DC32 10

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   45 int OBSTACLE_THR=40;  //有障碍物时赛道宽度阈值
OBSTACLE_THR:
        DATA
        DC32 40
//   46 
//   47 
//   48 // ---- Local ----

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   49 u8 cam_row = 0, img_row = 0;
cam_row:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
img_row:
        DS8 1
//   50 
//   51 /*
//   52 //——————透视变换·变量——————
//   53 double matrix[4][4];
//   54 //int buffer[64][128];=cam_buffer
//   55 int former[8200][4];
//   56 int later[8200][4];
//   57 u8 cam_buffer2[64][128];//int buffer2[64][128];
//   58 int visited[64][128];
//   59 
//   60 //——————透视变换·函数——————
//   61 
//   62 void getMatrix(double fov, double aspect, double zn, double zf){
//   63     matrix[0][0] = 1 / (tan(fov * 0.5) *aspect) ;
//   64     matrix[1][1] = 1 / tan(fov * 0.5) ;
//   65     matrix[2][2] = zf / (zf - zn) ;
//   66     matrix[2][3] = 1.0;
//   67     matrix[3][2] = (zn * zf) / (zn - zf);
//   68     return;
//   69 }
//   70 
//   71 void linearization(){
//   72     int cnt = 0;
//   73     for (int i=0;i<64;i++){
//   74         for (int j=0;j<128;j++){
//   75             former[cnt][0] = i;
//   76             former[cnt][1] = j;
//   77             former[cnt][2] = cam_buffer[i][j];//buffer[i][j];
//   78             former[cnt][3] = 1;
//   79             cnt++;
//   80         }
//   81     }
//   82     return;
//   83 }
//   84 
//   85 void multiply(int k){
//   86     for (int i=0;i<4;i++){
//   87         later[k][i] = former[k][0]*matrix[0][i]+former[k][1]*matrix[1][i]+former[k][2]*matrix[2][i]+former[k][3]+matrix[3][i];
//   88     }
//   89     return;
//   90 }
//   91 
//   92 void matrixMultiply(){
//   93     for (int i=0;i<8192;i++){
//   94         multiply(i);
//   95     }
//   96     return;
//   97 }
//   98 
//   99 void getNewBuffer(){
//  100     for (int i=0;i<64;i++){
//  101         for (int j=0;j<128;j++){
//  102             cam_buffer2[i][j] = 0;
//  103         }
//  104     }
//  105     for (int i=0;i<8192;i++){
//  106         cam_buffer2[later[i][0]][later[i][1]] = later[i][2];
//  107     }
//  108     return;
//  109 }
//  110 */
//  111 
//  112 // ====== 
//  113 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  114 void Cam_Algorithm(){
Cam_Algorithm:
        PUSH     {R4,LR}
//  115   static u8 img_row_used = 0;
//  116   
//  117   while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
??Cam_Algorithm_0:
        LDR.W    R0,??DataTable7
        LDRB     R0,[R0, #+0]
        LDR.W    R1,??DataTable7_1
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+64
        SDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        CMP      R0,R3
        BEQ.N    ??Cam_Algorithm_0
//  118   
//  119   // -- Handle the row --  
//  120   
//  121   if (img_row_used >= BLACK_HEIGHT) {     //前5行黑的不要
        LDR.W    R0,??DataTable7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BLT.N    ??Cam_Algorithm_1
//  122     for (int col = 0; col < IMG_COLS; col++) {
        MOVS     R4,#+0
        B.N      ??Cam_Algorithm_2
//  123       u8 tmp = cam_buffer[img_row_used][col];
//  124       if(!SW1()) UART_SendChar(tmp < 0xfe ? tmp : 0xfd);
??Cam_Algorithm_3:
        MOVS     R0,#+253
??Cam_Algorithm_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       UART_SendChar
??Cam_Algorithm_5:
        ADDS     R4,R4,#+1
??Cam_Algorithm_2:
        CMP      R4,#+128
        BGE.N    ??Cam_Algorithm_6
        LDR.W    R0,??DataTable7_2
        LDR.W    R1,??DataTable7
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+155
        MLA      R0,R2,R1,R0
        LDRB     R0,[R4, R0]
        LDR.W    R1,??DataTable9_2  ;; 0x400ff090
        LDR      R1,[R1, #+0]
        UBFX     R1,R1,#+4,#+1
        CMP      R1,#+0
        BNE.N    ??Cam_Algorithm_5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+254
        BGE.N    ??Cam_Algorithm_3
        B.N      ??Cam_Algorithm_4
//  125     }
//  126    if(!SW1()) UART_SendChar(0xfe);//0xfe->纯参数读取溢出
??Cam_Algorithm_6:
        LDR.W    R0,??DataTable9_2  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BNE.N    ??Cam_Algorithm_1
        MOVS     R0,#+254
        BL       UART_SendChar
//  127   }
//  128   
//  129   //  -- The row is used --
//  130   img_row_used++;
??Cam_Algorithm_1:
        LDR.W    R0,??DataTable7
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable7
        STRB     R0,[R1, #+0]
//  131   if (img_row_used == IMG_ROWS) {    //一帧图像完行归零，控制算法启动，进入AI_Run
        LDR.W    R0,??DataTable7
        LDRB     R0,[R0, #+0]
        CMP      R0,#+64
        BNE.N    ??Cam_Algorithm_7
//  132     img_row_used = 0;
        MOVS     R0,#+0
        LDR.W    R1,??DataTable7
        STRB     R0,[R1, #+0]
//  133 
//  134     if(!SW1()) UART_SendChar(0xff);//0xff->异常结束
        LDR.W    R0,??DataTable9_2  ;; 0x400ff090
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+1
        CMP      R0,#+0
        BNE.N    ??Cam_Algorithm_7
        MOVS     R0,#+255
        BL       UART_SendChar
//  135   }//以上原来是SW1()
//  136 }
??Cam_Algorithm_7:
        POP      {R4,PC}          ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
??img_row_used:
        DS8 1
//  137 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  138 float constrain(float lowerBoundary, float upperBoundary, float input)
//  139 {
constrain:
        PUSH     {R7,LR}
        MOVS     R3,R0
        MOVS     R0,R1
//  140 	if (input > upperBoundary)
        MOVS     R1,R2
        BL       __aeabi_cfcmple
        BCC.N    ??constrain_0
//  141 		return upperBoundary;
//  142 	else if (input < lowerBoundary)
??constrain_1:
        MOVS     R0,R2
        MOVS     R1,R3
        BL       __aeabi_cfcmple
        BCS.N    ??constrain_2
//  143 		return lowerBoundary;
        MOVS     R0,R3
        B.N      ??constrain_0
//  144 	else
//  145 		return input;
??constrain_2:
        MOVS     R0,R2
??constrain_0:
        POP      {R1,PC}          ;; return
//  146 }
//  147 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  148 int constrainInt(int lowerBoundary, int upperBoundary, int input)
//  149 {
//  150 	if (input > upperBoundary)
constrainInt:
        CMP      R1,R2
        BGE.N    ??constrainInt_0
//  151 		return upperBoundary;
        MOVS     R0,R1
        B.N      ??constrainInt_1
//  152 	else if (input < lowerBoundary)
??constrainInt_0:
        CMP      R2,R0
        BLT.N    ??constrainInt_1
//  153 		return lowerBoundary;
//  154 	else
//  155 		return input;
??constrainInt_2:
        MOVS     R0,R2
??constrainInt_1:
        BX       LR               ;; return
//  156 }
//  157 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  158 circle getR(float x1, float y1, float x2, float y2, float x3, float y3)
//  159 {
getR:
        PUSH     {R0-R2,R4-R11,LR}
        SUB      SP,SP,#+32
        MOV      R8,R3
//  160   double a,b,c,d,e,f;
//  161   double r,x,y;
//  162 	
//  163   a=2*(x2-x1);
        MOV      R0,R8
        LDR      R1,[SP, #+36]
        BL       __aeabi_fsub
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        STRD     R0,R1,[SP, #+16]
        LDR      R9,[SP, #+80]
//  164   b=2*(y2-y1);
        MOV      R0,R9
        LDR      R1,[SP, #+40]
        BL       __aeabi_fsub
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        MOVS     R6,R0
        MOVS     R7,R1
//  165   c=x2*x2+y2*y2-x1*x1-y1*y1;
        MOV      R0,R8
        MOV      R1,R8
        BL       __aeabi_fmul
        MOVS     R4,R0
        MOV      R0,R9
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R4
        BL       __aeabi_fadd
        MOVS     R4,R0
        LDR      R1,[SP, #+36]
        LDR      R0,[SP, #+36]
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOVS     R0,R4
        BL       __aeabi_fsub
        MOVS     R4,R0
        LDR      R1,[SP, #+40]
        LDR      R0,[SP, #+40]
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOVS     R0,R4
        BL       __aeabi_fsub
        BL       __aeabi_f2d
        STRD     R0,R1,[SP, #+24]
        LDR      R11,[SP, #+84]
//  166   d=2*(x3-x2);
        MOV      R0,R11
        MOV      R1,R8
        BL       __aeabi_fsub
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        STRD     R0,R1,[SP, #+8]
        LDR      R10,[SP, #+88]
//  167   e=2*(y3-y2);
        MOV      R0,R10
        MOV      R1,R9
        BL       __aeabi_fsub
        MOVS     R1,#+1073741824
        BL       __aeabi_fmul
        BL       __aeabi_f2d
        MOVS     R4,R0
        MOVS     R5,R1
//  168   f=x3*x3+y3*y3-x2*x2-y2*y2;
        MOV      R0,R11
        MOV      R1,R11
        BL       __aeabi_fmul
        MOV      R11,R0
        MOV      R0,R10
        MOV      R1,R10
        BL       __aeabi_fmul
        MOV      R1,R11
        BL       __aeabi_fadd
        MOV      R10,R0
        MOV      R0,R8
        MOV      R1,R8
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R10
        BL       __aeabi_fsub
        MOV      R8,R0
        MOV      R0,R9
        MOV      R1,R9
        BL       __aeabi_fmul
        MOVS     R1,R0
        MOV      R0,R8
        BL       __aeabi_fsub
        BL       __aeabi_f2d
        MOV      R10,R0
        MOV      R11,R1
//  169   x=(b*f-e*c)/(b*d-e*a);
        MOV      R2,R10
        MOV      R3,R11
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R0,R1,[SP, #+24]
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_dsub
        STRD     R0,R1,[SP, #+0]
        LDRD     R0,R1,[SP, #+8]
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDRD     R0,R1,[SP, #+16]
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_dsub
        MOVS     R2,R0
        MOVS     R3,R1
        LDRD     R0,R1,[SP, #+0]
        BL       __aeabi_ddiv
        MOV      R8,R0
        MOV      R9,R1
//  170   y=(d*c-a*f)/(b*d-e*a);
        LDRD     R2,R3,[SP, #+8]
        LDRD     R0,R1,[SP, #+24]
        BL       __aeabi_dmul
        STRD     R0,R1,[SP, #+0]
        LDRD     R0,R1,[SP, #+16]
        MOV      R2,R10
        MOV      R3,R11
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        LDRD     R0,R1,[SP, #+0]
        BL       __aeabi_dsub
        MOV      R10,R0
        MOV      R11,R1
        LDRD     R0,R1,[SP, #+8]
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOVS     R6,R0
        MOVS     R7,R1
        LDRD     R0,R1,[SP, #+16]
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_dsub
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R10
        MOV      R1,R11
        BL       __aeabi_ddiv
        MOVS     R4,R0
        MOVS     R5,R1
//  171   r=sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
        LDR      R0,[SP, #+36]
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_dsub
        MOVS     R6,R0
        MOVS     R7,R1
        LDR      R0,[SP, #+36]
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_dsub
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOV      R10,R0
        MOV      R11,R1
        LDR      R0,[SP, #+40]
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dsub
        MOVS     R6,R0
        MOVS     R7,R1
        LDR      R0,[SP, #+40]
        BL       __aeabi_f2d
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dsub
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_dmul
        MOV      R2,R10
        MOV      R3,R11
        BL       __aeabi_dadd
        BL       sqrt
        MOVS     R6,R0
        MOVS     R7,R1
//  172   x=constrain(-1000.0,1000.0,x);
        MOV      R0,R8
        MOV      R1,R9
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R1,??DataTable9_3  ;; 0x447a0000
        LDR.W    R0,??DataTable9_4  ;; 0xc47a0000
        BL       constrain
        BL       __aeabi_f2d
        MOV      R8,R0
        MOV      R9,R1
//  173   y=constrain(-1000.0,1000.0,y);
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R1,??DataTable9_3  ;; 0x447a0000
        LDR.W    R0,??DataTable9_4  ;; 0xc47a0000
        BL       constrain
        BL       __aeabi_f2d
        MOVS     R4,R0
        MOVS     R5,R1
//  174   r=constrain(1.0,500.0,r);
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R1,??DataTable10  ;; 0x43fa0000
        MOVS     R0,#+1065353216
        BL       constrain
        BL       __aeabi_f2d
        MOVS     R6,R0
        MOVS     R7,R1
//  175   bool sign = (x>0)?1:0;
        MOV      R0,R8
        MOV      R1,R9
        MOVS     R2,#+0
        MOVS     R3,#+0
        BL       __aeabi_cdrcmple
        BCS.N    ??getR_0
        MOVS     R4,#+1
        B.N      ??getR_1
??getR_0:
        MOVS     R4,#+0
//  176   circle tmp = {r,sign};
??getR_1:
        MOVS     R0,R6
        MOVS     R1,R7
        BL       __aeabi_d2f
        STR      R0,[SP, #+0]
        STRB     R4,[SP, #+4]
//  177   return tmp;
        LDRD     R0,R1,[SP, #+0]
        LDR      R2,[SP, #+32]
        STRD     R0,R1,[R2, #+0]
        ADD      SP,SP,#+44
        POP      {R4-R11,PC}      ;; return
//  178 }
//  179 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  180 bool is_stop_line(int target_line)//目测并不有效……
//  181 {
//  182   if((road_B[target_line].right-road_B[target_line].left)<ROAD_WID)
is_stop_line:
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R0,R3,R0,R2
        LDR      R0,[R0, #+0]
        SUBS     R0,R1,R0
        CMP      R0,#+30
        BGE.N    ??is_stop_line_0
//  183     return 1;
        MOVS     R0,#+1
        B.N      ??is_stop_line_1
//  184   else return 0;
??is_stop_line_0:
        MOVS     R0,#+0
??is_stop_line_1:
        BX       LR               ;; return
//  185 }
//  186 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  187 double getSlope_(int x1, int y1, int x2, int y2)
//  188 {
getSlope_:
        PUSH     {R3-R7,LR}
        MOVS     R6,R1
        MOVS     R7,R3
//  189   double dx = x2-x1;
        SUBS     R0,R2,R0
        BL       __aeabi_i2d
        MOVS     R4,R0
        MOVS     R5,R1
//  190   double dy = y2-y1;
        SUBS     R0,R7,R6
        BL       __aeabi_i2d
        MOVS     R6,R0
        MOVS     R7,R1
//  191   if(dy==0) return dx*100;
        MOVS     R0,#+0
        MOVS     R1,#+0
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_cdcmpeq
        BNE.N    ??getSlope__0
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_2  ;; 0x40590000
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        B.N      ??getSlope__1
//  192   else return (double)dx/dy;
??getSlope__0:
        MOVS     R0,R4
        MOVS     R1,R5
        MOVS     R2,R6
        MOVS     R3,R7
        BL       __aeabi_ddiv
??getSlope__1:
        POP      {R2,R4-R7,PC}    ;; return
//  193 }
//  194 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  195 void Cam_B_Init()//初始化Cam_B
//  196 {
//  197   int i=0;
Cam_B_Init:
        MOVS     R0,#+0
//  198   for(i=0;i<ROAD_SIZE;i++)
        MOVS     R1,#+0
        MOVS     R0,R1
        B.N      ??Cam_B_Init_0
//  199   {
//  200     road_B[i].left=CAM_WID/2;
??Cam_B_Init_1:
        MOVS     R1,#+66
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+0]
//  201     road_B[i].right=CAM_WID/2+2;
        MOVS     R1,#+68
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+4]
//  202     road_B[i].mid=CAM_WID/2+1;
        MOVS     R1,#+67
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+8]
//  203   }
        ADDS     R0,R0,#+1
??Cam_B_Init_0:
        CMP      R0,#+25
        BLT.N    ??Cam_B_Init_1
//  204   mid_ave=CAM_WID/2+1;
        LDR.W    R0,??DataTable10_3  ;; 0x42860000
        LDR.W    R1,??DataTable10_4
        STR      R0,[R1, #+0]
//  205   //以下为road->mid加权值weight的初始化，由近到远
//  206   //方案一：分段函数
//  207   /*for(i=0;i<3;i++)
//  208   {  
//  209     weight[i]=1;
//  210   }
//  211   for(i=3;i<7;i++)
//  212   {  
//  213     weight[i]=2;
//  214   }
//  215   for(i=7;i<10;i++)
//  216   {
//  217     weight[i]=1;
//  218   }*/
//  219   
//  220   //方案二：遵从正态分布，最高值在weight[MaxWeight_index]，在头文件定义相关参数//但是……无效……不知为何
//  221 /*  for(int i=0;i<10;i++)
//  222   {
//  223     weight[i]=1.0 + MaxWeight * exp(-(double)exp_k*pow((double)(i-MaxWeight_index),2.0)/2.0); //目前最高下标为常量
//  224   }*/
//  225   
//  226   // design 3 ——>声明与定义放一块，global
//  227 //  weight = {1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744, 2.296, 1.454};
//  228   
//  229 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0xe000ed18
//  230 
//  231 
//  232 //test

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//  233 double theta,theta_d,slope,test;
theta:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
theta_d:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
slope:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
test:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//  234 double x,y;
x:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
y:
        DS8 8
//  235 
//  236   //第一次进化版巡线程序

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  237 void Cam_B(){
Cam_B:
        PUSH     {R3-R11,LR}
//  238   
//  239     //===================变量定义====================
//  240   
//  241     float max_speed=MAX_SPEED+debug_speed;//最大速度
        LDR.W    R0,??DataTable10_5
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+20
        BL       __aeabi_i2f
        MOVS     R7,R0
//  242     static int dir;//舵机输出
//  243     //slope[0] = 0;
//  244  
//  245     //横向扫描方案
//  246     for(int j=0;j<ROAD_SIZE;j++)//从下向上扫描
        MOVS     R0,#+0
        B.N      ??Cam_B_0
//  247     {
//  248       int i;
//  249       //left
//  250       for (i = road_B[j].mid; i > 0; i--){
//  251         if (cam_buffer[60-CAM_STEP*j][i] < thr)
//  252           break;
//  253         }
//  254       road_B[j].left = i;
//  255       //right
//  256       for (i = road_B[j].mid; i < CAM_WID; i++){
??Cam_B_1:
        ADDS     R1,R1,#+1
??Cam_B_2:
        CMP      R1,#+132
        BGE.N    ??Cam_B_3
//  257         if (cam_buffer[60-CAM_STEP*j][i] < thr)
        LDR.W    R2,??DataTable7_2
        LDR.W    R3,??DataTable10_6  ;; 0xfffffeca
        MLA      R2,R3,R0,R2
        ADDS     R2,R1,R2
        MOVW     R3,#+9300
        LDRB     R2,[R3, R2]
        CMP      R2,#+70
        BGE.N    ??Cam_B_1
//  258           break;
//  259         }
//  260       road_B[j].right = i;
??Cam_B_3:
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+4]
//  261       //mid
//  262       road_B[j].mid = (road_B[j].left + road_B[j].right)/2;//分别计算并存储25行的mid
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #+4]
        ADDS     R1,R2,R1
        MOVS     R2,#+2
        SDIV     R1,R1,R2
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+8]
//  263       //store
//  264       if(j<(ROAD_SIZE-1))
        CMP      R0,#+24
        BGE.N    ??Cam_B_4
//  265         road_B[j+1].mid=road_B[j].mid;//后一行从前一行中点开始扫描
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+8]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+20]
//  266       if(j > 0)
??Cam_B_4:
        CMP      R0,#+1
        BLT.N    ??Cam_B_5
//  267         slope_mid[j] = road_B[j].mid - road_B[j - 1].mid;
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+8]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #-4]
        SUBS     R1,R1,R2
        LDR.W    R2,??DataTable10_7
        STRB     R1,[R0, R2]
//  268       if(j > 1)
??Cam_B_5:
        CMP      R0,#+2
        BLT.N    ??Cam_B_6
//  269       {
//  270         curvatureL[j] = road_B[j].left - road_B[j - 1].left * 2 + road_B[j - 2].left;
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #-12]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R1,R1,R2, LSL #+1
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #-24]
        ADDS     R1,R2,R1
        LDR.W    R2,??DataTable10_8
        STRB     R1,[R0, R2]
//  271         curvatureR[j] = road_B[j].right - road_B[j - 1].right * 2 + road_B[j - 2].right;
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+4]
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #-8]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R1,R1,R2, LSL #+1
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #-20]
        ADDS     R1,R2,R1
        LDR.W    R2,??DataTable10_9
        STRB     R1,[R0, R2]
//  272       }
??Cam_B_6:
        ADDS     R0,R0,#+1
??Cam_B_0:
        CMP      R0,#+25
        BGE.N    ??Cam_B_7
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+8]
        B.N      ??Cam_B_8
??Cam_B_9:
        SUBS     R1,R1,#+1
??Cam_B_8:
        CMP      R1,#+1
        BLT.N    ??Cam_B_10
        LDR.W    R2,??DataTable7_2
        LDR.W    R3,??DataTable10_6  ;; 0xfffffeca
        MLA      R2,R3,R0,R2
        ADDS     R2,R1,R2
        MOVW     R3,#+9300
        LDRB     R2,[R3, R2]
        CMP      R2,#+70
        BGE.N    ??Cam_B_9
??Cam_B_10:
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        STR      R1,[R2, #+0]
        LDR.W    R1,??DataTable10_1
        MOVS     R2,#+12
        MLA      R1,R2,R0,R1
        LDR      R1,[R1, #+8]
        B.N      ??Cam_B_2
//  273     }
//  274       
//  275     //===========================区分前方道路类型//需要设置一个优先级！！！
//  276     static int mid_ave3;
//  277     bool flag_valid_row=0;
??Cam_B_7:
        MOVS     R0,#+0
//  278     for(int i_valid=0;i_valid<(ROAD_SIZE-3) && flag_valid_row==0;i_valid++)
        MOVS     R1,#+0
        B.N      ??Cam_B_11
//  279     {
//  280       mid_ave3 = (road_B[i_valid].mid + road_B[i_valid+1].mid + road_B[i_valid+2].mid)/3;
//  281       if(mid_ave3<margin||mid_ave3>(CAM_WID-margin))
//  282       {
//  283         flag_valid_row=1;
//  284         valid_row=i_valid;
//  285       }
//  286       else valid_row=ROAD_SIZE-3;
??Cam_B_12:
        MOVS     R2,#+22
        LDR.W    R3,??DataTable10_10
        STR      R2,[R3, #+0]
??Cam_B_13:
        ADDS     R1,R1,#+1
??Cam_B_11:
        CMP      R1,#+22
        BGE.N    ??Cam_B_14
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??Cam_B_14
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R1,R2
        LDR      R2,[R2, #+8]
        LDR.W    R3,??DataTable10_1
        MOVS     R4,#+12
        MLA      R3,R4,R1,R3
        LDR      R3,[R3, #+20]
        ADDS     R2,R3,R2
        LDR.W    R3,??DataTable10_1
        MOVS     R4,#+12
        MLA      R3,R4,R1,R3
        LDR      R3,[R3, #+32]
        ADDS     R2,R3,R2
        MOVS     R3,#+3
        SDIV     R2,R2,R3
        LDR.W    R3,??DataTable10_11
        STR      R2,[R3, #+0]
        LDR.W    R2,??DataTable10_11
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable10_12
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BLT.N    ??Cam_B_15
        LDR.W    R2,??DataTable10_12
        LDR      R2,[R2, #+0]
        RSBS     R2,R2,#+132
        LDR.W    R3,??DataTable10_11
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BGE.N    ??Cam_B_12
??Cam_B_15:
        MOVS     R0,#+1
        LDR.W    R2,??DataTable10_10
        STR      R1,[R2, #+0]
        B.N      ??Cam_B_13
//  287     }
//  288     if(valid_row<valid_row_thr)
??Cam_B_14:
        LDR.W    R0,??DataTable10_10
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_13
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BGE.N    ??Cam_B_16
//  289       road_state=2;//弯道
        MOVS     R0,#+2
        LDR.W    R1,??DataTable10_14
        STRB     R0,[R1, #+0]
        B.N      ??Cam_B_17
//  290     else road_state=1;//直道
??Cam_B_16:
        MOVS     R0,#+1
        LDR.W    R1,??DataTable10_14
        STRB     R0,[R1, #+0]
//  291     
//  292     int tmpL, tmpR;
//  293     bool flagL_island = 0, flagR_island = 0;
??Cam_B_17:
        MOVS     R2,#+0
        MOVS     R3,#+0
//  294     for(tmpL = 2; tmpL < (ROAD_SIZE - 3) && flagL_island == 0; tmpL++)
        MOVS     R0,#+2
        B.N      ??Cam_B_18
//  295     {
//  296       if(curvatureL[tmpL] < -4)
??Cam_B_19:
        ADDS     R0,R0,#+1
??Cam_B_18:
        CMP      R0,#+22
        BGE.N    ??Cam_B_20
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??Cam_B_19
//  297         flagL_island = 1;
//  298     }
//  299     for(tmpR = 2; tmpR < (ROAD_SIZE - 3) && flagR_island == 0; tmpR++)
??Cam_B_20:
        MOVS     R1,#+2
        B.N      ??Cam_B_21
//  300     {
//  301       if(curvatureR[tmpR] > 4)
??Cam_B_22:
        LDR.W    R4,??DataTable10_9
        LDRB     R4,[R1, R4]
        CMP      R4,#+5
        BLT.N    ??Cam_B_23
//  302         flagR_island = 1;
        MOVS     R3,#+1
//  303     }
??Cam_B_23:
        ADDS     R1,R1,#+1
??Cam_B_21:
        CMP      R1,#+22
        BGE.N    ??Cam_B_24
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BEQ.N    ??Cam_B_22
//  304     if(flagL_island && flagR_island)
??Cam_B_24:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??Cam_B_25
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BEQ.N    ??Cam_B_25
//  305     {
//  306       u8 flag_tmp = 0;
        MOVS     R2,#+0
//  307       int i, j;
//  308       int tmpRow_island = tmpL > tmpR ? tmpR : tmpL, tmpCol_island;
        CMP      R1,R0
        BGE.N    ??Cam_B_26
        MOVS     R0,R1
        B.N      ??Cam_B_27
//  309       tmpRow_island = ROAD_SIZE - tmpRow_island * CAM_STEP;
??Cam_B_26:
??Cam_B_27:
        LSLS     R0,R0,#+1
        RSBS     R0,R0,#+25
//  310       s8 tmp_slope = slope_mid[tmpRow_island];
        LDR.W    R1,??DataTable10_7
        LDRB     R1,[R0, R1]
//  311       tmpCol_island = road_B[tmpRow_island].mid;
        LDR.W    R2,??DataTable10_1
        MOVS     R3,#+12
        MLA      R2,R3,R0,R2
        LDR      R2,[R2, #+8]
//  312       for(i = 0; i < (ROAD_SIZE - 3 - tmpRow_island) && cam_buffer[tmpRow_island - i * CAM_STEP][tmpCol_island + i * tmp_slope] > thr;i++){};
        MOVS     R3,#+0
        B.N      ??Cam_B_28
??Cam_B_29:
        ADDS     R3,R3,#+1
??Cam_B_28:
        RSBS     R4,R0,#+22
        CMP      R3,R4
        BGE.N    ??Cam_B_30
        LDR.W    R4,??DataTable7_2
        SUBS     R5,R0,R3, LSL #+1
        MOVS     R6,#+155
        MLA      R4,R6,R5,R4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MLA      R5,R1,R3,R2
        LDRB     R4,[R5, R4]
        CMP      R4,#+71
        BGE.N    ??Cam_B_29
//  313       for(j = i; j < (ROAD_SIZE - 3 - tmpRow_island) && cam_buffer[tmpRow_island - j * CAM_STEP][tmpCol_island + j * tmp_slope] < thr;j++){};
??Cam_B_30:
        B.N      ??Cam_B_31
??Cam_B_32:
        ADDS     R3,R3,#+1
??Cam_B_31:
        RSBS     R4,R0,#+22
        CMP      R3,R4
        BGE.N    ??Cam_B_33
        LDR.W    R4,??DataTable7_2
        SUBS     R5,R0,R3, LSL #+1
        MOVS     R6,#+155
        MLA      R4,R6,R5,R4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MLA      R5,R1,R3,R2
        LDRB     R4,[R5, R4]
        CMP      R4,#+70
        BLT.N    ??Cam_B_32
//  314       if(j < (ROAD_SIZE - 3 - tmpRow_island))
??Cam_B_33:
        RSBS     R0,R0,#+22
        CMP      R3,R0
        BGE.N    ??Cam_B_25
//  315         road_state = 3;
        MOVS     R0,#+3
        LDR.W    R1,??DataTable10_14
        STRB     R0,[R1, #+0]
//  316     }
//  317     
//  318     if(road_state == 3)
//  319     {
//  320       
//  321     }
//  322     //detect the black hole————————————————————
//  323     /*
//  324     int left=0,right=0;
//  325     if(cam_buffer[CAM_HOLE_ROW][CAM_WID/2]<thr)
//  326     {
//  327       //left
//  328       int i=CAM_WID/2-1;
//  329       while(i>0){
//  330         if(left==0 && cam_buffer[CAM_HOLE_ROW][i]>thr){//是否考虑取平均防跳变？
//  331           left++;
//  332         }
//  333         else if(left==1 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  334           left++;
//  335         }
//  336         i--;
//  337       }
//  338       //right
//  339       i=CAM_WID/2+1;
//  340       while(i<CAM_WID){
//  341         if(right==0 && cam_buffer[CAM_HOLE_ROW][i]>thr){//是否考虑取平均防跳变？
//  342           right++;
//  343         }
//  344         else if(right==1 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  345           right++;
//  346         }
//  347         i++;
//  348       }
//  349     }
//  350     if(left>=1 && right>=1)
//  351       road_state=3;//前方环岛*/
//  352     //detect the obstacle————————————————————
//  353   /*  if((road_B[ROAD_OBST_ROW].right-road_B[ROAD_OBST_ROW].left)<OBSTACLE_THR)
//  354     {
//  355       int i=road_B[ROAD_OBST_ROW].mid;
//  356       left=0;
//  357       right=0;
//  358       //left
//  359       while(i>0){
//  360         if(left==0 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  361           left++;
//  362         }
//  363         else if(left==1 && cam_buffer[CAM_HOLE_ROW][i]>thr){
//  364           left++;
//  365         }
//  366         else if(left==2 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  367           left++;
//  368         }
//  369         i--;
//  370       }
//  371       //right
//  372       while(i<CAM_WID){
//  373         if(right==0 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  374           right++;
//  375         }
//  376         else if(right==1 && cam_buffer[CAM_HOLE_ROW][i]>thr){
//  377           right++;
//  378         }
//  379         else if(right==2 && cam_buffer[CAM_HOLE_ROW][i]<thr){
//  380           right++;
//  381         }
//  382         i++;
//  383       }
//  384       if(left>=3 || right>=3)
//  385         road_state=4;
//  386     }*/
//  387     
//  388   /*  //=============================根据前方道路类型，选择不同的权值weight
//  389      switch(road_state)
//  390     {
//  391       case 1: 
//  392         for(int i=0;i<10;i++)weight[i]=1;//均匀分布的权值
//  393         break;
//  394       case 2:
//  395         max_speed=MAX_SPEED-5;//减多少未定，取决于弯道最高速度
//  396         float weight2[10] = {1.00,1.03,1.14,1.54,2.56,4.29,6.16,7.00,6.16,4.29};
//  397         for(int i;i<10;i++) weight[i] = weight2[i];//正态分布的权值
//  398         break;
//  399       case 3:
//  400         max_speed=MAX_SPEED-5;
//  401         float  weight3[10] = {1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744, 2.296, 1.454};//未确定
//  402         for(int i;i<10;i++) weight[i] = weight2[i];
//  403         break;
//  404       case 4:
//  405         break;
//  406       default:break;
//  407     }*/
//  408     
//  409     //================================对十行mid加权：
//  410     float weight_sum=0;
??Cam_B_25:
        MOVS     R4,#+0
//  411     for(int j=0;j<10;j++)
        MOVS     R5,#+0
        B.N      ??Cam_B_34
//  412     {
//  413       mid_ave += road_B[j].mid * weight[road_state][j];
??Cam_B_35:
        LDR.W    R0,??DataTable10_1
        MOVS     R1,#+12
        MLA      R0,R1,R5,R0
        LDR      R0,[R0, #+8]
        BL       __aeabi_i2f
        LDR.W    R1,??DataTable10_15
        LDR.W    R2,??DataTable10_14
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+40
        MLA      R1,R3,R2,R1
        LDR      R1,[R1, R5, LSL #+2]
        BL       __aeabi_fmul
        LDR.W    R1,??DataTable10_4
        LDR      R1,[R1, #+0]
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable10_4
        STR      R0,[R1, #+0]
//  414       weight_sum += weight[road_state][j];
        LDR.W    R0,??DataTable10_15
        LDR.W    R1,??DataTable10_14
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+40
        MLA      R0,R2,R1,R0
        LDR      R0,[R0, R5, LSL #+2]
        MOVS     R1,R4
        BL       __aeabi_fadd
        MOVS     R4,R0
//  415     }
        ADDS     R5,R5,#+1
??Cam_B_34:
        CMP      R5,#+10
        BLT.N    ??Cam_B_35
//  416     mid_ave/=weight_sum;
        LDR.W    R0,??DataTable10_4
        LDR      R0,[R0, #+0]
        MOVS     R1,R4
        BL       __aeabi_fdiv
        LDR.W    R1,??DataTable10_4
        STR      R0,[R1, #+0]
//  417     
//  418     //=================================舵机的PD控制
//  419     static float err;
//  420     static float last_err;
//  421     err = mid_ave  - CAM_WID / 2;
        LDR.W    R0,??DataTable10_4
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_16  ;; 0xc2840000
        BL       __aeabi_fadd
        LDR.W    R1,??DataTable10_17
        STR      R0,[R1, #+0]
//  422 
//  423     dir = (Dir_Kp+debug_dir.kp) * err + (Dir_Kd+debug_dir.kd) * (err-last_err);     //舵机转向  //参数: (7,3)->(8,3.5)
        LDR.W    R0,??DataTable10_18
        LDRD     R2,R3,[R0, #+0]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_19  ;; 0x40100000
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable10_17
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOV      R8,R0
        MOV      R9,R1
        LDR.W    R0,??DataTable10_18
        LDRD     R2,R3,[R0, #+16]
        MOVS     R0,#+0
        LDR.W    R1,??DataTable10_20  ;; 0x40080000
        BL       __aeabi_dadd
        MOVS     R4,R0
        MOVS     R5,R1
        LDR.W    R0,??DataTable10_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_21
        LDR      R1,[R1, #+0]
        BL       __aeabi_fsub
        BL       __aeabi_f2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOV      R2,R8
        MOV      R3,R9
        BL       __aeabi_dadd
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable10_22
        STR      R0,[R1, #+0]
//  424     if(dir>0)
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_36
//  425       dir*=1.2;//修正舵机左右不对称的问题//不可删
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        BL       __aeabi_i2d
        MOVS     R2,#+858993459
        LDR.W    R3,??DataTable10_23  ;; 0x3ff33333
        BL       __aeabi_dmul
        BL       __aeabi_d2iz
        LDR.W    R1,??DataTable10_22
        STR      R0,[R1, #+0]
//  426     last_err = err;
??Cam_B_36:
        LDR.W    R0,??DataTable10_17
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_21
        STR      R0,[R1, #+0]
//  427     
//  428     dir=constrainInt(-230,230,dir);
        LDR.W    R0,??DataTable10_22
        LDR      R2,[R0, #+0]
        MOVS     R1,#+230
        MVNS     R0,#+229
        BL       constrainInt
        LDR.W    R1,??DataTable10_22
        STR      R0,[R1, #+0]
//  429     if(car_state!=0)
        LDR.W    R0,??DataTable10_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??Cam_B_37
//  430       Servo_Output(dir);
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        BL       Servo_Output
        B.N      ??Cam_B_38
//  431     else   
//  432       Servo_Output(0);
??Cam_B_37:
        MOVS     R0,#+0
        BL       Servo_Output
//  433     
//  434     
//  435     
//  436     //==============速度控制=================
//  437     //PWM以dir为参考，前期分级控制弯道速度；中期分段线性控速；后期找到合适参数的时候，再进行拟合——PWM关于dir的函数
//  438     float range=max_speed-MIN_SPEED;//速度范围大小 
??Cam_B_38:
        LDR.W    R0,??DataTable10_25  ;; 0xc1400000
        MOVS     R1,R7
        BL       __aeabi_fadd
        MOVS     R6,R0
//  439     if(car_state==2 ){
        LDR.W    R0,??DataTable10_24
        LDRB     R0,[R0, #+0]
        CMP      R0,#+2
        BNE.W    ??Cam_B_39
//  440       //分段线性控速
//  441       if(abs(dir)<50 ){//&& valid_row>valid_row_thr
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_40
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        B.N      ??Cam_B_41
??Cam_B_40:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Cam_B_41:
        CMP      R0,#+50
        BGE.N    ??Cam_B_42
//  442         motor_L=motor_R=max_speed;
        LDR.W    R0,??DataTable10_26
        STR      R7,[R0, #+0]
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  443       }
//  444       else if(abs(dir)<95){
??Cam_B_42:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_44
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        B.N      ??Cam_B_45
??Cam_B_44:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Cam_B_45:
        CMP      R0,#+95
        BGE.N    ??Cam_B_46
//  445         motor_L=motor_R=max_speed-0.33*range*(abs(dir)-50)/45;
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_47
        LDR.W    R0,??DataTable10_22
        LDR      R8,[R0, #+0]
        B.N      ??Cam_B_48
??Cam_B_47:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R8,R0,#+0
??Cam_B_48:
        MOVS     R0,R7
        BL       __aeabi_f2d
        MOV      R10,R0
        MOV      R11,R1
        MOVS     R0,R6
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_28  ;; 0x51eb851f
        LDR.W    R3,??DataTable10_29  ;; 0x3fd51eb8
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        SUBS     R0,R8,#+50
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable10_30  ;; 0x40468000
        BL       __aeabi_ddiv
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R10
        MOV      R1,R11
        BL       __aeabi_dsub
        BL       __aeabi_d2f
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
//  446         if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.9);//右转
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_49
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_31  ;; 0xcccccccd
        LDR.W    R3,??DataTable10_32  ;; 0x3feccccc
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_26
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  447         else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.9);//0.9
??Cam_B_49:
        LDR.W    R0,??DataTable10_27
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_31  ;; 0xcccccccd
        LDR.W    R3,??DataTable10_32  ;; 0x3feccccc
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_27
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  448       }
//  449       else if(abs(dir)<185){    
??Cam_B_46:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_50
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        B.N      ??Cam_B_51
??Cam_B_50:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Cam_B_51:
        CMP      R0,#+185
        BGE.W    ??Cam_B_52
//  450         motor_L=motor_R=max_speed-0.33*range-0.33*range*(abs(dir)-95)/90;
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_53
        LDR.W    R0,??DataTable10_22
        LDR      R8,[R0, #+0]
        B.N      ??Cam_B_54
??Cam_B_53:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R8,R0,#+0
??Cam_B_54:
        MOVS     R0,R7
        BL       __aeabi_f2d
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,R6
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_28  ;; 0x51eb851f
        LDR.W    R3,??DataTable10_29  ;; 0x3fd51eb8
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dsub
        MOV      R10,R0
        MOV      R11,R1
        MOVS     R0,R6
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_28  ;; 0x51eb851f
        LDR.W    R3,??DataTable10_29  ;; 0x3fd51eb8
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        SUBS     R0,R8,#+95
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable10_34  ;; 0x40568000
        BL       __aeabi_ddiv
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R10
        MOV      R1,R11
        BL       __aeabi_dsub
        BL       __aeabi_d2f
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
//  451         if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.8);//右转
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_55
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_35  ;; 0x9999999a
        LDR.W    R3,??DataTable10_36  ;; 0x3fe99999
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_26
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  452         else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.8);//0/75
??Cam_B_55:
        LDR.W    R0,??DataTable10_27
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_35  ;; 0x9999999a
        LDR.W    R3,??DataTable10_36  ;; 0x3fe99999
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_27
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  453       }
//  454       else if(abs(dir)<230){
??Cam_B_52:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_56
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        B.N      ??Cam_B_57
??Cam_B_56:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+0
??Cam_B_57:
        CMP      R0,#+230
        BGE.W    ??Cam_B_58
//  455         motor_L=motor_R=max_speed-0.66*range-0.33*range*(abs(dir)-185)/45;
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_59
        LDR.W    R0,??DataTable10_22
        LDR      R8,[R0, #+0]
        B.N      ??Cam_B_60
??Cam_B_59:
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        RSBS     R8,R0,#+0
??Cam_B_60:
        MOVS     R0,R7
        BL       __aeabi_f2d
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R0,R6
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_28  ;; 0x51eb851f
        LDR.W    R3,??DataTable10_37  ;; 0x3fe51eb8
        BL       __aeabi_dmul
        MOVS     R2,R0
        MOVS     R3,R1
        MOVS     R0,R4
        MOVS     R1,R5
        BL       __aeabi_dsub
        MOV      R10,R0
        MOV      R11,R1
        MOVS     R0,R6
        BL       __aeabi_f2d
        LDR.W    R2,??DataTable10_28  ;; 0x51eb851f
        LDR.W    R3,??DataTable10_29  ;; 0x3fd51eb8
        BL       __aeabi_dmul
        MOVS     R4,R0
        MOVS     R5,R1
        SUBS     R0,R8,#+185
        BL       __aeabi_i2d
        MOVS     R2,R4
        MOVS     R3,R5
        BL       __aeabi_dmul
        MOVS     R2,#+0
        LDR.W    R3,??DataTable10_30  ;; 0x40468000
        BL       __aeabi_ddiv
        MOVS     R2,R0
        MOVS     R3,R1
        MOV      R0,R10
        MOV      R1,R11
        BL       __aeabi_dsub
        BL       __aeabi_d2f
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
//  456         if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.7);//右转
        LDR.W    R0,??DataTable10_22
        LDR      R0,[R0, #+0]
        CMP      R0,#+1
        BLT.N    ??Cam_B_61
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        MOVS     R2,#+1717986918
        LDR.W    R3,??DataTable10_38  ;; 0x3fe66666
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_26
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  457         else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.7);//0.5
??Cam_B_61:
        LDR.W    R0,??DataTable10_27
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2d
        MOVS     R2,#+1717986918
        LDR.W    R3,??DataTable10_38  ;; 0x3fe66666
        BL       __aeabi_dmul
        BL       __aeabi_d2f
        MOVS     R2,R0
        LDR.W    R0,??DataTable10_27
        LDR      R1,[R0, #+0]
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        BL       constrain
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
        B.N      ??Cam_B_43
//  458       }//以上的差速控制参数未确定，调参时以车辆稳定行驶为目标
//  459       else{
//  460         motor_L=motor_R=MIN_SPEED;
??Cam_B_58:
        LDR.W    R0,??DataTable10_33  ;; 0x41400000
        LDR.W    R1,??DataTable10_26
        STR      R0,[R1, #+0]
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable10_27
        STR      R0,[R1, #+0]
//  461       }
//  462       PWM(motor_L, motor_R, &L, &R);               //后轮速度
??Cam_B_43:
        LDR.W    R3,??DataTable10_39
        LDR.W    R2,??DataTable10_40
        MOVS     R4,R2
        MOVS     R5,R3
        LDR.W    R0,??DataTable10_26
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        MOVS     R1,R0
        MOVS     R3,R5
        MOVS     R2,R4
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
        LDR.W    R0,??DataTable10_27
        LDR      R0,[R0, #+0]
        BL       __aeabi_f2iz
        MOVS     R3,R6
        MOVS     R2,R5
        MOVS     R1,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       PWM
        B.N      ??Cam_B_62
//  463     }
//  464    else
//  465      PWM(0, 0, &L, &R);
??Cam_B_39:
        LDR.W    R3,??DataTable10_39
        LDR.W    R2,??DataTable10_40
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       PWM
//  466     
//  467     //方案二//暂时放弃
//  468     //C=getR(road_B[c1].mid,20-c1,road_B[c2].mid,20-c2,road_B[c3].mid,20-c3);
//  469     
//  470 }
??Cam_B_62:
        POP      {R0,R4-R11,PC}   ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     ??img_row_used

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     img_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     cam_buffer

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??dir:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??mid_ave3:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??err:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??last_err:
        DS8 4
//  471 
//  472 
//  473 
//  474 
//  475 // ====== Basic Drivers ======
//  476 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  477 void PORTC_IRQHandler(){
//  478   if((PORTC->ISFR)&PORT_ISFR_ISF(1 << 8)){  //CS
PORTC_IRQHandler:
        LDR.W    R0,??DataTable10_41  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+23
        BPL.N    ??PORTC_IRQHandler_0
//  479     PORTC->ISFR |= PORT_ISFR_ISF(1 << 8);
        LDR.N    R0,??DataTable10_41  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable10_41  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  480     if(img_row < IMG_ROWS && cam_row % IMG_STEP == 0 ){
        LDR.N    R0,??DataTable10_42
        LDRB     R0,[R0, #+0]
        CMP      R0,#+64
        BGE.N    ??PORTC_IRQHandler_1
        LDR.N    R0,??DataTable10_43
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        SDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BNE.N    ??PORTC_IRQHandler_1
//  481       DMA0->TCD[0].DADDR = (u32)&cam_buffer[img_row][-BLACK_WIDTH];
        LDR.N    R0,??DataTable10_44
        LDR.N    R1,??DataTable10_42
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+155
        MLA      R0,R2,R1,R0
        SUBS     R0,R0,#+27
        LDR.N    R1,??DataTable10_45  ;; 0x40009010
        STR      R0,[R1, #+0]
//  482       DMA0->ERQ |= DMA_ERQ_ERQ0_MASK; //Enable DMA0
        LDR.N    R0,??DataTable10_46  ;; 0x4000800c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_46  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  483       ADC0->SC1[0] |= ADC_SC1_ADCH(4); //Restart ADC
        LDR.N    R0,??DataTable10_47  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable10_47  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  484       DMA0->TCD[0].CSR |= DMA_CSR_START_MASK; //Start
        LDR.N    R0,??DataTable10_48  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_48  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  485     }
//  486     cam_row++;
??PORTC_IRQHandler_1:
        LDR.N    R0,??DataTable10_43
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_43
        STRB     R0,[R1, #+0]
        B.N      ??PORTC_IRQHandler_2
//  487   }
//  488   else if(PORTC->ISFR&PORT_ISFR_ISF(1 << 9)){   //VS
??PORTC_IRQHandler_0:
        LDR.N    R0,??DataTable10_41  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+22
        BPL.N    ??PORTC_IRQHandler_2
//  489     PORTC->ISFR |= PORT_ISFR_ISF(1 << 9);
        LDR.N    R0,??DataTable10_41  ;; 0x4004b0a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200
        LDR.N    R1,??DataTable10_41  ;; 0x4004b0a0
        STR      R0,[R1, #+0]
//  490     cam_row = img_row = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_42
        STRB     R0,[R1, #+0]
        LDR.N    R0,??DataTable10_42
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??DataTable10_43
        STRB     R0,[R1, #+0]
//  491   }
//  492 }
??PORTC_IRQHandler_2:
        BX       LR               ;; return
//  493 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  494 void DMA0_IRQHandler(){
//  495   DMA0->CINT &= ~DMA_CINT_CINT(7); //Clear DMA0 Interrupt Flag
DMA0_IRQHandler:
        LDR.N    R0,??DataTable10_49  ;; 0x4000801f
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xF8
        LDR.N    R1,??DataTable10_49  ;; 0x4000801f
        STRB     R0,[R1, #+0]
//  496   
//  497   img_row++; 
        LDR.N    R0,??DataTable10_42
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable10_42
        STRB     R0,[R1, #+0]
//  498 }
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
        DC32     0xe000e400

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x400ff090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x447a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0xc47a0000
//  499 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  500 void Cam_Init(){
Cam_Init:
        PUSH     {R4,LR}
//  501   // --- IO ---
//  502   
//  503   PORTC->PCR[8] |= PORT_PCR_MUX(1); //cs
        LDR.N    R0,??DataTable10_50  ;; 0x4004b020
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable10_50  ;; 0x4004b020
        STR      R0,[R1, #+0]
//  504   PORTC->PCR[9] |= PORT_PCR_MUX(1); //vs
        LDR.N    R0,??DataTable10_51  ;; 0x4004b024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable10_51  ;; 0x4004b024
        STR      R0,[R1, #+0]
//  505   PORTC->PCR[11] |= PORT_PCR_MUX(1);    //oe
        LDR.N    R0,??DataTable10_52  ;; 0x4004b02c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100
        LDR.N    R1,??DataTable10_52  ;; 0x4004b02c
        STR      R0,[R1, #+0]
//  506   PTC->PDDR &=~(3<<8);
        LDR.N    R0,??DataTable10_53  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x300
        LDR.N    R1,??DataTable10_53  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  507   PTC->PDDR &=~(1<<11);
        LDR.N    R0,??DataTable10_53  ;; 0x400ff094
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x800
        LDR.N    R1,??DataTable10_53  ;; 0x400ff094
        STR      R0,[R1, #+0]
//  508   PORTC->PCR[8] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
        LDR.N    R0,??DataTable10_50  ;; 0x4004b020
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xA0000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable10_50  ;; 0x4004b020
        STR      R0,[R1, #+0]
//  509   PORTC->PCR[9] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(9);  // rising edge
        LDR.N    R0,??DataTable10_51  ;; 0x4004b024
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x90000
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable10_51  ;; 0x4004b024
        STR      R0,[R1, #+0]
//  510   PORTC->PCR[11] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
        LDR.N    R0,??DataTable10_52  ;; 0x4004b02c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x3
        LDR.N    R1,??DataTable10_52  ;; 0x4004b02c
        STR      R0,[R1, #+0]
//  511   
//  512   NVIC_EnableIRQ(PORTC_IRQn);
        MOVS     R0,#+89
        BL       NVIC_EnableIRQ
//  513   NVIC_SetPriority(PORTC_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+89
        BL       NVIC_SetPriority
//  514   
//  515   // --- AD ---
//  516   
//  517   /*
//  518   SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK;  //ADC1 Clock Enable
//  519   ADC0->CFG1 |= 0
//  520              //|ADC_CFG1_ADLPC_MASK
//  521              | ADC_CFG1_ADICLK(1)
//  522              | ADC_CFG1_MODE(0);     // 8 bits
//  523              //| ADC_CFG1_ADIV(0);
//  524   ADC0->CFG2 |= //ADC_CFG2_ADHSC_MASK |
//  525                 ADC_CFG2_MUXSEL_MASK |  // b
//  526                 ADC_CFG2_ADACKEN_MASK; 
//  527   
//  528   ADC0->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
//  529   
//  530   ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA
//  531   
//  532   ADC0->SC3 |= ADC_SC3_ADCO_MASK; // continuous
//  533   
//  534   //PORTC->PCR[2]|=PORT_PCR_MUX(0);//adc1-4a
//  535   
//  536   ADC0->SC1[0] |= ADC_SC1_ADCH(4);
//  537   */
//  538   
//  539   SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK; //ADC1 Clock Enable
        LDR.N    R0,??DataTable10_54  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable10_54  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  540   ADC0->SC1[0] &= ~ADC_SC1_AIEN_MASK; //ADC1A
        LDR.N    R0,??DataTable10_47  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable10_47  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  541   ADC0->SC1[0] = 0x00000000; //Clear
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_47  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  542   ADC0->SC1[0] |= ADC_SC1_ADCH(4); //ADC1_5->Input, Single Pin, No interrupt
        LDR.N    R0,??DataTable10_47  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable10_47  ;; 0x4003b000
        STR      R0,[R1, #+0]
//  543   ADC0->SC1[1] &= ~ADC_SC1_AIEN_MASK; //ADC1B
        LDR.N    R0,??DataTable10_55  ;; 0x4003b004
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable10_55  ;; 0x4003b004
        STR      R0,[R1, #+0]
//  544   ADC0->SC1[1] |= ADC_SC1_ADCH(4); //ADC1_5b
        LDR.N    R0,??DataTable10_55  ;; 0x4003b004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable10_55  ;; 0x4003b004
        STR      R0,[R1, #+0]
//  545   ADC0->SC2 &= 0x00000000; //Clear all.
        LDR.N    R0,??DataTable10_56  ;; 0x4003b020
        LDR      R4,[R0, #+0]
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_56  ;; 0x4003b020
        STR      R0,[R1, #+0]
//  546   ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA, SoftWare
        LDR.N    R0,??DataTable10_56  ;; 0x4003b020
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable10_56  ;; 0x4003b020
        STR      R0,[R1, #+0]
//  547   ADC0->SC3 &= (~ADC_SC3_AVGE_MASK&~ADC_SC3_AVGS_MASK); //hardware average disabled
        LDR.N    R0,??DataTable10_57  ;; 0x4003b024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+3
        LSLS     R0,R0,#+3
        LDR.N    R1,??DataTable10_57  ;; 0x4003b024
        STR      R0,[R1, #+0]
//  548   ADC0->SC3 |= ADC_SC3_ADCO_MASK; //Continuous conversion enable
        LDR.N    R0,??DataTable10_57  ;; 0x4003b024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_57  ;; 0x4003b024
        STR      R0,[R1, #+0]
//  549   ADC0->CFG1|=ADC_CFG1_ADICLK(1)|ADC_CFG1_MODE(0)|ADC_CFG1_ADIV(0);//InputClk, ShortTime, 8bits, Bus
        LDR.N    R0,??DataTable10_58  ;; 0x4003b008
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_58  ;; 0x4003b008
        STR      R0,[R1, #+0]
//  550   ADC0->CFG2 |= ADC_CFG2_MUXSEL_MASK; //ADC1  b
        LDR.N    R0,??DataTable10_59  ;; 0x4003b00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10_59  ;; 0x4003b00c
        STR      R0,[R1, #+0]
//  551   ADC0->CFG2 |= ADC_CFG2_ADACKEN_MASK; //OutputClock
        LDR.N    R0,??DataTable10_59  ;; 0x4003b00c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_59  ;; 0x4003b00c
        STR      R0,[R1, #+0]
//  552     
//  553   // --- DMA ---
//  554   
//  555   SIM->SCGC6 |= SIM_SCGC6_DMAMUX_MASK; //DMAMUX Clock Enable
        LDR.N    R0,??DataTable10_54  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable10_54  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  556   SIM->SCGC7 |= SIM_SCGC7_DMA_MASK; //DMA Clock Enable
        LDR.N    R0,??DataTable10_60  ;; 0x40048040
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable10_60  ;; 0x40048040
        STR      R0,[R1, #+0]
//  557   DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_SOURCE(40); //DMA0->No.40 request, ADC0
        LDR.N    R0,??DataTable10_61  ;; 0x40021000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x28
        LDR.N    R1,??DataTable10_61  ;; 0x40021000
        STRB     R0,[R1, #+0]
//  558   DMA0->TCD[0].SADDR = (uint32_t) & (ADC0->R[0]); //Source Address 0x400B_B010h
        LDR.N    R0,??DataTable10_62  ;; 0x4003b010
        LDR.N    R1,??DataTable10_63  ;; 0x40009000
        STR      R0,[R1, #+0]
//  559   DMA0->TCD[0].SOFF = 0; //Source Fixed
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_64  ;; 0x40009004
        STRH     R0,[R1, #+0]
//  560   DMA0->TCD[0].ATTR = DMA_ATTR_SSIZE(0) | DMA_ATTR_DSIZE(0); //Source 8 bits, Aim 8 bits
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_65  ;; 0x40009006
        STRH     R0,[R1, #+0]
//  561   DMA0->TCD[0].NBYTES_MLNO = DMA_NBYTES_MLNO_NBYTES(1); //one byte each
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_66  ;; 0x40009008
        STR      R0,[R1, #+0]
//  562   DMA0->TCD[0].SLAST = 0; //Last Source fixed
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_67  ;; 0x4000900c
        STR      R0,[R1, #+0]
//  563   DMA0->TCD[0].DADDR = (u32)cam_buffer;
        LDR.N    R0,??DataTable10_44
        LDR.N    R1,??DataTable10_45  ;; 0x40009010
        STR      R0,[R1, #+0]
//  564   DMA0->TCD[0].DOFF = 1;
        MOVS     R0,#+1
        LDR.N    R1,??DataTable10_68  ;; 0x40009014
        STRH     R0,[R1, #+0]
//  565   DMA0->TCD[0].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(IMG_COLS+BLACK_WIDTH);
        MOVS     R0,#+155
        LDR.N    R1,??DataTable10_69  ;; 0x40009016
        STRH     R0,[R1, #+0]
//  566   DMA0->TCD[0].DLAST_SGA = 0;
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_70  ;; 0x40009018
        STR      R0,[R1, #+0]
//  567   DMA0->TCD[0].BITER_ELINKNO = DMA_BITER_ELINKNO_BITER(IMG_COLS+BLACK_WIDTH);
        MOVS     R0,#+155
        LDR.N    R1,??DataTable10_71  ;; 0x4000901e
        STRH     R0,[R1, #+0]
//  568   DMA0->TCD[0].CSR = 0x00000000; //Clear
        MOVS     R0,#+0
        LDR.N    R1,??DataTable10_48  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  569   DMA0->TCD[0].CSR |= DMA_CSR_DREQ_MASK; //Auto Clear
        LDR.N    R0,??DataTable10_48  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable10_48  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  570   DMA0->TCD[0].CSR |= DMA_CSR_INTMAJOR_MASK; //Enable Major Loop Int
        LDR.N    R0,??DataTable10_48  ;; 0x4000901c
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable10_48  ;; 0x4000901c
        STRH     R0,[R1, #+0]
//  571   DMA0->INT |= DMA_INT_INT0_MASK; //Open Interrupt
        LDR.N    R0,??DataTable10_72  ;; 0x40008024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable10_72  ;; 0x40008024
        STR      R0,[R1, #+0]
//  572   //DMA->ERQ&=~DMA_ERQ_ERQ0_MASK;//Clear Disable
//  573   DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_ENBL_MASK; //Enable
        LDR.N    R0,??DataTable10_61  ;; 0x40021000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable10_61  ;; 0x40021000
        STRB     R0,[R1, #+0]
//  574   
//  575   NVIC_EnableIRQ(DMA0_IRQn);
        MOVS     R0,#+0
        BL       NVIC_EnableIRQ
//  576   NVIC_SetPriority(DMA0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
        MOVS     R2,#+2
        MOVS     R1,#+1
        MOVS     R0,#+5
        BL       NVIC_EncodePriority
        MOVS     R1,R0
        MOVS     R0,#+0
        BL       NVIC_SetPriority
//  577 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0x43fa0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     road_B

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x40590000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     0x42860000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     mid_ave

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     debug_speed

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     0xfffffeca

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     slope_mid

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     curvatureL

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_9:
        DC32     curvatureR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_10:
        DC32     valid_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_11:
        DC32     ??mid_ave3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_12:
        DC32     margin

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_13:
        DC32     valid_row_thr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_14:
        DC32     road_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_15:
        DC32     weight

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_16:
        DC32     0xc2840000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_17:
        DC32     ??err

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_18:
        DC32     debug_dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_19:
        DC32     0x40100000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_20:
        DC32     0x40080000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_21:
        DC32     ??last_err

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_22:
        DC32     ??dir

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_23:
        DC32     0x3ff33333

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_24:
        DC32     car_state

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_25:
        DC32     0xc1400000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_26:
        DC32     motor_R

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_27:
        DC32     motor_L

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_28:
        DC32     0x51eb851f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_29:
        DC32     0x3fd51eb8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_30:
        DC32     0x40468000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_31:
        DC32     0xcccccccd

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_32:
        DC32     0x3feccccc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_33:
        DC32     0x41400000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_34:
        DC32     0x40568000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_35:
        DC32     0x9999999a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_36:
        DC32     0x3fe99999

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_37:
        DC32     0x3fe51eb8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_38:
        DC32     0x3fe66666

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_39:
        DC32     R

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_40:
        DC32     L

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_41:
        DC32     0x4004b0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_42:
        DC32     img_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_43:
        DC32     cam_row

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_44:
        DC32     cam_buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_45:
        DC32     0x40009010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_46:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_47:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_48:
        DC32     0x4000901c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_49:
        DC32     0x4000801f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_50:
        DC32     0x4004b020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_51:
        DC32     0x4004b024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_52:
        DC32     0x4004b02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_53:
        DC32     0x400ff094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_54:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_55:
        DC32     0x4003b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_56:
        DC32     0x4003b020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_57:
        DC32     0x4003b024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_58:
        DC32     0x4003b008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_59:
        DC32     0x4003b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_60:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_61:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_62:
        DC32     0x4003b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_63:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_64:
        DC32     0x40009004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_65:
        DC32     0x40009006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_66:
        DC32     0x40009008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_67:
        DC32     0x4000900c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_68:
        DC32     0x40009014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_69:
        DC32     0x40009016

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_70:
        DC32     0x40009018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_71:
        DC32     0x4000901e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_72:
        DC32     0x40008024

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
// 10 506 bytes in section .bss
//    200 bytes in section .data
//  4 274 bytes in section .text
// 
//  4 274 bytes of CODE memory
// 10 706 bytes of DATA memory
//
//Errors: none
//Warnings: 6
