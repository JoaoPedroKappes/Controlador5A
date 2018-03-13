

void setup_port(){
     //Desabilita comparadores internos
     CM1CON0       = 0;
     CM2CON0       = 0;

     /*** PWM ***/
     P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
     CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
     
     /*** Analog ***/
     ANSELA     = 0; //Nenhuma porta analogica
     ANSELC  = 0x01; //RC0 analogico AN4, ultimo bit do ANSELC.
     ADC_Init();     // Initialize ADC module with default settings

     //PINOS:
     /*** PORTA ***/
     TRISA0_bit = 0; //TX(UART) Nao precisamos setar pois a funcao de UART ja o faz
     TRISA1_bit = 0; //RX(UART) e LED_ERROR
     TRISA2_bit = 1; //RADIO INPUT1(CCP3)
     TRISA3_bit = 1; //MLCR e CALIB_BUTTON
     TRISA4_bit = 0; //PWM OUTPUT(P2B)
     TRISA5_bit = 0; //PWM OUTPUT(P2A)


     /*** PORTC ***/
     TRISC0_bit = 1; //AN4 (LOW BATTERY)
     TRISC1_bit = 1; //RADIO INPUT2(CCP4)
     TRISC2_bit = 1; //ERROR FLAG2
     TRISC3_bit = 1; //ERROR FLAG1
     TRISC4_bit = 0; //PWM OUTPUT(P1B)
     TRISC5_bit = 0; //PWM OUTPUT(P1A)


     /*** Interrupcoes e Captura ***/
     GIE_bit    = 0X01;   //Habilita a interrupcao Global
     PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
     CCP3IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP3(RADIO INPUT1)
     CCP4IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP4(RADIO INPUT2)
     CCP3CON     = 0x05;  //Configura captura por borda de subida
     CCP4CON     = 0x05;  //Configura captura por borda de subida

}

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
   PSTR1CON.B4 = 0;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
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
   PSTR2CON.B4 = 0;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
   CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
   CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
   T2CON = 0b00000100;  //pre scaler =  1
                        //Tosc = 1/8Mhz
                        //P = (PR2 + 1) * 4 * Tosc * Prescaler = 128us
                        //f = 7.8 khz

}

void setup_UART(){
     /*** UART ***/
     RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
     TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
     UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
     Delay_ms(100);       //Wait for UART module to stabilize
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

