//CAR2�����桪����
#include "includes.h"

// ====== Variables ======
// ---- Global ----
int thr=65;
u8 cam_buffer_safe[BLACK_WIDTH*2];
u8 cam_buffer[IMG_ROWS][IMG_COLS+BLACK_WIDTH];   //64*155���ѺڵĲ�����ȥ��59*128
//�ر�������������ͬ�Ĳ��֣�=================================================
enum car_type car_type=follower;//ǰ�󳵱�־ 1=ǰ�� 2=��
float weight[6][10] ={
{0,0,0,0,0,     0,0,0,0,0},   //0 ͣ��
{1,1,1,1,1,     1,1,1,1,1},// 1 ֱ��
//{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454},
{1.00,1.03,1.14,1.54,2.56,               3.29,4.16,6.00,7.16,5.29},
//{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454},// 2 ���
{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454},// 3 ����
{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454},// 4 �ϰ�
{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454} // 5 ʮ��
//������ѡȨ�أ�
//{1.00,1.03,1.14,1.54,2.56,               4.29,6.16,7.00,6.16,4.29},
//{1.00,1.03,1.14,1.54,2.56,               4.29,6.16,7.00,6.16,4.29},
//{1.00,1.03,1.14,1.54,2.56,               4.29,6.16,7.00,6.16,4.29}
//{1.118, 1.454, 2.296, 3.744, 5.304,      6.000, 5.304, 3.744, 2.296, 1.454}
};//������Ϊֱ���䡢��������·���ֱ����õ�Ȩ�أ������²��ÿ��ǣ����ٿ��ܻ���ϸ΢����
//int MAX_SPEED=21;
//int MIN_SPEED=15;
float chasu=0.038;
float dir_kp = 4.4;
float dir_kd = 32;
int fy_valid_row = 0;
int road_B_near=0;//���ڹ۲�Ͻ�����·���ж��Ƿ���зֵ���road_B�±꣬ԽСԽ������ֵ��road_width_thr����
                  //CAR1��Ӧ·�� 5 -> ֱ��50+ or ���70+ or �뻷����ʮ��110+ or ����������80~100+ 
                  //ĿǰCAR1--10  CAR2--0
int road_width_near=83;//��ֵͨ���۲�check_near��Ӧ�е�����·����ȷ��
int road_B_far=40;
int road_width_far=40;//δȷ��
//�������ĸ����ݿ������ֱ����һ�����봦������·��//��������ʱδʹ�ã��������
int valid_row_thr=37;//��Ч����ֵ������ֱ��S��ʹ����         //������ͷ�Ƕ��й�

//ͨ�á�����ʶ��================================
int kp_reduce=0;//ֱ���볤ֱ������
int cnt=0;
Road road_B[ROAD_SIZE];//�ɽ���Զ���
float mid_ave;//road�е��Ȩ���ֵ
int valid_row=0;//����Ч����أ����������ٿأ�����ֱ��
enum car_state car_state=0;//���ܳ�״̬��־ 0��ֹͣ  1�����Զ��  2������Ѳ��
enum road_state road_state = 1;//ǰ����·״̬ 1��ֱ��   2�����  3������  4���ϰ� 5��ʮ��
                  //2 ״̬�¼���
int state_set=0;//0=δ���� 1=������        �����������ȼ�
//˫��======================================
bool uart_sw=0;
bool flag_stop=0;
bool bt_ok=0;//���ͨѶ�ı�־λ
//bool bt_stop=0;
int bt_delay=10;//��������ͨѶ�ͺ��whileѭ������δ���ԡ���������������������������������������
enum overtake_state overtake_state=0;//����״̬      0=�޳���     1=���������������ٶȻ��߼��٣�          2=�����������ٻ�ͣ���� 
enum remote_state remote_state = 0;//����ͨѶ   
  //0=����������ʻ    
  //1=�ң�ǰ�������Ա��������㣨�󳵣��յ�����overtake_stateΪ1  
  //2=�ң��󳵣���ʼ�������㣨ǰ�����յ�����overtake_stateΪ2      
  //3=�ң���)��ɳ������Һ��㣨ǰ�����յ�����overtake_stateΪ0��ͬʱ����ǰ��״̬��ת
  //����4=�ң��󳵣������˳�������Ϊ�����Ŀղ����������ۼ����ܡ���just a joke
  //����ʱ��������������������ʱ��   ʮ�ֳ���    ��������    ֱ������        //��ʱ����Ҫ�����״̬ͨѶ��

//��������봦��========================================
int check_round_farthest=15;  //˫���ӳ����ڶ�����ʱ����Զ���λ�ã�cam_buffer�±꣬ԽСԽԶ������̫С�����10Ҳ����road_B��Զ����ͺ�
int time_cnt=-1;//������ʱ
int time_cnt1=-1;//������ʱ
int road_hole_row=40;//road_B�±� ���ڼ��
enum roundabout_state roundabout_state=0;//0-�ǻ��� 1-Ԥ�뻷����ֱ���� 2-�뻷����ת�� 3-�ڻ��� 4-��������ת��      ע�������ʱ�����������״̬
enum roundabout_choice roundabout_choice=2;//0-δѡ�� 1-�� 2-�� 3-���ҽԿ�(����)      //�����ܹ�ѡ�����·��ʱҪ��ʼ��Ϊ0
int cnt_thr=40;//���յ���Զ��λ�����ƣ�����̫Զ��������̫�󣩷����ڻ�����⵽�Ĳ�׼������̫С�����ⲻ�����߼�⵽��ʱ���Ѿ�����
int jump_thr=10;//�����յ������ֵ
int jump[2][2];//��յ����� 0�� 1�� 0-x 1-y
bool flag_left_jump=0,flag_right_jump=0;
double suml=0,sumr=0;//Ϊ��ͼ���ĳ�ȫ�ֱ���
bool flag_ignore=0;//Ϊ������stopline������д�ľֲ�����
int ignore_time=0;
//int round_speed=10;//��������
//�յ�ʶ��================
u8 is_stopline = 0;
u8 cnt_zebra = 0;
u8 delay_zebra1 = 0, delay_zebra2 = 0;//1 for the first, should pass; 2 for the second, should stop

//ʮ���䴦��==============
int cross_sw=0;
enum cross_state cross_state=no_cross;
//0=no_cross��ʮ��
//1=cross_detect��⵽ʮ��
//2=cross_stopǰ��ͣ������
//3=cross_backǰ�����֮�󣬵������ؽ�ʮ��
//4=cross_goʮ�ֵ���ֱ������ʻ ����Ҫ����·�磩
int left3;
int right3;
int left6;
int right6;
int flag_cross=0; //ʮ�ֵ��ж�����
int cross_cnt=0; //ʮ�������
int cross_turn=0; //��ʮ�����Ƿ���ͣ��
int cross_times=0; // �жϳ�ʮ�ֵĴ���
int buf_time=-1;
int right_time=-1;
int left_time=-1;
int BUF_TIME=20;
int RIGHT_TIME=30;
int LEFT_TIME=10;
int left_time_min=200;
int cross_end=0; //�ж�ʮ���Ƿ����
int flag_wide=0;
int flag_thin=0;
int wait_time=-1;
int cross_overtake_cnt=0;
int cross_valid_row=37;    //��crpss_go��ȡ��Щ����������·�߽�      //����δ����������������������

//�ϰ�����==================
enum obstacle_type obstacle_type=no_obstacle;     //�ϰ�������
enum obstacle_pos obstacle_pos=obstacle_right;          //�ϰ���λ��
enum obstacle_state obstacle_state;
int start_row=0; // �ϰ���ʼ������
int last_row;
int obstacle_time_cnt=0;
int obstacle_valid_row=37;

//�۲졤�ٿ�========================================================
float motor_L;//=MIN_SPEED;
float motor_R;//=MIN_SPEED;
float max_speed;//=MAX_SPEED;
float min_speed;//=MIN_SPEED;

//OLED����
PIDInfo debug_dir;

// ---- Local ----
u8 cam_row = 0, img_row = 0;

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
}

// --------By FeiYang
int changdu()
{
  int i;
  for (i=60;i>=0;i--)
  {if (cam_buffer[i][CAM_WID/2]<thr) break;}
  return i;
}


//�������򻯰�Ѳ�߳���
void Cam_B(){
  
    //===================��������====================
    chasu = CHASU/1000;
    dir_kp = DIR_KP/10;
    dir_kd = DIR_KD;
    /*
    MAX_SPEED = 21;
    MIN_SPEED = 15;
    round_speed = 10;
    CHASU = 38;
    DIR_KP = 44;
    DIR_KD = 32;
    */
    static int dir;//������
    

    //���¶��ϡ�ʶ���·============================================================
    for(int j=0;j<ROAD_SIZE;j++)//��������ɨ��
    {
      int i;
      //left
      for (i = road_B[j].mid; i > 0; i--){
        if (cam_buffer[60-CAM_STEP*j][i] < thr)
          break;
        }
      road_B[j].left = i;
      
      //right
      for (i = road_B[j].mid; i < CAM_WID; i++){
        if (cam_buffer[60-CAM_STEP*j][i] < thr)
          break;
        }
      road_B[j].right = i;
      //width
      road_B[j].width=road_B[j].right-road_B[j].left;
      //mid
      road_B[j].mid = (road_B[j].left + road_B[j].right)/2;//�ֱ���㲢�洢����ROAD_SIZE��(��Ӧcam_buffer��12~60��)��mid
      //store
      if(j<(ROAD_SIZE-1))
        road_B[j+1].mid=road_B[j].mid;//��һ�д�ǰһ���е㿪ʼɨ��
    }
    
    // By FeiYang
    fy_valid_row = changdu();

    //���ű��ࡤ��·����===========================
    //���ȼ���ͣ���� ���� ʮ�� ��� ֱ��
    //����ʮ�ֿ�������
    //�ж�ͣ����-----------------------------------------------------//���հ汾��
    if(is_stopline == 0 && is_stop_line(50) == 1)
    {
      is_stopline++;
      flag_ignore=1;
      delay_zebra1 = 10;
    }
    else if(is_stopline == 1 && delay_zebra1 == 0 && is_stop_line(45) == 1)
    {
      is_stopline++;
      flag_ignore=1;
      delay_zebra2 = 5;
    }
 /*   else if(is_stopline == 2 && delay_zebra1 == 0 && is_stop_line(50) == 1)
    {
      is_stopline++;
      flag_ignore=1;
      delay_zebra2 = 5;
    }*/
    else if(is_stopline == 2 && delay_zebra2 == 0){
      is_stopline++;//��ʱ�յ�ͣ��
      
      //�������ͨѶ����
      if(car_type==leader && bt_ok==0){
        UART_SendChar('c');
      }
      flag_ignore=1;
    }
    //ignore_time�����Ϊ�ж�ʱ��
    /*if(flag_ignore==1 && ignore_time<2000)      //���ʱ�������ڳ��٣�����ϣ������㡱�뻷����Ҫ����̫�������������Ļ���Ҳ�ᱻ���ε�
      ignore_time++;
    else {
      flag_ignore=0;
      ignore_time=0;
    }*/
    
    // �ж��ϰ� ����������������������������������������//δ����
    if(state_set==0){
      int obstacle_set=0;
      for(int i_valid=5;i_valid<(30-5);i_valid++) {
        if ((((road_B[i_valid+5].left-road_B[i_valid].left) >= -5 && (road_B[i_valid+5].left-road_B[i_valid].left) < 10) ||  
             ((road_B[i_valid+6].left-road_B[i_valid].left) >= -5 && (road_B[i_valid+6].left-road_B[i_valid].left) < 10) ||
               ((road_B[i_valid+7].left-road_B[i_valid].left) >= -5 && (road_B[i_valid+7].left-road_B[i_valid].left) < 10))
            && (road_B[i_valid].right-road_B[i_valid+1].right) > 15 && (road_B[i_valid].right-road_B[i_valid+2].right) > 15 && (road_B[i_valid].right-road_B[i_valid+3].right) > 15){
          //road_state=4;
          obstacle_set=1;
          obstacle_pos = obstacle_right;
          start_row = i_valid;
          //break;
        }
        
        if ((((road_B[i_valid].right-road_B[i_valid+5].right) >= -5 && (road_B[i_valid].right-road_B[i_valid+5].right)<10) || 
              ((road_B[i_valid].right-road_B[i_valid+6].right) >= -5 && (road_B[i_valid].right-road_B[i_valid+6].right)<10) || 
               ((road_B[i_valid].right-road_B[i_valid+7].right) >= -5 && (road_B[i_valid].right-road_B[i_valid+7].right)<10))
            && (road_B[i_valid+1].left-road_B[i_valid].left) > 15 && (road_B[i_valid+2].left-road_B[i_valid].left) > 15 && (road_B[i_valid+3].left-road_B[i_valid].left) > 15){
          //road_state=4;
          obstacle_set=1;
          obstacle_pos = obstacle_left;
          start_row = i_valid;
          //break;
        }
        
        if (road_B[i_valid].right > 125 && road_B[i_valid].left<5) obstacle_set=0;
      }
      
   //   if (obstacle_set==1) road_state=4;

      /*
      for(int i_valid=5;i_valid<(30-5);i_valid++) {
        if ((road_B[i_valid+5].left-road_B[i_valid].left) >= -5 && (road_B[i_valid+5].left-road_B[i_valid].left) < 10 && (road_B[i_valid].right-road_B[i_valid+1].right) > 15){
          road_state=4;
          obstacle_pos = obstacle_right;
          start_row = i_valid;
          break;
        }
        
        if ((road_B[i_valid].right-road_B[i_valid+5].right) >= -5 && (road_B[i_valid].right-road_B[i_valid+5].right)<10 && (road_B[i_valid+1].left-road_B[i_valid].left) > 15){
          road_state=4;
          obstacle_pos = obstacle_left;
          start_row = i_valid;
          break;
        }   
      }
      */
      
      last_row=-1;
      float obstacle_diff=0;
      int obstacle_mid = 0;
      int bad_flag = 0;
      //�ж���ɣ�����Ԥ����
      if (road_state==4){
        for(int i=start_row+6;i<(ROAD_SIZE-1);i++){
          if (last_row==-1){
          if (abs(road_B[i].width-road_B[i+5].width)>10){
            last_row=i;
            break;
          }
          }
        }
        
        obstacle_diff = (road_B[last_row].mid-road_B[start_row].mid)/((float)last_row-(float)start_row);
        obstacle_mid = road_B[start_row].mid;
        
        for (int i = start_row; i <=last_row; i++){
          if (obstacle_pos == obstacle_right){
            if (road_B[i].right<=obstacle_mid){
                obstacle_type=obstacle_bad;
                bad_flag = 1;
            }
          }
          else{
            if (road_B[i].left>=obstacle_mid){
              obstacle_type=obstacle_bad;
              bad_flag = 1;
            }
          }
          obstacle_mid += obstacle_diff;
        }
        
        if (bad_flag==0) obstacle_type=obstacle_good;
        
        //����Car_type���벻ͬ��Case
          if(car_type==follower){   //��  ���ϸ��ӣ�
            if(overtake_state==in_overtake){
              if(obstacle_type==obstacle_good || obstacle_type==obstacle_cross){
                //�������ϳ���
                obstacle_state=obstacle_go;
              }
              else if(obstacle_type==obstacle_bad){
                //�ȵ����ٱ��ϳ���        //����
                obstacle_state=obstacle_pre;
              }
              else{
                flag_stop=1;//��Ӧ�ó������else,��ʱд�����������
              }
            }
            else if(overtake_state==no_overtake){
              //state_set=0;//�������У�˵��ǰ��̫����ͨѶ��
              UART_SendChar('f');//����������������������������������������//ϣ����Ҫ���������е����У���Ȼ������
              obstacle_state=obstacle_go;//�������������߱���
            }
          }
          else if(car_type==leader){                   //ǰ��
            //���ϳ���ȥ
            obstacle_state=obstacle_go;
          }
          
          if(obstacle_state==obstacle_go){
            obstacle_time_cnt=50;              //���Ρ�������������������������������������������
          }
          
      }
    }
    //ʼ�ռ��յ�====================
    int cnt=0;
      flag_left_jump=0,flag_right_jump=0;
      for(cnt=0;cnt<cnt_thr;cnt++){     //��road_B[0]~[39]֮����jump
        if(flag_left_jump==0){
          if((road_B[cnt].left-road_B[cnt+5].left)>jump_thr && road_B[cnt].width!=0){
            flag_left_jump=1;
            suml=road_B[cnt].left-road_B[0].left;
            jump[0][0]=road_B[cnt].left;
            jump[0][1]=60-CAM_STEP*cnt;
          }
        }
        
        if(flag_right_jump==0){
          if((road_B[cnt+5].right-road_B[cnt].right)>jump_thr && road_B[cnt].width!=0){
            flag_right_jump=1;
            sumr=road_B[cnt].right-road_B[0].right;
            jump[1][0]=road_B[cnt].right;
            jump[1][1]=60-CAM_STEP*cnt;
          } 
        }       
       if(flag_left_jump==1&&flag_right_jump==1)//��⵽�����յ�       
         break;
      }
    //���ֻ�����ʮ�ֵ��ӳ��߷�����������������������������������������
    if(state_set==0 && flag_ignore==0){     //��û�м�⵽�������Ҳ���ʮ�֡��յ�״̬�£�����йյ㣨jump����⣬���£�//̫��ϸ�ļ��㲻�ʺϣ����Ըĳ�һ���򵥵�
      
      if(flag_left_jump==1&&flag_right_jump==1 && road_B[60-jump[0][1]+1].width>5 && road_B[60-jump[1][1]+1].width>5){//����⵽�����յ㣬���ж��ǻ�������ʮ�֣����£�(ͬʱҪ�������յ㲻��̫Զ������û��)
        //������suml �� sumr / cnt*CAM_STEP
        int cnt_black_row=0;//��¼���и���
        int left_now,right_now;//�浱ǰ��ɨ��߽�
        for(int j=cnt;(60-CAM_STEP*j)>check_round_farthest;j++){//��Զ����check_farthest�ѵ��Ρ�������������������������������������������
          left_now=jump[0][0]+suml*(j-cnt)/(cnt*CAM_STEP);
          right_now=jump[1][0]+sumr*(j-cnt)/(cnt*CAM_STEP);
          int cnt_black=0;
          for (int i = left_now; i < right_now; i++){
            if (cam_buffer[60-CAM_STEP*j][i] < thr)
              cnt_black++;
          }
          if(cnt_black>(right_now-left_now)*0.8) cnt_black_row++;//����������һ��
          if(cnt_black_row>=1){         //������
            road_hole_row=60-j;
            if(is_hole(road_hole_row) || is_hole(road_hole_row-3) || is_hole(road_hole_row+3)){
           // if(road_B[road_B_near].width<80){
              road_state=3;                       //��ɻ����ж�
              roundabout_state=1;
              state_set=1;
              time_cnt=0;
              if(car_type==leader) bt_ok=0;
            }
            break;
          }
        }
      }
    }
    
    //Ѱ��ʮ�֡�����������������������������������������������
    
    if(state_set==0 && car_type==leader){
      flag_wide=0;
      flag_thin=0;
      for(int i_valid=5;i_valid<(40-3) && flag_cross==0;i_valid++)     //Ѱ��ʮ����
      {
        left3 = (road_B[i_valid].left+road_B[i_valid+1].left+road_B[i_valid+2].left)/3;
        right3 = (road_B[i_valid].right+road_B[i_valid+1].right+road_B[i_valid+2].right)/3;
     
        // else valid_row=ROAD_SIZE-3;
        if ((right3-left3) > 125){
          flag_wide=1;
        }
      
        if (flag_wide==1){
          left6 = (road_B[i_valid+3].left+road_B[i_valid+4].left+road_B[i_valid+5].left)/3;
          right6 = (road_B[i_valid+3].right+road_B[i_valid+4].right+road_B[i_valid+5].right)/3;
          if ((left6-left3)>15 && (right3-right6)>15){
            flag_thin=1;
          }
        }
      
      }

      if (flag_wide==1 && flag_thin==1){
         state_set=1;
         road_state=5;
         cross_state=cross_detect;
         cross_cnt=0;
         if(car_type==leader) bt_ok=0;
      }
      //�ҵ���
      
      
    }
    
    //�������ֱ��-----------------------------
    if(state_set==0){
      //static int mid_ave3;
      bool flag_valid_row=0;
      for(int i_valid=0;i_valid<(ROAD_SIZE-3) && flag_valid_row==0;i_valid++)     //Ѱ����Ч��
      {
        //�����ģ�����cam_buffer�м��Ƿ�Ϊ��
        if(cam_buffer[60-i_valid*CAM_STEP][CAM_WID/2]<thr){        //�����
          flag_valid_row=1;
          valid_row=i_valid;
          break;
        }
      }
      if(flag_valid_row==0) valid_row=ROAD_SIZE-3;
      if(valid_row<valid_row_thr){
        road_state=2;                     //���
      }
      else {
        road_state=1;                     //ֱ��
      }
    }
    
    //=============================����ǰ����·���ͣ����в�ͬ�Ĵ���
     switch(road_state)
    {
      case 1:   //ֱ�� or ����ֱ��ͨ����S��
        kp_reduce=0.1;
        max_speed=MAX_SPEED;
        min_speed=MIN_SPEED;
        //ѡ��߽�����ֵ���ұ߽�����ֵȷ���µ��е�
        /*
        int left_max=0,right_min=CAM_WID;
        for(int i=0;i<22;i++){
          if(road_B[i].left>left_max) left_max=road_B[i].left;
          if(road_B[i].right<right_min) right_min=road_B[i].right;
        }
        for(int i=1;i<22;i++){
          road_B[i].left=left_max;
          road_B[i].right=right_min;
          road_B[i].mid=(left_max+right_min)/2;
        }
        */
        break;
      case 2:   //�����
        kp_reduce=-0.1;
       // max_speed=constrain(MIN_SPEED+1,MAX_SPEED, MAX_SPEED-1);//������δ����ȡ�����������ٶ�
        max_speed=MAX_SPEED;
        min_speed=MIN_SPEED;
        break;
      
      case 3:   //����
        kp_reduce=-0.1;
        min_speed=max_speed=round_speed;

        switch(roundabout_state)
        {
        case 0://�ǻ������������㣬ò������
          roundabout_state=0;//0-�ǻ��� 1-�뻷�����з�֧�� 2-�ڻ��� 3-���������з�֧��
          time_cnt=0;
          flag_stop=0;
          state_set=0;
          break;
          
        case 1://��⵽����
          roundabout_choice=3-car_type;
          max_speed=min_speed;
          for(int i=1;i<25;i++) road_B[i].mid=CAM_WID/2;
          if(road_B[0].width>=125){     //��ʵ��ȫ����
            roundabout_state=2;
            time_cnt=0; 
          }
          break;  
          
        case 2://�뻷��
          for(int i=1;i<25;i++){   //����roundabout_choice��mid��ƫ����
            if(roundabout_choice==1) road_B[i].mid = constrain(0,CAM_WID/2-60,road_B[i].mid-60);
            else if(roundabout_choice==2) road_B[i].mid = constrain(CAM_WID/2+60,CAM_WID,road_B[i].mid+60);
          }
          if(road_B[0].width<120){ //���·��ָ���������Ϊ����뵺//�Ҳ²��������ʱ����Ʒ�ʽ��Ч
            roundabout_state=3;
            time_cnt=0;
          }
          break;
          
        case 3://�ڻ����ڣ����������������������ʻ
          if(car_type==leader && uart_sw==1){
             //��ͨѶ��
            if(bt_ok==0)
              UART_SendChar('a'); //���ߺ�����Գ�����
            //ͣ����
             if (time_cnt1==-1){
              time_cnt1=2;
              flag_stop=0;
            }
            if (time_cnt1==0 && time_cnt==-1){
              time_cnt=200;
            }
            if (time_cnt>0 && time_cnt1==0){
              flag_stop=1;
            }
            if (time_cnt1==0 && time_cnt==0){
              flag_stop=0;
              roundabout_state=4;
            }
          }
          else if(car_type==follower || uart_sw==0){
            //ֻ�к󳵲�����ʻ
            flag_stop=0;
            bt_ok=0;
            //3�س���ʶ������
            if(isWider(road_B_near,120)){
              roundabout_state=4;
              time_cnt=0;
            }
            if(roundabout_choice==1)
              if(road_B[45].left<5){
                roundabout_state=4;
                time_cnt=0;
              }
            else if(roundabout_choice==2)
              if(road_B[45].right>123){
                roundabout_state=4;
                time_cnt=0;
              }
            if(road_B[0].width>85 && road_B[0].width<95        //90
               && road_B[15].width>70 && road_B[15].width<75    //75
                 && road_B[30].width>55 && road_B[30].width<65){        //60
                   roundabout_state=4;
                   time_cnt=0;
                 }
          }
         // if(time_cnt>10000) roundabout_state=0;//Լ5s  �󻷵�����ȥ������
          //���Ͻ���������������ò�Ҫ����������
          //���δ��⵽��ʱ���ֳ���˵���Ѿ����������������������������������̫�̿��ܻ���˶������˻�������״̬����������������������������
            //�ݲ����������������Ϊ�󻷵���С������ʱ��ͬ������һ�Ŷ��ۣ������ѷ����Ǽ�ⴿֱ������Ϊ������־��
          break;
          
        case 4://����������һ�ηֵ�
           //��ͨѶ��
              //ͣ������
          //��ͨѶ��
          if(car_type==follower && bt_ok==0)
            UART_SendChar('b');   //����ǰ�����ҳ�������
          //ͣ�����ԣ�����
       /*   if (time_cnt1==-1){
            time_cnt1=10;
            flag_stop=0;
          }
          if (time_cnt1==0 && time_cnt==-1){
            time_cnt=50;
          }
          if (time_cnt>0 && time_cnt1==0){
            flag_stop=1;
          }
          if (time_cnt1==0 && time_cnt==0){
            flag_stop=0;
          }
          */
          for(int i=1;i<ROAD_SIZE;i+=(ROAD_SIZE/10)){   //����roundabout_choice��mid��ƫ����//��forced_turn����ͬ��
            if(roundabout_choice==1) road_B[i].mid = constrain(0,CAM_WID/2,road_B[i].mid-10);
            else if(roundabout_choice==2) road_B[i].mid = constrain(CAM_WID/2,CAM_WID,road_B[i].mid+10);
          }
          if(!isWider(road_B_near,100)){// &&  time_cnt1==0 && time_cnt==0){ //���·��ظ��������Ҳ�����ɣ���Ϊ������
            road_state=2;
            roundabout_state=0;
            state_set=0;
            time_cnt=-1;
            time_cnt1=-1;
            flag_stop=0;
            bt_ok=0;
          }
        //  else if(time_cnt>10000) roundabout_state=0;   //2s δ��⵽·��ָ���������Ϊ����
          break;
          
        default:break;
        }
        break;
        
      case 4://�ϰ�
        kp_reduce=0;
        max_speed=MAX_SPEED;
        min_speed=MIN_SPEED;
        switch(obstacle_state){
        case obstacle_pre:
          //uart
          UART_SendChar('e');
          //state_set=0;
          obstacle_state=obstacle_go;
          obstacle_time_cnt=50;
          break;
          
        case obstacle_go:
        	if(obstacle_type==obstacle_cross){
	        	int left_max=0,right_min=CAM_WID;
	          for(int i=0;i<30;i++){
	            if(road_B[i].left>left_max) left_max=road_B[i].left;
	           if(road_B[i].right<right_min) right_min=road_B[i].right;
	          }
	          for(int i=1;i<30;i++){
	            road_B[i].left=left_max;
	            road_B[i].right=right_min;
	            road_B[i].mid=(left_max+right_min)/2;
	          }
	          
	          if(overtake_state==no_overtake){
	            state_set=0;
	            obstacle_state=obstacle_no;
	            obstacle_type=no_obstacle;
	          }
        	}
        	else {
        		  int left_max=0;
		          int right_min=CAM_WID;
		          for(int i=0;i<obstacle_valid_row;i++){
		            if(road_B[i].left>left_max) left_max=road_B[i].left;
		            if(road_B[i].right<right_min) right_min=road_B[i].right;
		          }
		          for(int i=0;i<obstacle_valid_row;i++){
		            //road_B[i].left=left_max;
		            //road_B[i].right=right_min;
		            road_B[i].mid=(left_max+right_min)/2;
		            //��ǿƫ��
		            if(road_B[i].mid>CAM_WID*0.7) road_B[i].mid=(road_B[i].mid+road_B[i].right)/2;                      //���Σ�0.7 0.3
		            else if(road_B[i].mid<CAM_WID*0.3) road_B[i].mid=(road_B[i].mid+road_B[i].left)/2;
		          }
		          //��ʱ
		          if(obstacle_time_cnt==0){
		            state_set=0;
		            obstacle_type=no_obstacle;
		            obstacle_state=obstacle_no;
		          }
        	}
          break;
        default:break;
        break;
        }
        break;
        
      case 5://ʮ��
        max_speed=MAX_SPEED;
        min_speed=MIN_SPEED;
       /* if(car_type==leader && bt_ok==0 && cross_overtake_cnt==0)
            UART_SendChar('a');//���ߺ󳵿��Գ���
        
        switch(cross_state){
        case no_cross://�޴���
          break;
          
        case cross_detect:
          cross_cnt++;
          if(car_type==leader && overtake_state==in_overtake){
            cross_cnt=0;
            cross_state=cross_stop;
            buf_time=20;
          }
          else if(car_type==follower){                          //��״̬���߷ǳ�����ͨѶδ��ɣ�״̬��תΪ��Խʮ��״̬
            cross_cnt=0;
            cross_state=cross_go;
          }
          else if(car_type==leader && cross_cnt>bt_delay){
            cross_cnt=0;
            cross_state=cross_go;
            for(int i=0;i<10;i++){
              UART_SendChar('h');
            }
         }
          break;
          
        case cross_stop:        //��ʱ�ض���ǰ��״̬
          if(buf_time>0){
            cross_turn=3;
            flag_stop=1;
          }
          else if(buf_time==0 && right_time==-1)
            right_time=30;
          else if (right_time>0){
            cross_turn = 2;
            flag_stop=0;
          }
          else if (buf_time==0 && right_time==0 && overtake_state==in_overtake){       
            cross_turn=3;
            flag_stop=1;
          }
          if(overtake_state==no_overtake){      //��ɳ�����ǰ�����    //�仯����д�ڳ�����ͨѶ��
            cross_state=cross_back;
            left_time=50;
          }
          break;
          
        case cross_back:        //��ʱ�ض��Ǻ�״̬������
          if (left_time>=0 || (flag_left_jump==1 && flag_right_jump==1)){
            flag_stop=0;
            cross_turn=1;
          }
          else{
            cross_state=cross_go;
            cross_turn=0;
            flag_stop=0;
          }
          break;
          case cross_go:
          //�����ڴ�
          
             //��Ҫ���Ǳ��ϡ���ȫ·��
          
          //������ɣ�
          //ת��270����road_B[0].width<128?�󣬳�cross_state//��������Ҫ�ģ���������������������
          if(1){
            state_set=0;
            cross_state=no_cross;
            bt_ok=0;
          }
          break;
        default:break;
        }*/
      
        //�����������ʱ��
        state_set=0;
        cross_state=no_cross;
        bt_ok=0;
        //����
      /*  state_set=1;
        //cross_state=no_cross;
        bt_ok=0;
        */
        break;
      default:break;
    }
    
    //================================��ʮ��mid��Ȩ��
    float weight_sum=0;
    int step=2;
    for(int j=0;j<10;j++)
    {
      mid_ave += road_B[j*step].mid * weight[road_state][j];
      weight_sum += weight[road_state][j];
    }
    mid_ave/=weight_sum;
    
    //=================================�����PD����
    static float err;
    static float last_err;
    err = mid_ave  - CAM_WID / 2;
  /*  if(err>0)
      dir = (Dir_Kp+debug_dir.kp) * err*err + (Dir_Kd+debug_dir.kd) * (err-last_err);     //���ת��  //����: (7,3)->(8,3.5)-(3.5,3)
    else
      dir = -(Dir_Kp+debug_dir.kp) * err*err + (Dir_Kd+debug_dir.kd) * (err-last_err); 
    */
    dir = (dir_kp-kp_reduce) * err + (dir_kd) * (err-last_err);
  //  if(dir>0)
   //   dir*=1.2;//����������Ҳ��ԳƵ�����
    last_err = err;
    
    
    //�����ߣ�
    if(is_stopline > 0 && (delay_zebra1 > 0 || delay_zebra2 > 0))
      dir = 0;
    //ʮ�֣�
    if(road_state==5){
      //����
      if (cross_turn==2){
        dir= 145;
      }
      else if (cross_turn == 3){
        dir=0;
      }
      else if (cross_turn == 1){
        dir = 75;
      }
    }
    
    if(is_stopline > 0 && (delay_zebra1 > 0 || delay_zebra2 > 0))
      dir = 0;
    
    
    //���������ֶ�ͣ����
    if(car_state!=0){
      dir=constrainInt(-240,240,dir);   //done! //215 200
      Servo_Output(dir);
    }
    else   
      Servo_Output(0);
    
    //==============�ٶȿ���=================
    //PWM��dirΪ�ο���ǰ�ڷּ���������ٶȣ����ڷֶ����Կ��٣������ҵ����ʲ�����ʱ���ٽ�����ϡ���PWM����dir�ĺ���
    //min_speed=MIN_SPEED;
    //max_speed=MAX_SPEED;
    float range=constrain(0,50,max_speed-min_speed);//�ٶȷ�Χ��С 
    if(car_state==2 ){
      //����
    /*  if(valid_row>45 ){//&& valid_row>valid_row_thr
        motor_L=motor_R=max_speed;
      }
      else{
        motor_L=motor_R=max_speed-range*(45-valid_row)/45;
        double x=dir/240;
        if(x>0) motor_R=constrain(0,motor_R,0.8*motor_R*(1-0.3*x-0.2*x*x));//��ת     //0.3x+0.2x^2  x=dir/200
        else motor_L=constrain(0,motor_L,0.8*motor_L*(1+0.3*x+0.2*x*x));
      }//���ϵĲ��ٿ��Ʋ���δȷ��������ʱ�Գ����ȶ���ʻΪĿ��
      */
      if(fy_valid_row<30)
        motor_L=motor_R=max_speed;
      else{
        motor_L=min_speed*(1+chasu*dir/70);
        motor_R=min_speed*(1-chasu*dir/70);
      }
      //����
      if(is_stopline == 3)
        PWM(0, 0, &L, &R);
      else {
        if (distance <= 400 && bt_stop == 0 && overtake_state == no_overtake && waveState == STABLE){
           motor_L *= 0.7;
           motor_R *= 0.7;
        }
        if (bt_stop == 1 && road_state==1 && waveState == STABLE && distance>=600){
           motor_L *= 1.2;
           motor_R *= 1.2;
        }
        PWM(motor_L, motor_R, &L, &R);               //�����ٶ�
      }
    }
   else if(flag_stop==1)
     PWM(0,0,&L,&R);
   else
   {
      MotorL_Output(0); 
      MotorR_Output(0);
   }
    
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


bool is_stop_line(int target_line)//�յ�ʶ��
{
  cnt_zebra = 0;
  for(int i = 0; i < CAM_WID-5; i++)
  {
    if(cam_buffer[target_line][i] > thr
     &&cam_buffer[target_line][i+1] > thr
     &&cam_buffer[target_line][i+2] < thr
     /*&&cam_buffer[target_line][i+3] < thr*/)
      cnt_zebra++;
  }
  if(cnt_zebra > 5)
    return 1;
  else return 0;
}


bool is_hole(int row)   //���ڶ�
{
  int left=0,right=0;//��¼�����������
    if(cam_buffer[row][CAM_WID/2]<thr)
    {
      //left
      int i=CAM_WID/2-1;
      while(i>0){
        if(left==0 && cam_buffer[row][i]>thr){
          left++;
        }
        else if(left==1 && cam_buffer[row][i]<thr){
          left++;
        }
        else if(left==2) break;
        i--;
      }
      //right
      i=CAM_WID/2+1;
      while(i<CAM_WID){
        if(right==0 && cam_buffer[row][i]>thr){
          right++;
        }
        else if(right==1 && cam_buffer[row][i]<thr){
          right++;
        }
        else if(right==2) break;
        i++;
      }
    }
   // bool static hole=0;
    if(left>=1 && right>=1)     //�������ٸ�����һ�κ�->�׵�����
      return 1;
    else return 0;
        
}

bool isWider(int row,int road_width_thr)
{
  int wid=0;
  for(int i=-1;i<2;i++)
    wid+=(road_B[row+i].right-road_B[row+i].left);
  wid /= 3;
  if(wid>road_width_thr)
    return 1;
  else return 0;
  
}


// ��cam������====== 
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