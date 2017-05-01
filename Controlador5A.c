 #define TIMER1_CONST      1 //cada bit do timer 1 vale 1us
 #define OVERFLOW_CONST    65536
 #define SIGNAL_PERIOD     20000   //20ms
 #define SIGNAL_PERIOD_OFFSET 1000/SIGNAL_PERIOD; // 1ms/20ms
 #define UART_CONST         15.6
 #define FAIL_SAFE_TIME   100*SIGNAL_PERIOD
 #define RADIO_IN1    RA2_bit
 #define RADIO_IN2    RC1_bit
 
 
 // --- Variaveis Globais ---
  unsigned long t1_sig1;           //tempo da subida do sinal 1
  unsigned long t2_sig1;           //tempo da descida do sinal 1
  unsigned long t1_sig2;           //tempo da subida do sinal 2
  unsigned long t2_sig2;           //tempo da descida do sinal 2
  unsigned int isMeasuring1 = 0;   //variavel booleana para o reset do Timer1
  unsigned int isMeasuring2 = 0;   //variavel booleana para o reset do Timer1
  unsigned int n_interrupts_timer1 = 0;//variavel que armazena o numero de estouros do timer1
 
void setup_pwms(){
   T2CON = 0;   //desliga o Timer2, timer responsavel pelos PWMS
   PR2 = 255;

   /*** ECCP1 ***/
   CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
   CCPTMRS.B0 = 0;

   //PSTR1CON: PWM STEERING CONTROL REGISTER(1): esses registros que precisamos mudar quando vamos fazer o steering
   PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
   PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
   PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
   PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
   PSTR1CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
   CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
   CCP1CON = 0b00111100; //see below:
   /*
   P1M<1:0>: Enhanced PWM Output Configuration bits(1)
   CCP1CON.B7 = 0;    //00 = Single output; PxA modulated; PxB, PxC, PxD assigned as port pins
   CCP1CON.B6 = 0;
   CCP1CON<5:4> = 11;  //PWM Duty Cycle Least Significant bits
   //CCP1M<3:0>: ECCP1 Mode Select bit
   CCP1CON.B3 = 1;    //1100 = PWM mode: PxA, PxC active-high; PxB, PxD active-high
   CCP1CON.B2 = 1;
   CCP1CON.B1 = 0;
   CCP1CON.B0 = 0;
   */
   
   /*** ECCP2 ***/
   CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
   CCPTMRS.B2 = 0;

   //PSTR2CON: PWM STEERING CONTROL REGISTER(1): esses registros que precisamos mudar quando vamos fazer o steering
   PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
   PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
   PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
   PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
   PSTR2CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
   CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
   CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
   T2CON = 0b00000100;  //pre scaler =  1
                        //Tosc = 1/8Mhz
                        //P = (PR2 + 1) * 4 * Tosc * Prescaler = 128us
                        //f = 7.8 khz

}

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
         PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
       }
       if(port == 2){
         PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
       }
     }//channel1 if
     if(channel == 2){
       PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
       PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
       if(port == 1){
         PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
       }
       if(port == 2){
         PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
       }
     }//channel2 if

}


void setup_Timer_1(){
     //Registrador T1CON (pag 177 datasheet):
     T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
     T1CKPS0_bit = 0x01;                        //
     TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
     TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
     TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
     TMR1IE_bit  = 0x01;                        //Habilita interrupcoes de TMR1
     TMR1L       = 0x00;                        //zera o Timer1
     TMR1H       = 0x00;
     //T_MAX = 2^16*1us = 65.536ms
     //T_MAX/PERIODO_SINAL = 3.27
     //A cada final de medicao, o timer e resetado para nao haver problemas de overflow
}
unsigned long long micros(){
     return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 0.5us
             + n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
}
void setup_port(){
     //Desabilita comparadores internos
     CM1CON0       = 0;
     CM2CON0       = 0;
     
     /*** UART ***/
     RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
     TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
     UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
     Delay_ms(100);       //Wait for UART module to stabilize
     
     /*** PWM ***/
     P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
     CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
     
     //PINOS:
     /*** PORTA ***/
     //TRISA0_bit = 0; //TX(UART)   Nao precisamos setar pois a funcao de UART ja o faz
     //TRISA1_bit = 1; //RX(UART)
     TRISA2_bit = 1; //RADIO INPUT1(CCP3)
     TRISA3_bit = 1; //MLCR
     TRISA4_bit = 0; //PWM OUTPUT(P2B)
     TRISA5_bit = 0; //PWM OUTPUT(P2A)
     ANSELA     = 0; //Nenhuma porta analogica

     /*** PORTC ***/
     TRISC0_bit = 1; //AN4 (LOW BATTERY)
     TRISC1_bit = 1; //RADIO INPUT2(CCP4)
     TRISC2_bit = 1; //ERROR FLAG2
     TRISC3_bit = 1; //ERROR FLAG1
     TRISC4_bit = 0; //PWM OUTPUT(P1B)
     TRISC5_bit = 0; //PWM OUTPUT(P1A)
     ANSELC  = 0x01; //RC0 analogico, ultimo bit do ANSELC.
     

     
}
unsigned long long PulseIn1(){
 unsigned long long flag;
 flag = micros();
 while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
   if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
     return 0;
 }
 while(RADIO_IN1 == 0){   //espera o sinal
   if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
     return 0;
 }
 t1_sig1 = micros(); //mede o inicio do sinal
 while(RADIO_IN1){   //espera o sinal acabar
   if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
     return 0;
 }
 t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo

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
// --- Rotina de Interrupcaoo ---
void interrupt()
{
   if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
  {
    TMR1IF_bit = 0;          //Limpa a flag de interrupcao
    n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
  }
} //end interrupt


void main() {
   OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz
   GIE_bit    = 0X01;   //Habilita a interrupcao Global
   PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
   setup_port();
   setup_pwms();
   setup_Timer_1();
   //UART1_Write_Text("Start");

   while(1){
    char *txt = "mikroe \n";
    char buffer[11];
    unsigned char dc;
    unsigned int i;
    unsigned long long t;
    i = 0;
    t = pulseIn1();
    /*if(t< 1000)
       t = 1000;
    if(t > 2000)
       t = 2000;
    rotateMotor1(t);*/
    LongWordToStr(t, buffer);

    UART1_write_text(buffer);
    UART1_write_text("\n");
    delay_ms(10);
    }
}