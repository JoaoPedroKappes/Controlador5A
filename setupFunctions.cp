#line 1 "D:/GitHub/Controlador5A/setupFunctions.c"


void setup_port(){

 OSCCON = 0b01110010;


 CM1CON0 = 0;
 CM2CON0 = 0;


 P2BSEL_bit = 1;
 CCP2SEL_bit = 1;


 ANSELA = 0;
 ANSELC = 0x01;
 ADC_Init();



 TRISA0_bit = 0;
 TRISA1_bit = 0;
 TRISA2_bit = 1;
 TRISA3_bit = 1;
 TRISA4_bit = 0;
 TRISA5_bit = 0;



 TRISC0_bit = 1;
 TRISC1_bit = 1;
 TRISC2_bit = 1;
 TRISC3_bit = 1;
 TRISC4_bit = 0;
 TRISC5_bit = 0;



 GIE_bit = 0X01;
 PEIE_bit = 0X01;

 CCP4IE_bit = 0x01;
 CCP3CON = 0x05;
 CCP4CON = 0x05;

}

void setup_pwms(){
 T2CON = 0;
 PR2 = 255;


 CCPTMRS.B1 = 0;
 CCPTMRS.B0 = 0;


 PSTR1CON.B0 = 1;
 PSTR1CON.B1 = 1;
 PSTR1CON.B2 = 0;
 PSTR1CON.B3 = 0;
 PSTR1CON.B4 = 0;
 CCPR1L = 0b11111111;
 CCP1CON = 0b00111100;
#line 78 "D:/GitHub/Controlador5A/setupFunctions.c"
 CCPTMRS.B3 = 0;
 CCPTMRS.B2 = 0;


 PSTR2CON.B0 = 1;
 PSTR2CON.B1 = 1;
 PSTR2CON.B2 = 0;
 PSTR2CON.B3 = 0;
 PSTR2CON.B4 = 0;
 CCPR2L = 0b11111111;
 CCP2CON = 0b00111100;
 T2CON = 0b00000100;




}

void setup_UART(){

 RXDTSEL_bit = 1;
 TXCKSEL_bit = 1;
 UART1_Init(9600);
 Delay_ms(100);
}

void setup_Timer_1(){

 T1CKPS1_bit = 0x00;
 T1CKPS0_bit = 0x01;
 TMR1CS1_bit = 0x00;
 TMR1CS0_bit = 0x00;
 TMR1ON_bit = 0x01;

 TMR1L = 0x00;
 TMR1H = 0x00;



}

void setup_Timer_6(){
 PR6 = 249;
 T6CON = 0b0000111;
 TMR6IE_bit = 0b01;
}
