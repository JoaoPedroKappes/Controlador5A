#line 1 "D:/Back Up/doc/minerva boats/Controlador/Controlador Supelale/Software/Controlador5A/Controlador5A.c"









 unsigned long t1_sig1;
 unsigned long t2_sig1;
 unsigned long t1_sig2;
 unsigned long t2_sig2;
 unsigned int isMeasuring1 = 0;
 unsigned int isMeasuring2 = 0;
 unsigned int n_interrupts_timer1 = 0;

void setup_pwms(){
 T2CON = 0;
 PR2 = 255;


 CCPTMRS.B1 = 0;
 CCPTMRS.B0 = 0;


 PSTR1CON.B0 = 1;
 PSTR1CON.B1 = 1;
 PSTR1CON.B2 = 0;
 PSTR1CON.B3 = 0;
 PSTR1CON.B4 = 1;
 CCPR1L = 0b11111111;
 CCP1CON = 0b00111100;
#line 47 "D:/Back Up/doc/minerva boats/Controlador/Controlador Supelale/Software/Controlador5A/Controlador5A.c"
 CCPTMRS.B3 = 0;
 CCPTMRS.B2 = 0;


 PSTR2CON.B0 = 1;
 PSTR2CON.B1 = 1;
 PSTR2CON.B2 = 0;
 PSTR2CON.B3 = 0;
 PSTR2CON.B4 = 1;
 CCPR2L = 0b11111111;
 CCP2CON = 0b00111100;
 T2CON = 0b00000100;




}

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
 PSTR1CON.B0 = 1;
 }
 if(port == 2){
 PSTR1CON.B1 = 1;
 }
 }
 if(channel == 2){
 PSTR2CON.B0 = 0;
 PSTR2CON.B1 = 0;
 if(port == 1){
 PSTR2CON.B0 = 1;
 }
 if(port == 2){
 PSTR2CON.B1 = 1;
 }
 }

}


void setup_Timer_1(){

 T1CKPS1_bit = 0x00;
 T1CKPS0_bit = 0x01;
 TMR1CS1_bit = 0x00;
 TMR1CS0_bit = 0x00;
 TMR1ON_bit = 0x01;
 TMR1IE_bit = 0x01;
 TMR1L = 0x00;
 TMR1H = 0x00;



}
unsigned long long micros(){
 return (TMR1H <<8 | TMR1L)*  1 
 + n_interrupts_timer1* 65536 ;
}
void setup_port(){

 CM1CON0 = 0;
 CM2CON0 = 0;


 RXDTSEL_bit = 1;
 TXCKSEL_bit = 1;
 UART1_Init(9600);
 Delay_ms(100);


 P2BSEL_bit = 1;
 CCP2SEL_bit = 1;





 TRISA2_bit = 1;
 TRISA3_bit = 1;
 TRISA4_bit = 0;
 TRISA5_bit = 0;
 ANSELA = 0;


 TRISC0_bit = 1;
 TRISC1_bit = 1;
 TRISC2_bit = 1;
 TRISC3_bit = 1;
 TRISC4_bit = 0;
 TRISC5_bit = 0;
 ANSELC = 0x01;



}
unsigned long long PulseIn1(){
 unsigned long long flag;
 flag = micros();
 while( RA2_bit ){
 if((micros() - flag) >  100* 20000 )
 return 0;
 }
 flag = micros();
 while( RA2_bit  == 0){
 if((micros() - flag) >  100* 20000 )
 return 0;
 }
 t1_sig1 = micros();
 flag = t1_sig1;
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
}


void main() {
 OSCCON = 0b01110010;
 GIE_bit = 0X01;
 PEIE_bit = 0X01;
 setup_port();
 setup_pwms();
 setup_Timer_1();


 while(1){
 char *txt = "mikroe \n";
 char buffer[11];
 unsigned char dc;
 unsigned int i;
 unsigned long long t;
 i = 0;
 t = pulseIn1();
#line 223 "D:/Back Up/doc/minerva boats/Controlador/Controlador Supelale/Software/Controlador5A/Controlador5A.c"
 LongWordToStr(t, buffer);

 UART1_write_text(buffer);
 UART1_write_text("\n");
 delay_ms(10);
 }
}
