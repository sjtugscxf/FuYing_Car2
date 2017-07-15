#ifndef FLASH_H
#define FLASH_H

#include "typedef.h"
#define ADDR 0x0003C000
#define SECTOR_SIZE 0x200

#define DATA_NUM 16

extern U16 data[DATA_NUM];

#define data_flag                   data[0]
#define MAX_SPEED_                   data[1]
#define MIN_SPEED_                    data[2]
#define ROUND_SPEED                   data[3]
#define CHASU                   data[4]
#define DIR_KP                   data[5]
#define DIR_KD                  data[6]
#define OVERTAKE_SW                   data[7]
#define STOP_TIME                     data[8]
#define ROUND_CHOICE                     data[9]
#define PWM_DZL                     data[10]
#define PWM_DZR                     data[11]
#define wheel_P                         data[12]
#define wheel_I                         data[13]
#define wheel_D                         data[14]
#define I_speed                     data[15]
//---------------------------
void Flash_Data_Reset(void);
void Flash_Data_Update(void);

void Flash_Init(void);
U8 Flash_Erase(U16);
U8 Flash_Program(U16, U16 WriteCounter, U16 *DataSource);
void Flash_Write(U16 sector);
U16 Flash_Read(U16,U16 data_num);
static U8 FlashCMD(void);


//Flash����궨��
#define RD1BLK    0x00   // ������Flash
#define RD1SEC    0x01   // ����������
#define PGMCHK    0x02   // д����
#define RDRSRC    0x03   // ��Ŀ������
#define PGM4      0x06   // д�볤��
#define ERSBLK    0x08   // ��������Flash
#define ERSSCR    0x09   // ����Flash����
#define PGMSEC    0x0B   // д������
#define RD1ALL    0x40   // �����еĿ�
#define RDONCE    0x41   // ֻ��һ��
#define PGMONCE   0x43   // ֻдһ��
#define ERSALL    0x44   // �������п�
#define VFYKEY    0x45   // ��֤���ŷ���Կ��
#define PGMPART   0x80   // д�����
#define SETRAM    0x81   // �趨FlexRAM����


#endif
