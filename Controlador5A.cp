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
#line 1 "d:/github/controlador5a/timemeasure.h"

typedef struct timeMeasure {unsigned int n_overflows, time_reg;} TimeMeasure;
TimeMeasure microsT(unsigned int);
unsigned int timeDifference(TimeMeasure , TimeMeasure );
#line 7 "D:/GitHub/Controlador5A/Controlador5A.c"
 unsigned int sig1_width = 1500;
 unsigned int sig2_width = 1500;
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





void interrupt()
{
#line 37 "D:/GitHub/Controlador5A/Controlador5A.c"
 if(CCP3IF_bit && CCP3CON.B0)
 {
 CCP3IF_bit = 0x00;
 CCP3IE_bit = 0x00;
 CCP3CON = 0x04;
 CCP3IE_bit = 0x01;
 TMR1L = 0x00;
 TMR1H = 0x00;
 TMR1ON_bit = 0x01;
 }
 else if(CCP3IF_bit)
 {
 CCP3IF_bit = 0x00;
 TMR1ON_bit = 0x00;
 CCP3IE_bit = 0x00;
 CCP3CON = 0x05;
 sig1_width = (TMR1H <<8 | TMR1L);
 CCP4IE_bit = 0x01;
 }

 if(CCP4IF_bit && CCP4CON.B0)
 {
 CCP4IF_bit = 0x00;
 CCP4IE_bit = 0x00;
 CCP4CON = 0x04;
 CCP4IE_bit = 0x01;
 TMR1L = 0x00;
 TMR1H = 0x00;
 TMR1ON_bit = 0x01;
 }
 else if(CCP4IF_bit)
 {
 CCP4IF_bit = 0x00;
 TMR1ON_bit = 0x00;
 CCP4IE_bit = 0x00;
 CCP4CON = 0x05;
 sig2_width = (TMR1H <<8 | TMR1L);
 CCP3IE_bit = 0x01;
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
 signal_T_value = (unsigned) sig1_width;
 if(signal_T_value < signal1_L_value)
 signal1_L_value = signal_T_value;

 signal_T_value = (unsigned) sig2_width;
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
 signal_T_value = (unsigned) sig1_width;
 if(signal_T_value > signal1_H_value)
 signal1_H_value = signal_T_value;

 signal_T_value = (unsigned) sig2_width;
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

void print_signal_received(unsigned sig1,unsigned sig2 ){
 char buffer[11];

 UART1_write_text("Sinal 1: ");
 IntToStr(sig1, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\t");

 UART1_write_text("Sinal 2: ");
 IntToStr(sig2, buffer);
 UART1_write_text(buffer);
 UART1_write_text("\n");

 delay_ms(100);
}

void main() {
 setup_port();
 setup_pwms();
 setup_Timer_1();
 setup_UART();
 UART1_Write_Text("Start");
 pwm_steering(1,2);
 pwm_steering(2,2);
 set_duty_cycle(1, 0);
 set_duty_cycle(2, 0);
 delay_ms(1000);

 while(1){
 unsigned long pulsew1,pulsew2;
 pulsew1 = sig1_width;
 pulsew2 = sig2_width;
 print_signal_received(pulsew1,pulsew2);
 rotateMotors(pulsew1,pulsew2);

 }
}
