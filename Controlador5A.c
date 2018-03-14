#include "constants.h"
#include "setupFunctions.h"
#include "motorsPWM.h"
#include "timeMeasure.h"

 // --- Variaveis Globais ---
  unsigned int sig1_width = 1500;           //tempo da subida do sinal 1
  unsigned int sig2_width = 1500;           //tempo da descida do sinal 2
  unsigned long last_measure;               //tempo da ultima medida de sinal
  unsigned int n_interrupts_timer6 = 0;     //variavel que armazena o numero de estouros do timer16
  unsigned short  lower_8bits;              //variaveis utilizadas para armazenamento de uma variavel 16bits
  unsigned short  upper_8bits;              //em dois enderecos de memoria 8 bits

unsigned long long millis(){
    return  TMR6*TIMER6_CONST + n_interrupts_timer6*OVERFLOW_TMR6_CONST;
}

unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
  if((millis() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
    return 1;
  return 0;
}

// --- Rotina de Interrupcaoo ---
// Temos 2 tipos de interrupcao, um pelo estouro do Timer6 e outra pelo modulo Capture
// Estouro do timer 6: Usamos para compor a funcao millis, nada mais eh que uma contagem de tempo
// Capture: Usamos para detectar as bordas de subida e descida e assim calcular a largura do pulso.
void interrupt()
{
   if(TMR6IF_bit)            //interrupcao pelo estouro do Timer6
  {
    TMR6IF_bit = 0;          //Limpa a flag de interrupcao
    n_interrupts_timer6++;   //incrementa a flag do overflow do timer6
  }
  
   if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
  {                                        //Sim...
    CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP3CON     = 0x04;                    //Configura captura por borda de descida
    CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
    TMR1L       = 0x00;                    //zera o Timer1
    TMR1H       = 0x00;
    TMR1ON_bit  = 0x01;                    //Inicia a contagem do Timer1
  } //end if
   else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
  {                                        //Sim...
    CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
    TMR1ON_bit  = 0x00;                    //Interrompe a contagem do Timer1
    CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP3CON     = 0x05;                    //Configura captura por borda de subida
    sig1_width  = (TMR1H <<8 | TMR1L);     //Captura a largura do pulso do Sinal 1
    CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP4 = RADIO_IN2
  } //end else

   if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
  {                                        //Sim...
    CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
    CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP4CON     = 0x04;                    //Configura captura por borda de descida
    CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
    TMR1L       = 0x00;                    //zera o Timer1
    TMR1H       = 0x00;
    TMR1ON_bit  = 0x01;                    //Inicia a contagem do Timer1
  } //end if
   else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
  {                                        //Sim...
    CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
    TMR1ON_bit  = 0x00;                    //Interrompe a contagem do Timer1
    CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
    CCP4CON     = 0x05;                    //Configura captura por borda de subida
    sig2_width  = (TMR1H <<8 | TMR1L);     //Captura a largura do pulso do Sinal 2
    CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP3 = RADIO_IN1
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
   time_control = millis();                    //controla o tempo de captura
   ERROR_LED = 1;                              //indica a captura do pulso
   
   while((millis() - time_control) < 2000){ // 2 segundos
        signal_T_value = (unsigned) sig1_width;   //valor da largura do pulso do canal1
        if(signal_T_value < signal1_L_value)
                  signal1_L_value = signal_T_value;

        signal_T_value = (unsigned) sig2_width;   //valor da largura do pulso do canal2
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
   time_control = millis();                    //controla o tempo de captura
   ERROR_LED = 1;                              //indica a captura do pulso
   while((millis() - time_control) < 2000){    // 2 segundos
        signal_T_value = (unsigned) sig1_width;   //valor da largura do pulso do canal1
        if(signal_T_value > signal1_H_value)
                  signal1_H_value = signal_T_value;
              
        signal_T_value = (unsigned) sig2_width;   //valor da largura do pulso do canal1
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
   setup_Timer_6();
   setup_UART();
   UART1_Write_Text("Start");
   pwm_steering(1,2);
   pwm_steering(2,2);
   set_duty_cycle(1, 0);
   set_duty_cycle(2, 0);
   delay_ms(1000);
   //calibration();
   while(1){
       char buffer[11];
       unsigned long t1,t2;
       unsigned long pulsew1,pulsew2;
       pulsew1 = sig1_width;
       pulsew2 = sig2_width;
       print_signal_received(pulsew1,pulsew2);
       //rotateMotors(pulsew1,pulsew2);

       t1 = millis();
       delay_ms(100);
       t2 = millis() - t1;
       UART1_write_text("Delta t: ");
       IntToStr(t2, buffer);
       UART1_write_text(buffer);
       UART1_write_text("\n");
    }
}