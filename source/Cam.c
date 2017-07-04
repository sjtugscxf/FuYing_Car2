/*
Arthor : Qian Qiyang (KisaragiAyanoo@twitter)
Date : 2015/12/01
License : MIT
*/

#include "includes.h"


// ====== Variables ======
// ---- Global ----
u8 cam_buffer_safe[BLACK_WIDTH*2];
u8 cam_buffer[IMG_ROWS][IMG_COLS+BLACK_WIDTH];   //64*155���ѺڵĲ�����ȥ��59*128
Road road_B[ROAD_SIZE];//�ɽ���Զ���
float mid_ave;//road�е��Ȩ���ֵ
//float  weight[10] = {1,1,1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744}; //2.296};//, 1.454};//��һ�ε�Ȩֵ
//float weight[10] = {1.04,1.14,1.41,2.01,3.03,4.35,5.52,6,5.52,4.35};//������
float weight[4][10] ={ {0,0,0,0,0,0,0,0,0,0},
                        {1,1,1,1,1,1,1,1,1,1},
                        {1.00,1.03,1.14,1.54,2.56,               4.29,6.16,7.00,6.16,4.29},
                        {1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454}};
int valid_row=0;//����Ч����أ�δ��Чʶ��
int valid_row_thr=10;//��Ч����ֵ
u8 car_state=0;//���ܳ�״̬��־ 0��ֹͣ  1�����Զ��  2������Ѳ��
u8 remote_state = 0;//Զ�̿���
u8 road_state = 0;//ǰ����·״̬ 1��ֱ��   2�����  3������  4���ϰ�
                  //3 4 ״̬��Ȩ������
                  //2 ״̬�¼���

float motor_L=MIN_SPEED;
float motor_R=MIN_SPEED;

//OLED����
int debug_speed=0;
PIDInfo debug_dir;
int margin=30;

//��������========================================
int CAM_HOLE_ROW=27; //����������ɨ����ڶ���������cam_buffer��λ��     //����
int check_farthest=20;  //˫���ӳ����ڶ�����ʱ����Զ���λ�ã�cam_buffer�±꣬ԽСԽԶ������̫С�������Ρ�����������
                        
int check_near=10;//���ڹ۲�Ͻ�����·���ж��Ƿ���зֵ���road_B�±꣬ԽСԽ������ֵ��road_width_thr�����������Ρ�����������
                  //��Ӧ·�� 5 -> ֱ��50+ or ���70+ or �뻷����ʮ��110+ or ����������80~100+ 
int road_width_thr=90;//��ֵͨ���۲�check_near��Ӧ�е�����·����ȷ��
int time_cnt=0;
//���³���ʱ��Ҫȫ������
int roundabout_state=0;//0-�ǻ��� 1-Ԥ�뻷����ֱ���� 2-�뻷����ת�� 3-�ڻ��� 4-��������ת��      ע�������ʱ�����������״̬
int roundabout_choice=0;//0-δѡ�� 1-�� 2-�� 3-���ҽԿ�(����)
int cnt_miss=0; //�ۼ�δ�жϳɻ����Ĵ���
bool former_choose_left=0,former_choose_right=0;//1=choose 0=not choose
bool is_cross=0; //�ж��Ƿ���ʮ��
bool jump_miss=0; // ��¼����δ��⵽�յ�Ĵ���
int forced_turn=0;
int jump_thr=20;//��������������ֵ
int jump[2][2];//��յ����� 0�� 1�� 0-x 1-y
bool flag_left_jump=0,flag_right_jump=0;
//Hole hole;

//ͣ������=======================
bool flag_stop=0;
int stop_time=2000;

//Ϊ����ȡƽ�������ã�
int left[DEPTH][ROAD_SIZE];
int right[DEPTH][ROAD_SIZE];
int k_depth=0;

/*
circle C;
int c1=15, c2=10, c3=5;
*/
//=====================
//int CAM_HOLE_ROW=27; //����������ɨ����ڶ���������cam_buffer��λ��
int ROAD_OBST_ROW=10; //��������ϰ����road_B��λ��//����̫Զ��Ҳ����̫��
int OBSTACLE_THR=40;  //���ϰ���ʱ���������ֵ

//׼������
bool prepare_overtake = 0;

// ---- Local ----
u8 cam_row = 0, img_row = 0;
/*
//������������͸�ӱ任������������������
double matrix[4][4];
//int buffer[64][128];=cam_buffer
int former[8200][4];
int later[8200][4];
u8 cam_buffer2[64][128];//int buffer2[64][128];
int visited[64][128];

//������������͸�ӱ任������������������

void getMatrix(double fov, double aspect, double zn, double zf){
    matrix[0][0] = 1 / (tan(fov * 0.5) *aspect) ;
    matrix[1][1] = 1 / tan(fov * 0.5) ;
    matrix[2][2] = zf / (zf - zn) ;
    matrix[2][3] = 1.0;
    matrix[3][2] = (zn * zf) / (zn - zf);
    return;
}

void linearization(){
    int cnt = 0;
    for (int i=0;i<64;i++){
        for (int j=0;j<128;j++){
            former[cnt][0] = i;
            former[cnt][1] = j;
            former[cnt][2] = cam_buffer[i][j];//buffer[i][j];
            former[cnt][3] = 1;
            cnt++;
        }
    }
    return;
}

void multiply(int k){
    for (int i=0;i<4;i++){
        later[k][i] = former[k][0]*matrix[0][i]+former[k][1]*matrix[1][i]+former[k][2]*matrix[2][i]+former[k][3]+matrix[3][i];
    }
    return;
}

void matrixMultiply(){
    for (int i=0;i<8192;i++){
        multiply(i);
    }
    return;
}

void getNewBuffer(){
    for (int i=0;i<64;i++){
        for (int j=0;j<128;j++){
            cam_buffer2[i][j] = 0;
        }
    }
    for (int i=0;i<8192;i++){
        cam_buffer2[later[i][0]][later[i][1]] = later[i][2];
    }
    return;
}
*/

// ====== 

void Cam_Algorithm(){
  static u8 img_row_used = 0;
  
  while(img_row_used ==  img_row%IMG_ROWS); // wait for a new row received
  
  // -- Handle the row --  
  
  if (img_row_used >= BLACK_HEIGHT) {     //ǰ5�кڵĲ�Ҫ
    for (int col = 0; col < IMG_COLS; col++) {
      u8 tmp = cam_buffer[img_row_used][col];
      if(!SW1()) UART_SendChar(tmp < 0xfe ? tmp : 0xfd);
    }
   if(!SW1()) UART_SendChar(0xfe);//0xfe->��������ȡ���
  }
  
  //  -- The row is used --
  img_row_used++;
  if (img_row_used == IMG_ROWS) {    //һ֡ͼ�����й��㣬�����㷨����������AI_Run
    img_row_used = 0;

    if(!SW1()) UART_SendChar(0xff);//0xff->�쳣����
  }//����ԭ����SW1()
}

float constrain(float lowerBoundary, float upperBoundary, float input)
{
	if (input > upperBoundary)
		return upperBoundary;
	else if (input < lowerBoundary)
		return lowerBoundary;
	else
		return input;
}

int constrainInt(int lowerBoundary, int upperBoundary, int input)
{
	if (input > upperBoundary)
		return upperBoundary;
	else if (input < lowerBoundary)
		return lowerBoundary;
	else
		return input;
}

circle getR(float x1, float y1, float x2, float y2, float x3, float y3)
{
  double a,b,c,d,e,f;
  double r,x,y;
	
  a=2*(x2-x1);
  b=2*(y2-y1);
  c=x2*x2+y2*y2-x1*x1-y1*y1;
  d=2*(x3-x2);
  e=2*(y3-y2);
  f=x3*x3+y3*y3-x2*x2-y2*y2;
  x=(b*f-e*c)/(b*d-e*a);
  y=(d*c-a*f)/(b*d-e*a);
  r=sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
  x=constrain(-1000.0,1000.0,x);
  y=constrain(-1000.0,1000.0,y);
  r=constrain(1.0,500.0,r);
  bool sign = (x>0)?1:0;
  circle tmp = {r,sign};
  return tmp;
}

bool is_stop_line(int target_line)//Ŀ�Ⲣ����Ч����
{
  if((road_B[target_line].right-road_B[target_line].left)<ROAD_WID)
    return 1;
  else return 0;
}

double getSlope_(int x1, int y1, int x2, int y2)
{
  double dx = x2-x1;
  double dy = y2-y1;
  if(dy==0) return dx*100;
  else return (double)dx/dy;
}

void Cam_B_Init()//��ʼ��Cam_B
{
  int i=0;
  for(i=0;i<ROAD_SIZE;i++)
  {
    road_B[i].left=CAM_WID/2;
    road_B[i].right=CAM_WID/2+2;
    road_B[i].mid=CAM_WID/2+1;
  }
  mid_ave=CAM_WID/2+1;
  //����Ϊroad->mid��Ȩֵweight�ĳ�ʼ�����ɽ���Զ
  //����һ���ֶκ���
  /*for(i=0;i<3;i++)
  {  
    weight[i]=1;
  }
  for(i=3;i<7;i++)
  {  
    weight[i]=2;
  }
  for(i=7;i<10;i++)
  {
    weight[i]=1;
  }*/
  
  //�������������̬�ֲ������ֵ��weight[MaxWeight_index]����ͷ�ļ�������ز���//���ǡ�����Ч������֪Ϊ��
/*  for(int i=0;i<10;i++)
  {
    weight[i]=1.0 + MaxWeight * exp(-(double)exp_k*pow((double)(i-MaxWeight_index),2.0)/2.0); //Ŀǰ����±�Ϊ����
  }*/
  
  // design 3 ����>�����붨���һ�飬global
//  weight = {1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744, 2.296, 1.454};
  
}

    //���籣��  //��Ч����
  /*  static bool flag_protect=0;
    if((cam_buffer[56][60]+cam_buffer[57][60]+cam_buffer[58][60])<3*thr||flag_protect==1){                       //�������ƣ�ò�Ʋ�̫����cam_buffer[45][64]<70 && cam_buffer[50][64]<70 &&
      Servo_Output(0);
      PWM(0, 0, &L, &R); 
      flag_protect=1;
    }*/

//test
double theta,theta_d,slope,test;
double x,y;


bool is_hole(int row)
{
  int left=0,right=0;
    if(cam_buffer[row][CAM_WID/2]<thr)
    {
      //left
      int i=CAM_WID/2-1;
      while(i>0){
        if(left==0 && cam_buffer[row][i]>thr){//�Ƿ���ȡƽ�������䣿
          left++;
        }
        else if(left==1 && cam_buffer[row][i]<thr){
          left++;
        }
        i--;
      }
      //right
      i=CAM_WID/2+1;
      while(i<CAM_WID){
        if(right==0 && cam_buffer[row][i]>thr){//�Ƿ���ȡƽ�������䣿
          right++;
        }
        else if(right==1 && cam_buffer[row][i]<thr){
          right++;
        }
        i++;
      }
    }
    bool static hole=0;
    if(left>=1 && right>=1)
      return 1;
    else return 0;
        
}

bool isWider(int row)
{
  int wid=0;
  for(int i=-1;i<2;i++)
    wid+=(road_B[row+i].right-road_B[row+i].left);
  wid /= 3;
  if(wid>road_width_thr)
    return 1;
  else return 0;
  
}
  //��һ�ν�����Ѳ�߳���
void Cam_B(){
  
    //===================��������====================
  
    float max_speed=MAX_SPEED+debug_speed;//����ٶ�
    static int dir;//������
    
    //================================͸�ӱ仯
    //getMatrix(0.785398,1.0,1.0,1000);
   // linearization();
   // matrixMultiply();
   // getNewBuffer();
 
    //==================================��ȡroad_B��left right mid �����slope_
    //б�ʷ���
    /*
    for(int j=0;j<ROAD_SIZE;j++)//��������ɨ��
    {
      //double x,y;
      slope=road_B[j].slope_;
      theta=atan(road_B[j].slope_);//double theta=atan(road_B[j].slope_);
      test=sin(theta);
      test=cos(theta);
      test=tan(theta);
      theta_d=theta*180/PI;
      test=sin(theta_d);//�����������atan�����Լ�sin����ʹ�õ��Ƿ���ȷ��debugģʽ��
      //left
      x=road_B[j].mid[0];
      y=road_B[j].mid[1];
      while(x>=0 && x<=CAM_WID && y<=CAM_NEAR && y>=CAM_FAR)
      {
        if(cam_buffer[(int)y][(int)x]<thr)
          break;
        else
        {
          x-=cos(theta);
          y-=sin(theta);
        }
      }
      road_B[j].left[0]=constrain(0,CAM_WID,x);
      road_B[j].left[1]=constrain(CAM_FAR,CAM_NEAR,y);

      //right
      x=road_B[j].mid[0];
      y=road_B[j].mid[1];
      while(x>=0 && x<=CAM_WID && y<=CAM_NEAR && y>=CAM_FAR)
      {
        if(cam_buffer[(int)y][(int)x]<thr)
          break;
        else
        {
          x+=cos(theta);
          y+=sin(theta);
        }
      }
      road_B[j].right[0]=constrain(0,CAM_WID,x);
      road_B[j].right[1]=constrain(CAM_FAR,CAM_NEAR,y);
      //mid
      road_B[j].mid[0] = (road_B[j].left[0] + road_B[j].right[0])/2;
      road_B[j].mid[1] = (road_B[j].left[1] + road_B[j].right[1])/2;//�ֱ���㲢�洢25�е�mid
      //slope
      if(j>0)
      {
        road_B[j].slope_=getSlope_(road_B[j-1].mid[0],-road_B[j-1].mid[1],road_B[j].mid[0],-road_B[j].mid[1]);
        road_B[j+1].slope_=road_B[j].slope_;//����Ԥ����һ��mid
      }
      //mid of the next road_B[]
      if(j<(ROAD_SIZE-1))
      {
        road_B[j+1].mid[0]=road_B[j].mid[0]+CAM_STEP*sin(theta);
        road_B[j+1].mid[1]=road_B[j].mid[1]-CAM_STEP*cos(theta);
      }
    }
    */
    //����ɨ�跽��
    for(int j=0;j<ROAD_SIZE;j++)//��������ɨ��
    {
      int i;
      //left
      for (i = road_B[j].mid; i > 0; i--){
        if (cam_buffer[60-CAM_STEP*j][i] < thr)
          break;
        }
      left[k_depth][j]=i;
      road_B[j].left = i;
      //right
      for (i = road_B[j].mid; i < CAM_WID; i++){
        if (cam_buffer[60-CAM_STEP*j][i] < thr)
          break;
        }
      right[k_depth][j]=i;
      road_B[j].right = i;
      //mid
      road_B[j].mid = (road_B[j].left + road_B[j].right)/2;//�ֱ���㲢�洢25�е�mid
      //store
      if(j<(ROAD_SIZE-1))
        road_B[j+1].mid=road_B[j].mid;//��һ�д�ǰһ���е㿪ʼɨ��
    }
      
    //===========================����ǰ����·����//��Ҫ����һ�����ȼ�������
    static int mid_ave3;
    static bool flag_valid_row=0;
    for(int i_valid=0;i_valid<(ROAD_SIZE-3) && flag_valid_row==0;i_valid++)
    {
      mid_ave3 = (road_B[i_valid].mid + road_B[i_valid+1].mid + road_B[i_valid+2].mid)/3;
      if(mid_ave3<margin||mid_ave3>(CAM_WID-margin))
      {
        flag_valid_row=1;
        valid_row=i_valid;
      }
      //else valid_row=ROAD_SIZE-3;
    }
    
    if(flag_valid_row==0) valid_row=ROAD_SIZE-3;
    if(roundabout_state==0){    //�ǻ�������ʱ����ѡ��ֱ���������
      if(valid_row<valid_row_thr){
        road_state=2;                     //���
        //cnt_miss++;
      }
      else {
        road_state=1;                     //ֱ��
        //cnt_miss++;
      }
    }
    
     //���ֻ�����ʮ�ֵ��ӳ��߷����£�
    if(roundabout_state==0){     //��û�м�⵽����������йյ㣨jump����⣬���£�
   // if(1){
      int cnt=0,tmpl1=0,tmpl2=0,tmpr1=0,tmpr2=0;
      double suml=0,sumr=0;
      //int thr_tmp=0;//δ��
      flag_left_jump=0,flag_right_jump=0;
      for(cnt=0;cnt<ROAD_SIZE-1;cnt++){
        if(flag_left_jump==0){
          tmpl2=tmpl1;
          tmpl1=road_B[cnt+1].left-road_B[cnt].left;
          suml+=tmpl1;
          if((tmpl2-tmpl1)>jump_thr && cnt>(ROAD_SIZE/5)){      //����������ֱ�����Ȳ���̫�̣���ȻżȻ�Խϴ�
//          if(tmpl1<0&&tmpl2>0) {      //����̭�ĺ���������
            flag_left_jump=1;
            jump[0][0]=road_B[cnt].left;
            jump[0][1]=60-CAM_STEP*cnt;
          }
        }
        
        if(flag_right_jump==0){
          tmpr2=tmpr1;
          tmpr1=road_B[cnt+1].right-road_B[cnt].right;
          sumr+=tmpr1;
          if((tmpr1-tmpr2)>jump_thr && cnt>(ROAD_SIZE/5)){      //����������ֱ�����Ȳ���̫�̣���ȻżȻ�Խϴ�
//          if(tmpr1>0&&tmpr2<0) {
            flag_right_jump=1;
            jump[1][0]=road_B[cnt].right;
            jump[1][1]=60-CAM_STEP*cnt;
          } 
        }       
       if(flag_left_jump==1&&flag_right_jump==1)//��⵽�����յ�
         break;
      }
      if(flag_left_jump==1&&flag_right_jump==1){//����⵽�����յ㣬���ж��ǻ�������ʮ�֣����£�
        //suml  cnt*CAM_STEP
        int cnt_black_row=0;//��־
        int left_now,right_now;//�浱ǰ��ɨ��߽�
        
        for(int j=cnt;(60-CAM_STEP*j)>check_farthest;j++){//��Զ����check_farthest�����Ρ�������������������������������������������
          left_now=jump[0][0]+suml*j/(cnt*CAM_STEP);
          right_now=jump[1][0]+sumr*j/(cnt*CAM_STEP);
          int cnt_black=0;
          for (int i = left_now; i < right_now; i++){
            if (cam_buffer[60-CAM_STEP*j][i] < thr)
              cnt_black++;
          }
          if(cnt_black>(right_now-left_now)*0.8) cnt_black_row++;
          if(cnt_black_row>=3){
            if(is_hole(CAM_HOLE_ROW)){
              road_state=3;                       //��ɻ����ж�
              roundabout_state=1;
              cnt_miss=0;
            }
            break;
          }
          else is_cross=1;
        }
      }
      //������ʱ����ֻ��һ���յ㣬����
      else{
        if (flag_left_jump==1 && is_cross==0){
          former_choose_left==1;
          jump_miss=0;
        }
        if (flag_right_jump==1 && is_cross==0){
          former_choose_right=1;
          jump_miss=0;
        }
        
        //���δ��⵽�յ㣬����
        if (flag_left_jump==0 && flag_right_jump==0){
          jump_miss++;
        }
      }
    }
    ///////////////////////////////////////////////////////////
    //detect the black hole����������������������������������������
    /*
    int left=0,right=0;
    if(cam_buffer[CAM_HOLE_ROW][CAM_WID/2]<thr)
    {
      //left
      int i=CAM_WID/2-1;
      while(i>0){
        if(left==0 && cam_buffer[CAM_HOLE_ROW][i]>thr){//�Ƿ���ȡƽ�������䣿
          left++;
        }
        else if(left==1 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          left++;
        }
        i--;
      }
      //right
      i=CAM_WID/2+1;
      while(i<CAM_WID){
        if(right==0 && cam_buffer[CAM_HOLE_ROW][i]>thr){//�Ƿ���ȡƽ�������䣿
          right++;
        }
        else if(right==1 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          right++;
        }
        i++;
      }
    }
    if(left>=1 && right>=1)
      road_state=3;
    */
    //ǰ������
    //detect the obstacle����������������������������������������
  /*  if((road_B[ROAD_OBST_ROW].right-road_B[ROAD_OBST_ROW].left)<OBSTACLE_THR)
    {
      int i=road_B[ROAD_OBST_ROW].mid;
      left=0;
      right=0;
      //left
      while(i>0){
        if(left==0 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          left++;
        }
        else if(left==1 && cam_buffer[CAM_HOLE_ROW][i]>thr){
          left++;
        }
        else if(left==2 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          left++;
        }
        i--;
      }
      //right
      while(i<CAM_WID){
        if(right==0 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          right++;
        }
        else if(right==1 && cam_buffer[CAM_HOLE_ROW][i]>thr){
          right++;
        }
        else if(right==2 && cam_buffer[CAM_HOLE_ROW][i]<thr){
          right++;
        }
        i++;
      }
      if(left>=3 || right>=3)
        road_state=4;
    }*/
    
  /*  //=============================����ǰ����·���ͣ�ѡ��ͬ��Ȩֵweight
     switch(road_state)
    {
      case 1: 
        for(int i=0;i<10;i++)weight[i]=1;//���ȷֲ���Ȩֵ
        break;
      case 2:
        max_speed=MAX_SPEED-5;//������δ����ȡ�����������ٶ�
        float weight2[10] = {1.00,1.03,1.14,1.54,2.56,4.29,6.16,7.00,6.16,4.29};
        for(int i;i<10;i++) weight[i] = weight2[i];//��̬�ֲ���Ȩֵ
        break;
      case 3:
        max_speed=MAX_SPEED-5;
        float  weight3[10] = {1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744, 2.296, 1.454};//δȷ��
        for(int i;i<10;i++) weight[i] = weight2[i];
        break;
      case 4:
        break;
      default:break;
    }*/
    
        //=============================����ǰ����·���ͣ����в�ͬ�Ĵ���
     switch(road_state)
    {
      case 1: 
        max_speed=MAX_SPEED;
       // float static weight1[10] = {1.00,1.03,1.14,1.54,2.56,4.29,6.16,7.00,6.16,4.29};//��δ������������������������
        //for(int i=0;i<10;i++) weight[i] = weight1[i];//������̬�ֲ��̶�
        break;
      case 2:
        max_speed=constrain(MIN_SPEED+1,MAX_SPEED, MAX_SPEED-5);//������δ����ȡ�����������ٶ�
        //float static weight2[10] = {1.00,1.03,1.14,1.54,2.56,4.29,6.16,7.00,6.16,4.29};
        //for(int i=0;i<10;i++) weight[i] = weight2[i];//��̬�ֲ���Ȩֵ
        break;
      case 3:
       // max_speed=constrain(MIN_SPEED+1,MAX_SPEED, MAX_SPEED-5);
        max_speed=MIN_SPEED+1;
        //float  weight3[10] = {1.118, 1.454, 2.296, 3.744, 5.304, 6.000, 5.304, 3.744, 2.296, 1.454};//δȷ��
        //for(int i=0;i<10;i++) weight[i] = weight2[i];
        switch(roundabout_state)
        {
        case 0://�ǻ�������������
          roundabout_state=0;//0-�ǻ��� 1-�뻷�����з�֧�� 2-�ڻ��� 3-���������з�֧��
          roundabout_choice=0;//0-δѡ�� 1-�� 2-�� 3-���ҽԿ�(����)
          //cnt_miss=0; //�ۼ�δ�жϳɻ����Ĵ���
          former_choose_left=0,former_choose_right=0;//1=choose 0=not choose
          //is_cross=0; //�ж��Ƿ���ʮ��
          //jump_miss=0; // ��¼����δ��⵽�յ�Ĵ���
          forced_turn=0;
          flag_stop=0;
          break;
        case 1:
          if(roundabout_choice==0){
            //��ʱ����ת�������·����ע�⣺С�������·��Ӱ�첻�󣬴󻷵��ܷ񿴵�����λ�����Ǹ����⣩
            roundabout_choice=SW1()+1;
          }
          road_width_thr=90;
          if(isWider(check_near)){//���·���ڿ���Ϊ���ֲַ棬��ʼת��
            roundabout_state=2;
            time_cnt=0;
          }
        case 2://�뻷��
          //�������٣�������
         // max_speed=min_speed+1;
         
          time_cnt++;
           // if(jump_miss>500) forced_turn=roundabout_choice;//�Ƿ���У�??????????????????????????
          //  if(jump_miss>1000){
           //   forced_turn=0; 
            //  roundabout_state=2;       //�л�����һ������״̬
                                        //��һ�취�Ǽ��ֵ��Ƿ���ڣ����룺ͨ���۲�Ͻ�����·���ж��Ƿ���зֵ�
                                        //���������£���road_B[check_near]����⣬��right-left����road_width_max���ɵ��Σ���������roundabout_choice��mid_ave���ƻ����ƣ�
          //  }
            for(int i=1;i<ROAD_SIZE;i++){   //����roundabout_choice��mid��ƫ����
              if(roundabout_choice==1) road_B[i].mid *= 0.2;
              else if(roundabout_choice==2) road_B[i].mid =constrain(0,CAM_WID-1, road_B[i].mid*1.75);
            }
            road_width_thr=100;
            if(!isWider(check_near) && time_cnt>500){ //���·��ָ���������Ϊ����뵺
              roundabout_state=3;
              time_cnt=0;
            }
            
          
          break;
        case 3://�ڻ����ڣ����������������������ʻ
           //ͣ����
          if(time_cnt>=100&&time_cnt<(100+stop_time))
            flag_stop=1;
          else flag_stop=0;
          //�������ʲôʱ����ֲַ�
          time_cnt++;
          if(roundabout_choice==1)
            if((road_B[45].mid<60 || road_B[43].mid<60 || road_B[47].mid<60) && time_cnt>=500){
              roundabout_state=4;
              time_cnt=0;
            }
          else if(roundabout_choice==2)
            if((road_B[45].mid<CAM_WID-60 || road_B[43].mid<CAM_WID-60 || road_B[47].mid<CAM_WID-60) && time_cnt>=500){
              roundabout_state=4;
              time_cnt=0;
            }
          if(time_cnt>5000) roundabout_state=0;
          //���δ��⵽��ʱ���ֳ���˵���Ѿ����������������µĴ���δд���������������������������ܻ���˶������˻�������״̬����������������������������
            //�ݲ����������������Ϊ�󻷵���С������ʱ��ͬ������һ�Ŷ��ۣ������ѷ����Ǽ�ⴿֱ������Ϊ������־��
          break;
        case 4://����������һ�ηֵ�
        //ͣ����
          if(time_cnt>=0&&time_cnt<(stop_time*0.5))
            flag_stop=1;
          else flag_stop=0;

          time_cnt++;
          for(int i=1;i<ROAD_SIZE;i+=(ROAD_SIZE/10)){   //����roundabout_choice��mid��ƫ����//��forced_turn����ͬ��
            if(roundabout_choice==1) road_B[i].mid = CAM_WID/2-35;
            else if(roundabout_choice==2) road_B[i].mid *= CAM_WID/2+35;
          }
          road_width_thr=70;
          if(!isWider(check_near) && time_cnt>=500){ //���·��ظ���������Ϊ������
            roundabout_state=0;
            time_cnt=0;
            flag_stop=0;
          }
          else if(time_cnt>5000) roundabout_state=0;   //2s δ��⵽·��ָ���������Ϊ����
          break;
          
        default:break;
        }
        
        
        //ȷ�����·����һ�ַ�����
        /*
        int left1=road_B[0].left,left2;
        int right1=road_B[0].right,right2;
        int mid1[ROAD_SIZE],mid2[ROAD_SIZE];
        mid1[0]=mid2[0]=road_B[0].mid;
        int mid_branch=CAM_WID/2;
        //������ҹյ�˭�ȳ���
        int tmpl1=0,tmpl2=0,tmpr1=0,tmpr2=0;
        bool flag_branch_choose_left=0,flag_branch_choose_right=0;//0=choose 1=not choose
        
        bool flag_branch=0;
        for(int j=0;j<ROAD_SIZE;j++)//��������ɨ�裬����ɨ�衣���Ϊ���Ч�ʣ����Կ�����ǰһ���ϲ�����
        {
          if(flag_branch==0){
            int i;
            //left
            for (i = mid1[j]; i > 0; i--){
              if (cam_buffer[60-CAM_STEP*j][i] < thr)
                break;
              }
            left1 = i;
            
            //right
            for (i = mid1[j]; i < CAM_WID; i++){
              if (cam_buffer[60-CAM_STEP*j][i] < thr)
                break;
              }
            right1 = i;
            
            //mid
            mid1[j] = (left1 + right1)/2;//�ֱ���㲢�洢ÿ�е�mid
            //next mid
            if(j<(ROAD_SIZE-1))
              mid1[j+1]=mid1[j];//��һ�д�ǰһ���е㿪ʼɨ��
            
            mid2[j]=mid1[j];//copy to mid2
            
            //�ֵ��ж�
            if(cam_buffer[60-CAM_STEP*j][mid1[j]]<thr){
              flag_branch=1;
              mid_branch=mid1[j];
            }
          }
          else{//��ʼ�ֵ�
            
            mid1[j]=(mid_branch+left1)/2;
            mid2[j]=(mid_branch+right1)/2;
            
            int i;
           //left
            if (former_choose_left==1){
            for (i = mid1[j]; i > 0; i--){
              if (cam_buffer[60-CAM_STEP*j][i] < thr)
                break;
              }
            left2=left1;
            left1 = i;
            mid1[j]=(mid_branch+left1)/2;
            }
            
            //right
            if (former_choose_right==1){
            for (i = mid2[j]; i < CAM_WID; i++){
              if (cam_buffer[60-CAM_STEP*j][i] < thr)
                break;
              }
            right2=right1;
            right1 = i;
            mid2[j]=(mid_branch+right1)/2;
            }
            
            if (former_choose_left==0 && former_choose_right==0){
            //����
            tmpl2=tmpl1;
            tmpl1=left1-left2;
            tmpr2=tmpr1;
            tmpr1=right1-right2;
            
            //���б�ʱ仯�̶�
            if(roundabout_choice==0){
              if(tmpl2>0&&tmpl1<=0)
                if((tmpl2-tmpl1)>5){
                  flag_branch_choose_left=1;//choose the left road
                  former_choose_left=1;
                  jump_miss=0;
                  roundabout_choice=1;
                  
                }
              if(tmpr2<0&&tmpr1>=0)
                if((tmpr1-tmpr2)>5){
                  flag_branch_choose_right=1;//choose the right road
                  former_choose_right=1;
                  jump_miss=0;
                  roundabout_choice=2;
                }
              if(flag_branch_choose_left==1&&flag_branch_choose_right==1)
                former_choose_left=1;
                jump_miss=0;
                roundabout_choice=3;
              
            }
            }
          }
          //�˴��ж�flag_branch�仯�Ĵ�����0-1-0-1-0��Ȼ��Ϳ�����Ϊ���������Ӷ���roundabout���������
          
        }
        //�������·������·���е�
        if((flag_branch_choose_left==1 || former_choose_left==1) && jump_miss>400) {
          forced_turn=1;
        }
        else if(flag_branch_choose_right==1 || former_choose_right==1 && jump_miss>400) {
          forced_turn=2;
        }
        if(jump_miss>600){
          forced_turn=0;
          jump_miss=0;
        }
        */
        break;
      case 4:
        break;
      default:break;
    }
    //////////////////////////////////////////////////////////////////
    
    //================================��ʮ��mid��Ȩ��
    float weight_sum=0;
    for(int j=0;j<10;j++)
    {
      mid_ave += road_B[j].mid * weight[road_state][j];
      weight_sum += weight[road_state][j];
    }
    mid_ave/=weight_sum;
    
    //=================================�����PD����
    static float err;
    static float last_err;
    
    if(prepare_overtake) err = mid_ave  - (CAM_WID / 2 - 20);
    else err = mid_ave  - CAM_WID / 2 ;

    dir = (Dir_Kp+debug_dir.kp) * err + (Dir_Kd+debug_dir.kd) * (err-last_err);     //���ת��  //����: (7,3)->(8,3.5)
    //if(dir>0)
      //dir*=1.2;//����������Ҳ��ԳƵ�����//����ɾ
    last_err = err;
    
    dir=constrainInt(-250,250,dir)-55;
    if(car_state!=0)
      Servo_Output(dir);
    else   
      Servo_Output(0);
    
    
    
    //==============�ٶȿ���=================
    //PWM��dirΪ�ο���ǰ�ڷּ���������ٶȣ����ڷֶ����Կ��٣������ҵ����ʲ�����ʱ���ٽ�����ϡ���PWM����dir�ĺ���
    float range=max_speed-MIN_SPEED;//�ٶȷ�Χ��С 
    if(flag_stop==1)
    	PWM(0,0,&L,&R);
	else if(car_state==2 ){
      //�ֶ����Կ���
      if(abs(dir)<50 ){//&& valid_row>valid_row_thr
        motor_L=motor_R=max_speed;
      }
      else if(abs(dir)<95){
        motor_L=motor_R=max_speed-0.33*range*(abs(dir)-50)/45;
        if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.9);//��ת
        else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.9);//0.9
      }
      else if(abs(dir)<185){    
        motor_L=motor_R=max_speed-0.33*range-0.33*range*(abs(dir)-95)/90;
        if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.8);//��ת
        else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.8);//0/75
      }
      else if(abs(dir)<230){
        motor_L=motor_R=max_speed-0.66*range-0.33*range*(abs(dir)-185)/45;
        if(dir>0) motor_R=constrain(MIN_SPEED,motor_R,motor_R*0.7);//��ת
        else motor_L=constrain(MIN_SPEED,motor_L,motor_L*0.7);//0.5
      }//���ϵĲ��ٿ��Ʋ���δȷ��������ʱ�Գ����ȶ���ʻΪĿ��
      else{
        motor_L=motor_R=MIN_SPEED;
      }
      
      if(waveState == STABLE)
      {
        if(distance <= 400)
        {
          motor_L *= 0.6;
          motor_R *= 0.6;
        }
        if(distance >= 600)
        {
          motor_L *= 1.1;
          motor_R *= 1.1;
        }
      }
      PWM(motor_L, motor_R, &L, &R);               //�����ٶ�
    }
   else
   {
     MotorL_Output(0); 
     MotorR_Output(0);
   }
    
    //������//��ʱ����
    //C=getR(road_B[c1].mid,20-c1,road_B[c2].mid,20-c2,road_B[c3].mid,20-c3);
    
}




// ====== Basic Drivers ======

void PORTC_IRQHandler(){
  if((PORTC->ISFR)&PORT_ISFR_ISF(1 << 8)){  //CS
    PORTC->ISFR |= PORT_ISFR_ISF(1 << 8);
    if(img_row < IMG_ROWS && cam_row % IMG_STEP == 0 ){
      DMA0->TCD[0].DADDR = (u32)&cam_buffer[img_row][-BLACK_WIDTH];
      DMA0->ERQ |= DMA_ERQ_ERQ0_MASK; //Enable DMA0
      ADC0->SC1[0] |= ADC_SC1_ADCH(4); //Restart ADC
      DMA0->TCD[0].CSR |= DMA_CSR_START_MASK; //Start
    }
    cam_row++;
  }
  else if(PORTC->ISFR&PORT_ISFR_ISF(1 << 9)){   //VS
    PORTC->ISFR |= PORT_ISFR_ISF(1 << 9);
    cam_row = img_row = 0;
  }
  else if((PORTC->ISFR)&PORT_ISFR_ISF(1 << 0)){  //�����������ж�
    PORTC->ISFR |= PORT_ISFR_ISF(1 << 0);
    if((PTC->PDIR>>0)&1)  
    {
      wavetimef=PIT2_VAL();
    }
    else 
    {
        wavetime=wavetimef-PIT2_VAL();
        wavetimeus = wavetime / (g_bus_clock/1000000); //1us
        distance_tmp=wavetimeus*34/200;    //���뵥λ//����
        
        switch(waveState)
        {
           case STABLE :
             if( ((distance_tmp - distance_last) <= 80)&&((distance_tmp - distance_last) >= -80) )
              {
                distance = distance_tmp;
                wave_lost_cnt = 0;
               }
             break;
           
            case LOST :
              for(int i = 0;i<4;++i)
              {
                distance_buffer[i] = distance_buffer[i+1];
              }
              distance_buffer[4] = distance_tmp;
              
              distance_sum = 0;
              for(int i = 0;i<5;++i)
              {
                distance_sum += distance_buffer[i];
              }
              distance_ave = distance_sum/5;
              
              distance_diff = 0;
              for(int i = 0;i<5;++i)
              {
                distance_diff += abs(distance_buffer[i]-distance_ave);
              }
              
              if( distance_diff<20 && distance_ave<800) 
              {
                distance = distance_ave;
                distance_last = distance;
                waveState = STABLE;
              }
              
              break;
              
            default:
              break;
        }
        
        distance_last = distance;
    }
  }
}
void DMA0_IRQHandler(){
  DMA0->CINT &= ~DMA_CINT_CINT(7); //Clear DMA0 Interrupt Flag
  
  img_row++; 
}

void Cam_Init(){
  // --- IO ---
  
  PORTC->PCR[8] |= PORT_PCR_MUX(1); //cs
  PORTC->PCR[9] |= PORT_PCR_MUX(1); //vs
  PORTC->PCR[11] |= PORT_PCR_MUX(1);    //oe
  PTC->PDDR &=~(3<<8);
  PTC->PDDR &=~(1<<11);
  PORTC->PCR[8] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(10);	//PULLUP | falling edge
  PORTC->PCR[9] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(9);  // rising edge
  PORTC->PCR[11] |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ;
  
  NVIC_EnableIRQ(PORTC_IRQn);
  NVIC_SetPriority(PORTC_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
  
  // --- AD ---
  
  /*
  SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK;  //ADC1 Clock Enable
  ADC0->CFG1 |= 0
             //|ADC_CFG1_ADLPC_MASK
             | ADC_CFG1_ADICLK(1)
             | ADC_CFG1_MODE(0);     // 8 bits
             //| ADC_CFG1_ADIV(0);
  ADC0->CFG2 |= //ADC_CFG2_ADHSC_MASK |
                ADC_CFG2_MUXSEL_MASK |  // b
                ADC_CFG2_ADACKEN_MASK; 
  
  ADC0->SC1[0]&=~ADC_SC1_AIEN_MASK;//disenble interrupt
  
  ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA
  
  ADC0->SC3 |= ADC_SC3_ADCO_MASK; // continuous
  
  //PORTC->PCR[2]|=PORT_PCR_MUX(0);//adc1-4a
  
  ADC0->SC1[0] |= ADC_SC1_ADCH(4);
  */
  
  SIM->SCGC6 |= SIM_SCGC6_ADC0_MASK; //ADC1 Clock Enable
  ADC0->SC1[0] &= ~ADC_SC1_AIEN_MASK; //ADC1A
  ADC0->SC1[0] = 0x00000000; //Clear
  ADC0->SC1[0] |= ADC_SC1_ADCH(4); //ADC1_5->Input, Single Pin, No interrupt
  ADC0->SC1[1] &= ~ADC_SC1_AIEN_MASK; //ADC1B
  ADC0->SC1[1] |= ADC_SC1_ADCH(4); //ADC1_5b
  ADC0->SC2 &= 0x00000000; //Clear all.
  ADC0->SC2 |= ADC_SC2_DMAEN_MASK; //DMA, SoftWare
  ADC0->SC3 &= (~ADC_SC3_AVGE_MASK&~ADC_SC3_AVGS_MASK); //hardware average disabled
  ADC0->SC3 |= ADC_SC3_ADCO_MASK; //Continuous conversion enable
  ADC0->CFG1|=ADC_CFG1_ADICLK(1)|ADC_CFG1_MODE(0)|ADC_CFG1_ADIV(0);//InputClk, ShortTime, 8bits, Bus
  ADC0->CFG2 |= ADC_CFG2_MUXSEL_MASK; //ADC1  b
  ADC0->CFG2 |= ADC_CFG2_ADACKEN_MASK; //OutputClock
    
  // --- DMA ---
  
  SIM->SCGC6 |= SIM_SCGC6_DMAMUX_MASK; //DMAMUX Clock Enable
  SIM->SCGC7 |= SIM_SCGC7_DMA_MASK; //DMA Clock Enable
  DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_SOURCE(40); //DMA0->No.40 request, ADC0
  DMA0->TCD[0].SADDR = (uint32_t) & (ADC0->R[0]); //Source Address 0x400B_B010h
  DMA0->TCD[0].SOFF = 0; //Source Fixed
  DMA0->TCD[0].ATTR = DMA_ATTR_SSIZE(0) | DMA_ATTR_DSIZE(0); //Source 8 bits, Aim 8 bits
  DMA0->TCD[0].NBYTES_MLNO = DMA_NBYTES_MLNO_NBYTES(1); //one byte each
  DMA0->TCD[0].SLAST = 0; //Last Source fixed
  DMA0->TCD[0].DADDR = (u32)cam_buffer;
  DMA0->TCD[0].DOFF = 1;
  DMA0->TCD[0].CITER_ELINKNO = DMA_CITER_ELINKNO_CITER(IMG_COLS+BLACK_WIDTH);
  DMA0->TCD[0].DLAST_SGA = 0;
  DMA0->TCD[0].BITER_ELINKNO = DMA_BITER_ELINKNO_BITER(IMG_COLS+BLACK_WIDTH);
  DMA0->TCD[0].CSR = 0x00000000; //Clear
  DMA0->TCD[0].CSR |= DMA_CSR_DREQ_MASK; //Auto Clear
  DMA0->TCD[0].CSR |= DMA_CSR_INTMAJOR_MASK; //Enable Major Loop Int
  DMA0->INT |= DMA_INT_INT0_MASK; //Open Interrupt
  //DMA->ERQ&=~DMA_ERQ_ERQ0_MASK;//Clear Disable
  DMAMUX->CHCFG[0] |= DMAMUX_CHCFG_ENBL_MASK; //Enable
  
  NVIC_EnableIRQ(DMA0_IRQn);
  NVIC_SetPriority(DMA0_IRQn, NVIC_EncodePriority(NVIC_GROUP, 1, 2));
}