#include "constants.h"
#include "setupFunctions.h"

 // --- Variaveis Globais ---
  unsigned long t1_sig1;           //tempo da subida do sinal 1
  unsigned long t2_sig1;           //tempo da descida do sinal 1
  unsigned long t1_sig2;           //tempo da subida do sinal 2
  unsigned long t2_sig2;           //tempo da descida do sinal 2
  unsigned long last_measure;      //tempo da ultima medida de sinal
  unsigned int n_interrupts_timer1 = 0;//variavel que armazena o numero de estouros do timer1
  unsigned short  lower_8bits;     //variaveis utilizadas para armazenamento de uma variavel 16bits
  unsigned short  upper_8bits;     //em dois enderecos de memoria 8 bits

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


unsigned long long micros(){
     return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
             + n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
}

unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
  if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
    return 1;
  return 0;
}

unsigned long long PulseIn1(){  //funcao que calculava, via software, o pulso recebido
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

// funcao para mapear o sinal recebido para pwm
long map(long x, long in_min, long in_max, long out_min, long out_max)
{
  return ((x - in_min) * (out_max - out_min) / (in_max - in_min)) + out_min;
}
void rotateMotor(){
    int duty_cycle1;
    int duty_cycle2;
    unsigned int pulseWidth1;
    unsigned int pulseWidth2;
    pulseWidth1 = t2_sig1;   //lê o pulso do canal 1
    pulseWidth2 = t2_sig2;   //lê o pulso do canal 2
    
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

void rotateMotor1(unsigned long long pulseWidth){  // funcao ainda nao testada
      unsigned int dc;                             //intuito de mapear 1000us a 2000ms em -100% a 100% de rotacao
      dc = (pulseWidth-1000);
      if(pulseWidth >= 1500){
         dc = (dc - 500);
         dc = dc*255/500;
         pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
         set_duty_cycle(1,dc);                     //aplica o duty cycle
      }
      if(pulseWidth < 1500){
         dc = (500 - dc);
         dc = dc*255/500;
         pwm_steering(1,2);                       //coloca no sentido horario de rotacao
         set_duty_cycle(1,dc);                    //aplica o duty cycle
      }

}

// --- Rotina de Interrupcaoo ---
// Temos 2 tipos de interrupcao, um pelo estouro do Timer1 e outra pelo modulo Capture
// Estouro do timer 1: Usamos para compor a funcao micros, nada mais eh que uma contagem de tempo
// Capture: Usamos para detectar as bordas de subida e descida e assim calcular a largura do pulso.
void interrupt()
{
   if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
  {
    TMR1IF_bit = 0;          //Limpa a flag de interrupcao
    n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
  }
  
   if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
  {                                        //Sim...
    CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP3CON     = 0x04;                    //Configura captura por borda de descida
    t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
    CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
  } //end if
   else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
  {                                        //Sim...
    CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP3CON     = 0x05;                    //Configura captura por borda de subida
    t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
    CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
    last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
  } //end else

   if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
  {                                        //Sim...
    CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP4CON     = 0x04;                    //Configura captura por borda de descida
    t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
    CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
  } //end if
   else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
  {                                        //Sim...
    CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP4CON     = 0x05;                    //Configura captura por borda de subida
    t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
    CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
    last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
  } //end else  */
} //end interrupt

void error_led_blink(unsigned time_ms){
   int i;
   time_ms = time_ms/250; //4 blinks por segundo
   for(i=0; i< time_ms; i++){
       ERROR_LED = 1;
       delay_ms(200);
       ERROR_LED = 0;
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
   
   signal1_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
   signal2_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
   signal1_H_value = 0;                        //Tempo minimo
   signal2_H_value = 0;                        //Tempo minimo
   time_control = micros();                    //controla o tempo de captura
   ERROR_LED = 1;                              //indica a captura do pulso
   
   while((micros() - time_control) < 2000000){
        signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
        if(signal_T_value < signal1_L_value)
                  signal1_L_value = signal_T_value;

        signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal2
        if(signal_T_value < signal2_L_value)
                  signal2_L_value = signal_T_value;
   }
   
   //Escrever na EEPROM
   //LOW value channel 1
   lower_8bits = signal1_L_value & 0xff;        //seleciona os 8 bits menos significativos
   upper_8bits = (signal1_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
   EEPROM_Write(0X00,lower_8bits);
   delay_ms(10);
   EEPROM_Write(0X01,upper_8bits);
   delay_ms(10);
   
   //LOW value channel 2
   lower_8bits = signal2_L_value & 0xff;        //seleciona os 8 bits menos significativos
   upper_8bits = (signal2_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
   EEPROM_Write(0X02,lower_8bits);
   delay_ms(10);
   EEPROM_Write(0X03,upper_8bits);
   delay_ms(10);

   error_led_blink(1600);                      //indica a captura do valor minimo
   time_control = micros();                    //controla o tempo de captura
   ERROR_LED = 1;                              //indica a captura do pulso
   while((micros() - time_control) < 2000000){
        signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
        if(signal_T_value > signal1_H_value)
                  signal1_H_value = signal_T_value;
              
        signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal1
        if(signal_T_value > signal2_H_value)
                  signal2_H_value = signal_T_value;
   }
   //HIGH value channel 1
   lower_8bits = signal1_H_value & 0xff;        //seleciona os 8 bits menos significativos
   upper_8bits = (signal1_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
   EEPROM_Write(0X04,lower_8bits);
   delay_ms(10);
   EEPROM_Write(0X05,upper_8bits);
   delay_ms(10);
   //HIGH value channel 2
   lower_8bits = signal2_H_value & 0xff;        //seleciona os 8 bits menos significativos
   upper_8bits = (signal2_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
   EEPROM_Write(0X06,lower_8bits);
   delay_ms(10);
   EEPROM_Write(0X07,upper_8bits);
   delay_ms(10);
   
   error_led_blink(1600);                      //indica a captura do valor maximo
   ERROR_LED = 0;
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
   OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz. NAO APAGAR ESSA LINHA (talvez muda-la pra dentro do setup_port)
   setup_port();
   setup_pwms();
   setup_Timer_1();
   //setup_UART();
   //UART1_Write_Text("Start");
   pwm_steering(1,2);
   pwm_steering(2,2);
   set_duty_cycle(1, 0);
   set_duty_cycle(2, 0);
   delay_ms(1000);
   t2_sig2 = 20000;
   t2_sig1 = 20000;
   //calibration();
   while(1){
    char *txt = "mikroe \n";
    char buffer[11];
    unsigned char dc;
    unsigned int i;
    unsigned adc_value;
    unsigned adc_value2;
    if(!CALIB_BUTTON){
      delay_ms(1000);
      CALIB_LED = 1;
      ERROR_LED = 0;
      delay_ms(1000);
      CALIB_LED = 0;
      ERROR_LED = 1;
     }
     else{
      CALIB_LED = 0;
      ERROR_LED = 0;
     }
    }
}