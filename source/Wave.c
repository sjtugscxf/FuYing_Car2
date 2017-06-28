#include "includes.h"

// ===== Variables ======
//---- GLOBAL ----

U32 wavetimef;
U32 wavetime;
U32 wavetimeus;
U32 distance;
U32 distance_tmp;
U32 distance_last;

void StartUltrasound(u8 x){
  if(x)
    PTB->PSOR |= 1<<21;
  else
    PTB->PCOR |= 1<<21;
}

void Wave_Init()
{
  PORTB->PCR[20] |= PORT_PCR_MUX(1) |PORT_PCR_PE_MASK | PORT_PCR_PS_MASK | PORT_PCR_IRQC(11);    // CCD2SI接口用作输入，超声波接收
  PORTB->PCR[21] |= PORT_PCR_MUX(1);    // CCD1SI接口用作输出，超声波发送
  PTB->PDDR |= (0x1<<21);
  NVIC_EnableIRQ(PORTB_IRQn);
  NVIC_SetPriority(PORTB_IRQn, NVIC_EncodePriority(NVIC_GROUP, 2, 1)); //PORTC中断服务程序在cam.c中
}


