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

//�궨��======================
#define CAM_WID 128//����ͷ��Ч���//������ͷ����λ���й�//����ֵ128
#define Dir_Kp 6.666//0.666    //����������Ʋ���  8               //6
#define Dir_Kd 26.666  //���΢�ֿ��Ʋ���     //6    12���ú�����
#define thr 85//�ڰ���ֵ��Ŀǰ�����      //70    //������ͷ��Ҫ��
#define ROAD_SIZE 50 //���õ�����ͷ��������
#define WEIGHT_SIZE 10 //ʵ�ʼ�Ȩ�����ƶ��������
//���Ͷ���=======================================
typedef struct {
  int left;
  int right;
  int mid;
  int width;
}Road;//�ɽ���Զ���
//ö������================================

enum road_state {straight, curve, roundabout, obstacle, cross}; // ǰ����·״̬
enum overtake_state {no_overtake, in_overtake};     // ����״̬
enum car_type {leader=1, follower=2}; // ǰ�󳵱�־
enum car_state {stop, test, normal_drive};   // ���ܳ�״̬
enum remote_state {bt_no, bt_prepare, bt_start, bt_finish, bt_forbid, bt_stop, bt_adjust, bt_accelerate};  // ����ͨѶ
enum roundabout_state {round_no, round_prepare, round_enter, round_in, round_exit}; // ����״̬
enum roundabout_choice {round_choice_no, round_left, round_right, round_both}; // �����ڵķ���ѡ��
enum cross_state {no_cross, cross_detect, cross_stop, cross_back, cross_go};//ʮ��״̬
enum cross_turn {cross_no, cross_left, cross_right, cross_close}; // ʮ���ڵķ���ѡ��
enum obstacle_state {obstacle_no, obstacle_pre, obstacle_go};
enum obstacle_type {no_obstacle, obstacle_good, obstacle_bad, obstacle_cross};//�ϰ�����
enum obstacle_pos {obstacle_right, obstacle_left};//�ϰ���λ��
//��������======================================
void Cam_B_Init();//��ʼ��Cam_B
float constrain(float lowerBoundary, float upperBoundary, float input);//���������޵ĺ���
int constrainInt(int lowerBoundary, int upperBoundary, int input);//���������޵ĺ���(integerר��)
bool is_stop_line(int target_line);//�ж��Ƿ�Ϊ��ֹ��/�����
bool is_hole(int row);   //���ڶ�
bool isWider(int row,int road_width_thr);//���·��
//================================================================
//================================================================
//extern ������
//�ر�������������ͬ�Ĳ��֣�========================
extern float weight[6][10];
extern int MAX_SPEED;
extern int MIN_SPEED;
extern int road_B_near;
extern int road_width_near;
extern int road_B_far;
extern int road_width_far;

//ͨ�á�����ʶ��================================
extern Road road_B[ROAD_SIZE];//�ɽ���Զ���
extern float mid_ave;//road�е��Ȩ���ֵ
extern int valid_row;//����Ч����أ����������ٿ�
extern int valid_row_thr;//��Ч����ֵ������ֱ���ʹ����
extern enum car_state car_state;//���ܳ�״̬��־ 0��ֹͣ  1�����Զ��  2������Ѳ��
extern enum road_state road_state;//ǰ����·״̬ 1��ֱ��   2�����  3������  4���ϰ� 5��ʮ��
                  //2 ״̬�¼���//˫��======================================
extern enum car_type car_type;//ǰ�󳵱�־ 1=ǰ�� 2=��
extern bool flag_stop;
extern enum overtake_state overtake_state;//����״̬      0=�޳���     1=���������������ٶȻ��߼��٣�          2=�����������ٻ�ͣ���� 
extern enum remote_state remote_state;//����ͨѶ   
//0=����������ʻ   
//1=�ң�ǰ�������Ա��������㣨�󳵣��յ�����overtake_stateΪ1  
//2=�ң��󳵣���ʼ�������㣨ǰ�����յ�����overtake_stateΪ2      
//3=�ң���)��ɳ������Һ��㣨ǰ�����յ�����overtake_stateΪ0��ͬʱ����ǰ��״̬��ת
//����4=�ң��󳵣������˳�������Ϊ�����Ŀղ����������ۼ����ܡ���just a joke
//����ʱ��������������������ʱ��   ʮ�ֳ���    ��������    ֱ������        //��ʱ����Ҫ�����״̬ͨѶ��

//��������봦��========================================
extern int check_round_farthest;  //˫���ӳ����ڶ�����ʱ����Զ���λ�ã�cam_buffer�±꣬ԽСԽԶ������̫С�����10Ҳ����road_B��Զ����ͺ�
extern int time_cnt;//������ʱ
extern int road_hole_row;//road_B�±� ���ڼ��
extern enum roundabout_state roundabout_state;//0-�ǻ��� 1-Ԥ�뻷����ֱ���� 2-�뻷����ת�� 3-�ڻ��� 4-��������ת��      ע�������ʱ�����������״̬
extern enum roundabout_choice roundabout_choice;//0-δѡ�� 1-�� 2-�� 3-���ҽԿ�(����)      //�����ܹ�ѡ�����·��ʱҪ��ʼ��Ϊ0
extern int cnt_thr;//���յ���Զ��λ�����ƣ�����̫Զ��������̫�󣩷����ڻ�����⵽�Ĳ�׼������̫С�����ⲻ�����߼�⵽��ʱ���Ѿ�����
extern int jump_thr;//�����յ������ֵ
extern int jump[2][2];//��յ����� 0�� 1�� 0-x 1-y
extern bool flag_left_jump,flag_right_jump;
extern double suml,sumr;//Ϊ��ͼ���ĳ�ȫ�ֱ���

//�յ�ʶ��================
extern u8 is_stopline;
extern u8 cnt_zebra;
extern u8 delay_zebra1, delay_zebra2;

//ʮ���䴦��==============

extern int left3;
extern int right3;
extern int flag_cross; //ʮ�ֵ��ж�����
extern int cross_cnt; //ʮ�������
extern int cross_turn; //��ʮ�����Ƿ���ͣ��
extern int cross_times; // �жϳ�ʮ�ֵĴ���
extern int buf_time;    //������������������������
extern int right_time;//����������������������������
extern int left_time;//����������������������������
extern int cross_end; //�ж�ʮ���Ƿ����
extern int flag_wide;
extern int wait_time;

//�ϰ�����==================
extern enum obstacle_type obstacle_type;
extern enum obstacle_state obstacle_state;
extern enum obstacle_pos obstacle_pos;
extern int start_row;
extern int last_row;
extern int obstacle_time_cnt;
//�۲졤�ٿ�========================================================
extern float motor_L;//=MIN_SPEED;
extern float motor_R;//=MIN_SPEED;
extern float max_speed;//=MAX_SPEED;
extern float min_speed;//=MIN_SPEED;

//OLED����
extern PIDInfo debug_dir;
#endif