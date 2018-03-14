#line 1 "D:/GitHub/Controlador5A/motorsPWM.c"
#line 1 "d:/github/controlador5a/constants.h"
#line 4 "D:/GitHub/Controlador5A/motorsPWM.c"
void set_duty_cycle(unsigned int channel, unsigned int duty ){
 if(channel == 1)
 CCPR1L = duty;
 if(channel == 2)
 CCPR2L = duty;
}
void pwm_steering(unsigned int channel,unsigned int port){
 if(channel == 1){
 PSTR1CON.B0 = 0;
 PSTR1CON.B1 = 0;
 if(port == 1){
  RC4_bit  = 0;
 PSTR1CON.B0 = 1;
 }
 if(port == 2){
  RC5_bit  = 0;
 PSTR1CON.B1 = 1;
 }
 }
 if(channel == 2){
 PSTR2CON.B0 = 0;
 PSTR2CON.B1 = 0;
 if(port == 1){
  RA4_bit  = 0;
 PSTR2CON.B0 = 1;
 }
 if(port == 2){
  RA5_bit  = 0;
 PSTR2CON.B1 = 1;
 }
 }

}


long map(long x, long in_min, long in_max, long out_min, long out_max)
{
 return (((x - in_min) * (out_max - out_min)) / (in_max - in_min)) + out_min;
}

void rotateMotors(unsigned int pulseWidth1,unsigned int pulseWidth2){
 int duty_cycle1;
 int duty_cycle2;


 if(pulseWidth1 <  1100 )
 pulseWidth1 =  1100 ;
 if(pulseWidth1 >  1900 )
 pulseWidth1 =  1900 ;

 if(pulseWidth2 <  1100 )
 pulseWidth2 =  1100 ;
 if(pulseWidth2 >  1900 )
 pulseWidth2 =  1900 ;


 if((pulseWidth1 < ( ( 1100  + 1900 )/2  +  50 )) && (pulseWidth1 > ( ( 1100  + 1900 )/2  -  50 )))
 pulseWidth1 =  ( 1100  + 1900 )/2 ;

 if((pulseWidth2 < ( ( 1100  + 1900 )/2  +  50 )) && (pulseWidth2 > ( ( 1100  + 1900 )/2  -  50 )))
 pulseWidth2 =  ( 1100  + 1900 )/2 ;


 duty_cycle1 = map(pulseWidth1, 1100 , 1900 , -255 , 255 );
 duty_cycle2 = map(pulseWidth2, 1100 , 1900 , -255 , 255 );

 if(duty_cycle1 >= 0){
 pwm_steering(1,2);
 set_duty_cycle(1,duty_cycle1);
 }
 else{
 duty_cycle1 = -duty_cycle1;
 pwm_steering(1,1);
 set_duty_cycle(1,duty_cycle1);
 }

 if(duty_cycle2 >= 0){
 pwm_steering(2,2);
 set_duty_cycle(2,duty_cycle2);
 }
 else{
 duty_cycle2 = -duty_cycle2;
 pwm_steering(2,1);
 set_duty_cycle(2,duty_cycle2);
 }
}
