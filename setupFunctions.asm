
_setup_port:

;setupFunctions.c,3 :: 		void setup_port(){
;setupFunctions.c,5 :: 		OSCCON = 0b01110010;
	MOVLW      114
	MOVWF      OSCCON+0
;setupFunctions.c,8 :: 		CM1CON0       = 0;
	CLRF       CM1CON0+0
;setupFunctions.c,9 :: 		CM2CON0       = 0;
	CLRF       CM2CON0+0
;setupFunctions.c,12 :: 		P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
	BSF        P2BSEL_bit+0, 1
;setupFunctions.c,13 :: 		CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
	BSF        CCP2SEL_bit+0, 0
;setupFunctions.c,16 :: 		ANSELA     = 0; //Nenhuma porta analogica
	CLRF       ANSELA+0
;setupFunctions.c,17 :: 		ANSELC  = 0x01; //RC0 analogico AN4, ultimo bit do ANSELC.
	MOVLW      1
	MOVWF      ANSELC+0
;setupFunctions.c,18 :: 		ADC_Init();     // Initialize ADC module with default settings
	CALL       _ADC_Init+0
;setupFunctions.c,22 :: 		TRISA0_bit = 0; //TX(UART)/PGD Nao precisamos setar pois a funcao de UART ja o faz
	BCF        TRISA0_bit+0, 0
;setupFunctions.c,23 :: 		TRISA1_bit = 0; //RX(UART) e LED_ERROR
	BCF        TRISA1_bit+0, 1
;setupFunctions.c,24 :: 		TRISA2_bit = 1; //RADIO INPUT1(CCP3)
	BSF        TRISA2_bit+0, 2
;setupFunctions.c,25 :: 		TRISA3_bit = 1; //MLCR e CALIB_BUTTON
	BSF        TRISA3_bit+0, 3
;setupFunctions.c,26 :: 		TRISA4_bit = 0; //PWM OUTPUT(P2B)
	BCF        TRISA4_bit+0, 4
;setupFunctions.c,27 :: 		TRISA5_bit = 0; //PWM OUTPUT(P2A)
	BCF        TRISA5_bit+0, 5
;setupFunctions.c,31 :: 		TRISC0_bit = 1; //AN4 (LOW BATTERY)
	BSF        TRISC0_bit+0, 0
;setupFunctions.c,32 :: 		TRISC1_bit = 1; //RADIO INPUT2(CCP4)
	BSF        TRISC1_bit+0, 1
;setupFunctions.c,33 :: 		TRISC2_bit = 1; //ERROR FLAG2
	BSF        TRISC2_bit+0, 2
;setupFunctions.c,34 :: 		TRISC3_bit = 1; //ERROR FLAG1
	BSF        TRISC3_bit+0, 3
;setupFunctions.c,35 :: 		TRISC4_bit = 0; //PWM OUTPUT(P1B)
	BCF        TRISC4_bit+0, 4
;setupFunctions.c,36 :: 		TRISC5_bit = 0; //PWM OUTPUT(P1A)
	BCF        TRISC5_bit+0, 5
;setupFunctions.c,40 :: 		GIE_bit    = 0X01;   //Habilita a interrupcao Global
	BSF        GIE_bit+0, 7
;setupFunctions.c,41 :: 		PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
	BSF        PEIE_bit+0, 6
;setupFunctions.c,43 :: 		CCP4IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP4(RADIO INPUT2)
	BSF        CCP4IE_bit+0, 5
;setupFunctions.c,44 :: 		CCP3CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;setupFunctions.c,45 :: 		CCP4CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;setupFunctions.c,47 :: 		}
L_end_setup_port:
	RETURN
; end of _setup_port

_setup_pwms:

;setupFunctions.c,49 :: 		void setup_pwms(){
;setupFunctions.c,50 :: 		T2CON = 0;   //desliga o Timer2, timer responsavel pelos PWMS
	CLRF       T2CON+0
;setupFunctions.c,51 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;setupFunctions.c,54 :: 		CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 1
;setupFunctions.c,55 :: 		CCPTMRS.B0 = 0;
	BCF        CCPTMRS+0, 0
;setupFunctions.c,58 :: 		PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 0
;setupFunctions.c,59 :: 		PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 1
;setupFunctions.c,60 :: 		PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR1CON+0, 2
;setupFunctions.c,61 :: 		PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR1CON+0, 3
;setupFunctions.c,62 :: 		PSTR1CON.B4 = 0;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BCF        PSTR1CON+0, 4
;setupFunctions.c,63 :: 		CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR1L+0
;setupFunctions.c,64 :: 		CCP1CON = 0b00111100; //see below:
	MOVLW      60
	MOVWF      CCP1CON+0
;setupFunctions.c,78 :: 		CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 3
;setupFunctions.c,79 :: 		CCPTMRS.B2 = 0;
	BCF        CCPTMRS+0, 2
;setupFunctions.c,82 :: 		PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 0
;setupFunctions.c,83 :: 		PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 1
;setupFunctions.c,84 :: 		PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR2CON+0, 2
;setupFunctions.c,85 :: 		PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR2CON+0, 3
;setupFunctions.c,86 :: 		PSTR2CON.B4 = 0;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BCF        PSTR2CON+0, 4
;setupFunctions.c,87 :: 		CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR2L+0
;setupFunctions.c,88 :: 		CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
	MOVLW      60
	MOVWF      CCP2CON+0
;setupFunctions.c,89 :: 		T2CON = 0b00000100;  //pre scaler =  1
	MOVLW      4
	MOVWF      T2CON+0
;setupFunctions.c,94 :: 		}
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_setup_UART:

;setupFunctions.c,96 :: 		void setup_UART(){
;setupFunctions.c,98 :: 		RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
	BSF        RXDTSEL_bit+0, 7
;setupFunctions.c,99 :: 		TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
	BSF        TXCKSEL_bit+0, 2
;setupFunctions.c,100 :: 		UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;setupFunctions.c,101 :: 		Delay_ms(100);       //Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_setup_UART0:
	DECFSZ     R13, 1
	GOTO       L_setup_UART0
	DECFSZ     R12, 1
	GOTO       L_setup_UART0
	DECFSZ     R11, 1
	GOTO       L_setup_UART0
	NOP
;setupFunctions.c,102 :: 		}
L_end_setup_UART:
	RETURN
; end of _setup_UART

_setup_Timer_1:

;setupFunctions.c,104 :: 		void setup_Timer_1(){
;setupFunctions.c,106 :: 		T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
	BCF        T1CKPS1_bit+0, 5
;setupFunctions.c,107 :: 		T1CKPS0_bit = 0x01;                        //
	BSF        T1CKPS0_bit+0, 4
;setupFunctions.c,108 :: 		TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS1_bit+0, 7
;setupFunctions.c,109 :: 		TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS0_bit+0, 6
;setupFunctions.c,110 :: 		TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;setupFunctions.c,112 :: 		TMR1L       = 0x00;                        //zera o Timer1
	CLRF       TMR1L+0
;setupFunctions.c,113 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;setupFunctions.c,117 :: 		}
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_setup_Timer_6:

;setupFunctions.c,119 :: 		void setup_Timer_6(){ // timer responsavel pela função millis()
;setupFunctions.c,120 :: 		PR6 = 249;         // limita o timer até 250 para totalizar um periodo de 8ms antes do overflow
	MOVLW      249
	MOVWF      PR6+0
;setupFunctions.c,121 :: 		T6CON = 0b0000111; //Liga o Timer 6 com a configuracao de Prescaler i1:64 , fazendo 32us cada incremento
	MOVLW      7
	MOVWF      T6CON+0
;setupFunctions.c,122 :: 		TMR6IE_bit = 0b01; //Habilita interrupcoes por overflow do TMR6
	BSF        TMR6IE_bit+0, 3
;setupFunctions.c,123 :: 		}
L_end_setup_Timer_6:
	RETURN
; end of _setup_Timer_6
