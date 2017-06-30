#ifndef WAVE_H
#define WAVE_H

// ===== Global Variables =====
extern int distance;   //  mm
extern U32 wavetimef;
extern U32 wavetime;
extern U32 wavetimeus;
extern int distance_tmp;
extern int distance_last;

// ======= APIs =======
void StartUltrasound(u8 x);  //1������0�ر�

  // Init
void Wave_Init();       //��main��ǰ���ʼ��
typedef enum {
	STABLE,
        LOST
} WaveState;

extern uint8 wave_lost_cnt;
extern WaveState waveState;

#endif