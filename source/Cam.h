#ifndef CAM_H
#define CAM_H

// ===== Settings =====
// the camera has about 300 rows and 400 cols ,
// but we can not handle that much ,
// so we get 1 row of image for every IMG_STEP rows of camera ,
// and totally get IMG_ROWS rows.

#define IMG_ROWS 64
#define IMG_COLS 128
#define IMG_STEP 2      // TODO: Զ�����

#define CAM_STEP 1 //cam���ݴ�����
#define CAM_FAR 10//��Զ��Ӧcam����
#define CAM_NEAR 60//�����Ӧcam����

#define BLACK_HEIGHT 5
#define BLACK_WIDTH  27

#define PI 3.141593

// ====== Global Variables ======

extern u8 cam_buffer[IMG_ROWS][IMG_COLS+BLACK_WIDTH];


// ===== APIs ======

  // write your algorithm in this func
void Cam_Algorithm();

  // Init
void Cam_Init();

//==============CAM_B===========
#define CAM_WID 134//����ͷ��Ч���//������ͷ����λ���й�//120//132
#define thr 70//�ڰ���ֵ��Ŀǰ�����
#define ROAD_WID 30//��·��ȣ�δ֪����Ҫ��͸�ӱ任��ʹ�á�������������������
extern int MAX_SPEED; //ֱ������ٶ�/////////////////////////26Ϊ���ڵļ���
extern int MIN_SPEED; //�������ٶ�////////////////////////��ȷ��
extern int MAX_SPEED_; 
extern int MIN_SPEED_; 
#define ROAD_SIZE 50 //���õ�����ͷ��������
#define WEIGHT_SIZE 10 //ʵ�ʼ�Ȩ�����ƶ��������
#define MaxWeight_index 7 //���weight���±꣬��Χ��0-9
#define MaxWeight 6.0 //���weightȨֵ
#define exp_k 0.3 //����̬�ֲ���ָ�����һ�����ӣ�ʹ���߱�ƽ
extern float Dir_Kp;
extern float Dir_Kd;
extern int differ;
extern bool stopper;
//#define CAM_HOLE_ROW 15 //����������ɨ����ڶ���������cam_buffer��λ��
extern int CAM_HOLE_ROW; //����������ɨ����ڶ���������cam_buffer��λ��
typedef struct {
  int left;
  int right;
  int mid;
 // double slope_;//slpoe_=dx/dy
}Road;//�ɽ���Զ���
/*typedef struct {
  float r;
  bool sign;
}circle;*/
/*typedef struct{
  int down;
  int up;
  int left;
  int right;
  bool isCircle;
}Hole;//���ڴ洢������໷���ڶ�,���Ǵ󻷵�ʧЧ*/
extern Road road_B[ROAD_SIZE];
extern float mid_ave;//road�е��Ȩ���ֵ
extern float weight[4][10];//road�е�Ȩֵ
extern int valid_row;//��Ч��λ�ã���СΪroad_B[]�±�
extern int valid_row_thr;//��Ч����ֵ
extern u8 car_state;//���ܳ�״̬
extern u8 remote_state;//Զ�̿���
extern u8 road_state;//ǰ����·״̬
extern int lap;
extern float motor_L;
extern float motor_R;

extern float max_speed;
extern float min_speed;

extern PIDInfo debug_dir;
extern int margin;

void Cam_B_Init();//��ʼ��Cam_B
float constrain(float lowerBoundary, float upperBoundary, float input);//���������޵ĺ���
int constrainInt(int lowerBoundary, int upperBoundary, int input);//���������޵ĺ���(integerר��)
//circle getR(float x1, float y1, float x2, float y2, float x3, float y3);//�õ�ǰ������Բ
bool is_stop_line(int target_line);//�ж��Ƿ�Ϊ��ֹ��/�����
double getSlope_(int x1, int y1, int x2, int y2);//�õ�б�ʵĵ���
//������������͸�ӱ任
/*
extern u8 cam_buffer2[64][128];
void getMatrix(double fov, double aspect, double zn, double zf);
void linearization();
void multiply(int k);
void matrixMultiply();
void getNewBuffer();*/
//������������
//�������=========
extern int roundabout_state;//0-�ǻ��� 1-�뻷�����з�֧�� 2-�ڻ��� 3-���������з�֧��
extern int roundabout_choice;//0-δѡ�� 1-�� 2-�� 3-���ҽԿ�


extern int pixinwhite;
extern int frontwhite;
extern int isblackrec;
extern int iswhitefour;
#define CenterLines 12; //����Ļ�����Ļ���һ�������Σ����ų����εı�ȥ����Ƿ�Ϊ�ڵ�
#define CenterRows 15;


extern int cnt_miss; //�ۼ�δ�жϳɻ����Ĵ���
extern bool former_choose_left,former_choose_right;//0=choose 1=not choose
extern bool is_cross; //�ж��Ƿ���ʮ��
extern int jump[2][2];//��յ����� 0�� 1�� 0-x 1-y  //��cambuffer�������Ӧ
extern int jump_thr;
extern bool flag_left_jump,flag_right_jump;
extern bool jump_miss; // ��¼����δ��⵽�յ�Ĵ���
extern int forced_turn;
extern int check_farthest;
extern int check_near;
extern int road_width_thr;
//==============
//test
extern double theta;
extern double x,y;
//Ϊ���cam_buffer������������·����Ե��Ȼ���============
#define DEPTH 5                //������Ϊ5�㻺��
extern int left[DEPTH][ROAD_SIZE];
extern int right[DEPTH][ROAD_SIZE];

//=============================================================
extern int cnt_speed;
extern int cnt_speed2;
//
extern int car_type;
extern int overtake_state;
extern bool bt_stop;
extern int stop_delay;
#endif