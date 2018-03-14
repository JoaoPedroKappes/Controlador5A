#line 1 "D:/GitHub/Controlador5A/Controlador5A.c"
#line 1 "d:/github/controlador5a/constants.h"
#line 1 "d:/github/controlador5a/setupfunctions.h"

void setup_port();
void setup_UART();
void setup_pwms();
void setup_Timer_1();
#line 1 "d:/github/controlador5a/motorspwm.h"

void set_duty_cycle(unsigned int, unsigned int);
void pwm_steering(unsigned int,unsigned int);
long map(long, long , long, long, long );
void rotateMotors(unsigned int, unsigned int);
#line 6 "D:/GitHub/Controlador5A/Controlador5A.c"
 unsigned long t1_sig1;
 unsigned long t2_sig1;
 unsigned long t1_sig2;
 unsigned long t2_sig2;
 unsigned long last_measure;
 unsigned int n_interrupts_timer1 = 0;
 unsigned short lower_8bits;
 unsigned short upper_8bits;

unsigned long long micros(){
 return (TMR1H <<8 | TMR1L)*  1 
 + n_interrupts_timer1* 65536 ;
}

unsigned failSafeCheck(){
 if((micros() - last_measure) >  100* 20000  )
 return 1;
 return 0;
}

unsigned long long PulseIn1(){
 unsigned long long flag;
 flag = micros();
 while( RA2_bit ){
 if((micros() - flag) >  100* 20000 )
 return 0;
 }
 while( RA2_bit  == 0){
 if((micros() - flag) >  100* 20000 )
 return 0;
 }
 t1_sig1 = micros();
 while( RA2_bit ){
 if((micros() - flag) >  100* 20000 )
 return 0;
 }
 t1_sig1 = micros() - t1_sig1;

 return t1_sig1;
}


void rotateMotor1(unsigned long long pulseWidth){
 unsigned int dc;
 dc = (pulseWidth-1000);
 if(pulseWidth >= 1500){
 dc = (dc - 500);
 dc = dc*255/500;
 pwm_steering(1,1);
 set_duty_cycle(1,dc);
 }
 if(pulseWidth < 1500){
 dc = (500 - dc);
 dc = dc*255/500;
 pwm_steering(1,2);
 set_duty_cycle(1,dc);
 }

}





void interrupt()
{
 if(TMR1IF_bit)
 {
 TMR1IF_bit = 0;
 n_interrupts_timer1++;
 }

 if(CCP3IF_bit && CCP3CON.B0)
 {
 CCP3IF_bit = 0x00;
 CCP3IE_bit = 0x00;
 CCP3CON = 0x04;
 t1_sig1 = micros();
 CCP3IE_bit = 0x01;
 }
 else if(CCP3IF_bit)
 {
 CCP3IF_bit = 0x00;
 CCP3IE_bit = 0x00;
 CCP3CON = 0x05;
 t2_sig1 = micros() - t1_sig1;
 CCP3IE_bit = 0x01;
 last_measure = micros();
 }

 if(CCP4IF_bit && CCP4CON.B0)
 {
 CCP4IF_bit = 0x00;
 CCP4IE_bit = 0x00;
 CCP4CON = 0x04;
 t1_sig2 = micros();
 CCP4IE_bit = 0x01;
 }
 else if(CCP4IF_bit)
 {
 CCP4IF_bit = 0x00;
 CCP4IE_bit = 0x00;
 CCP4CON = 0x05;
 t2_sig2 = micros() - t1_sig2;
 CCP4IE_bit = 0x01;
 last_measure = micros();
 }
}

void error_led_blink(unsigned time_ms){
 int i;
 time_ms = time_ms/250;
 for(i=0; i< time_ms; i++){
  RA0_bit  = 1;
 delay_ms(200);
  RA0_bit  = 0;
 delay_ms(200);
 }
}
void calibration(){
 unsigned int signal1_H_value;
 unsigned int signal2_H_value;
 unsigned int signal1_L_value;
 unsigned int signal2_L_value;
 unsigned int signal_T_value;
 unsigned long time_control;

 signal1_L_value = 20000;
 signal2_L_value = 20000;
 signal1_H_value = 0;
 signal2_H_value = 0;
 time_control = micros();
  RA0_bit  = 1;

 while((micros() - time_control) < 2000000){
 signal_T_value = (unsigned) t2_sig1;
 if(signal_T_value < signal1_L_value)
 signal1_L_value = signal_T_value;

 signal_T_value = (unsigned) t2_sig2;
 if(signal_T_value < signal2_L_value)
 signal2_L_value = signal_T_value;
 }



 lower_8bits = signal1_L_value & 0xff;
 upper_8bits = (signal1_L_value >> 8) & 0xff;
 EEPROM_Write(0X00,lower_8bits);
 delay_ms(10);
 EEPROM_Write(0X01,upper_8bits);
 delay_ms(10);


 lower_8bits = signal2_L_value & 0xff;
 upper_8bits = (signal2_L_value >> 8) & 0xff;
 EEPROM_Write(0X02,lower_8bits);
 delay_ms(10);
 EEPROM_Write(0X03,upper_8bits);
 delay_ms(10);

 error_led_blink(1600);
 time_control = micros();
  RA0_bit  = 1;
 while((micros() - time_control) < 2000000){
 signal_T_value = (unsigned) t2_sig1;
 if(signal_T_value > signal1_H_value)
 signal1_H_value = signal_T_value;

 signal_T_value = (unsigned) t2_sig2;
 if(signal_T_value > signal2_H_value)
 signal2_H_value = signal_T_value;
 }

 lower_8bits = signal1_H_value & 0xff;
 upper_8bits = (signal1_H_value >> 8) & 0xff;
 EEPROM_Write(0X04,lower_8bits);
 delay_ms(10);
 EEPROM_Write(0X05,upper_8bits);
 delay_ms(10);

 lower_8bits = signal2_H_value & 0xff;
 upper_8bits = (signal2_H_value >> 8) & 0xff;
 EEPROM_Write(0X06,lower_8bits);
 delay_ms(10);
 EEPROM_Write(0X07,upper_8bits);
 delay_ms(10);

 error_led_blink(1600);
  RA0_bit  = 0;
}

void read_eeprom_signals_data(){
 char buffer[11];
 unsigned int signal_value;

 UART1_write_text("LOW channel1: ");
 lower_8bits = EEPROM_Read(0X00);
 upper_8bits = EEPROM_Read(0X01);
 signal_value = (upper_8bits << 8) | lower_8bits;
 WordToStr(signal_value, buffer);
 UART1_write_text(buffer);
 UART1_write_text(" channel2: ");
 lower_8bits = EEPROM_Read(0X02);
 upper_8bits = EEPROM_Read(0X03);
 signal_value = (upper_8bits << 8) | lower_8bits;
 WordToStr(signal_value, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\t");
 delay_ms(10);

 UART1_write_text("HIGH channel1: ");
 lower_8bits = EEPROM_Read(0X04);
 upper_8bits = EEPROM_Read(0X05);
 signal_value = (upper_8bits << 8) | lower_8bits;
 WordToStr(signal_value, buffer);
 UART1_write_text(buffer);
 UART1_write_text(" channel2: ");
 lower_8bits = EEPROM_Read(0X06);
 upper_8bits = EEPROM_Read(0X07);
 signal_value = (upper_8bits << 8) | lower_8bits;
 WordToStr(signal_value, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\n");
 delay_ms(10);
}

void print_signal_received(){
 char buffer[11];

 UART1_write_text("Sinal 1: ");
 LongWordToStr(t2_sig1, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\t");

 UART1_write_text("Sinal 2: ");
 LongWordToStr(t2_sig2, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\n");

 delay_ms(100);
}

void main() {
 OSCCON = 0b01110010;
 setup_port();
 setup_pwms();
 setup_Timer_1();


 pwm_steering(1,2);
 pwm_steering(2,2);
 set_duty_cycle(1, 0);
 set_duty_cycle(2, 0);
 delay_ms(1000);
 t2_sig2 = 15000;
 t2_sig1 = 15000;

 while(1){
 rotateMotors(t2_sig1,t2_sig2);
 }
}
