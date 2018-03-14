/*** PWM and Motors Functios ***/
#include "constants.h"

void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
     if(channel == 1)
         CCPR1L = duty;
     if(channel == 2)
         CCPR2L = duty;
}
void pwm_steering(unsigned int channel,unsigned int port){
     if(channel == 1){
       PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
       PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
       if(port == 1){
         P1B = 0;         //port pin stays at low
         PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
       }
       if(port == 2){
         P1A = 0;         //port pin stays at low
         PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
       }
     }//channel1 if
     if(channel == 2){
       PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
       PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
       if(port == 1){
         P2B = 0;         //port pin stays at low
         PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
       }
       if(port == 2){
         P2A = 0;         //port pin stays at low
         PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
       }
     }//channel2 if

}

// funcao para mapear o sinal recebido para pwm
long map(long x, long in_min, long in_max, long out_min, long out_max)
{
  return (((x - in_min) * (out_max - out_min)) / (in_max - in_min)) + out_min;
}

void rotateMotors(unsigned int pulseWidth1,unsigned int pulseWidth2){
    int duty_cycle1;
    int duty_cycle2;

    // Tratamento de erro, para nao exceder os valores maximos;
    if(pulseWidth1 < MIN_CH_DURATION)
       pulseWidth1 = MIN_CH_DURATION;
    if(pulseWidth1 > MAX_CH_DURATION)
       pulseWidth1 = MAX_CH_DURATION;

    if(pulseWidth2 < MIN_CH_DURATION)
       pulseWidth2 = MIN_CH_DURATION;
    if(pulseWidth2 > MAX_CH_DURATION)
       pulseWidth2 = MAX_CH_DURATION;

    //implementa uma zona morta, para evitar variações no valor de referência
    if((pulseWidth1 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth1 > (MEAN_CH_DURATION - DEADZONE)))
       pulseWidth1 = MEAN_CH_DURATION;

    if((pulseWidth2 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth2 > (MEAN_CH_DURATION - DEADZONE)))
       pulseWidth2 = MEAN_CH_DURATION;

    //Mapear 1100us a 1900ms em -100% a 100% de rotacao
    duty_cycle1 = map(pulseWidth1,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
    duty_cycle2 = map(pulseWidth2,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);

    if(duty_cycle1 >= 0){
      pwm_steering(1,2);                        //coloca no sentido anti horario de rotacao
      set_duty_cycle(1,duty_cycle1);                     //aplica o duty cycle
    }
    else{
      duty_cycle1 = -duty_cycle1;
      pwm_steering(1,1);                       //coloca no sentido horario de rotacao
      set_duty_cycle(1,duty_cycle1);            //aplica o duty cycle
    }

    if(duty_cycle2 >= 0){
      pwm_steering(2,2);                        //coloca no sentido anti horario de rotacao
      set_duty_cycle(2,duty_cycle2);                     //aplica o duty cycle
    }
    else{
      duty_cycle2 = -duty_cycle2;
      pwm_steering(2,1);                       //coloca no sentido horario de rotacao
      set_duty_cycle(2,duty_cycle2);            //aplica o duty cycle
    }
}