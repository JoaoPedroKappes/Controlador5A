
_setup_pwms:

;Controlador5A.c,19 :: 		void setup_pwms(){
;Controlador5A.c,20 :: 		T2CON = 0;   //desliga o Timer2, timer responsavel pelos PWMS
	CLRF       T2CON+0
;Controlador5A.c,21 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;Controlador5A.c,24 :: 		CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 1
;Controlador5A.c,25 :: 		CCPTMRS.B0 = 0;
	BCF        CCPTMRS+0, 0
;Controlador5A.c,28 :: 		PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 0
;Controlador5A.c,29 :: 		PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 1
;Controlador5A.c,30 :: 		PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR1CON+0, 2
;Controlador5A.c,31 :: 		PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR1CON+0, 3
;Controlador5A.c,32 :: 		PSTR1CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR1CON+0, 4
;Controlador5A.c,33 :: 		CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR1L+0
;Controlador5A.c,34 :: 		CCP1CON = 0b00111100; //see below:
	MOVLW      60
	MOVWF      CCP1CON+0
;Controlador5A.c,48 :: 		CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 3
;Controlador5A.c,49 :: 		CCPTMRS.B2 = 0;
	BCF        CCPTMRS+0, 2
;Controlador5A.c,52 :: 		PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 0
;Controlador5A.c,53 :: 		PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 1
;Controlador5A.c,54 :: 		PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR2CON+0, 2
;Controlador5A.c,55 :: 		PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR2CON+0, 3
;Controlador5A.c,56 :: 		PSTR2CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR2CON+0, 4
;Controlador5A.c,57 :: 		CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR2L+0
;Controlador5A.c,58 :: 		CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
	MOVLW      60
	MOVWF      CCP2CON+0
;Controlador5A.c,59 :: 		T2CON = 0b00000100;  //pre scaler =  1
	MOVLW      4
	MOVWF      T2CON+0
;Controlador5A.c,64 :: 		}
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_set_duty_cycle:

;Controlador5A.c,66 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
;Controlador5A.c,67 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle40
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle40:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;Controlador5A.c,68 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;Controlador5A.c,69 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle41
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle41:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;Controlador5A.c,70 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;Controlador5A.c,71 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;Controlador5A.c,72 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;Controlador5A.c,73 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering43
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering43:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;Controlador5A.c,74 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;Controlador5A.c,75 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;Controlador5A.c,76 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering44
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering44:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;Controlador5A.c,77 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;Controlador5A.c,78 :: 		}
L_pwm_steering3:
;Controlador5A.c,79 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering45
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering45:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;Controlador5A.c,80 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;Controlador5A.c,81 :: 		}
L_pwm_steering4:
;Controlador5A.c,82 :: 		}//channel1 if
L_pwm_steering2:
;Controlador5A.c,83 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering46
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering46:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;Controlador5A.c,84 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;Controlador5A.c,85 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;Controlador5A.c,86 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering47
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering47:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;Controlador5A.c,87 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;Controlador5A.c,88 :: 		}
L_pwm_steering6:
;Controlador5A.c,89 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering48
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering48:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;Controlador5A.c,90 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;Controlador5A.c,91 :: 		}
L_pwm_steering7:
;Controlador5A.c,92 :: 		}//channel2 if
L_pwm_steering5:
;Controlador5A.c,94 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_setup_Timer_1:

;Controlador5A.c,97 :: 		void setup_Timer_1(){
;Controlador5A.c,99 :: 		T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
	BCF        T1CKPS1_bit+0, 5
;Controlador5A.c,100 :: 		T1CKPS0_bit = 0x01;                        //
	BSF        T1CKPS0_bit+0, 4
;Controlador5A.c,101 :: 		TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS1_bit+0, 7
;Controlador5A.c,102 :: 		TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS0_bit+0, 6
;Controlador5A.c,103 :: 		TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,104 :: 		TMR1IE_bit  = 0x01;                        //Habilita interrupcoes de TMR1
	BSF        TMR1IE_bit+0, 0
;Controlador5A.c,105 :: 		TMR1L       = 0x00;                        //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,106 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,110 :: 		}
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_micros:

;Controlador5A.c,111 :: 		unsigned long long micros(){
;Controlador5A.c,112 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
	MOVF       TMR1H+0, 0
	MOVWF      R1
	CLRF       R0
	MOVF       TMR1L+0, 0
	IORWF       R0, 0
	MOVWF      R5
	MOVF       R1, 0
	MOVWF      R6
	MOVLW      0
	IORWF       R6, 1
;Controlador5A.c,113 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
	MOVF       _n_interrupts_timer1+1, 0
	MOVWF      R3
	MOVF       _n_interrupts_timer1+0, 0
	MOVWF      R2
	CLRF       R0
	CLRF       R1
	MOVF       R5, 0
	ADDWF      R0, 1
	MOVF       R6, 0
	ADDWFC     R1, 1
	MOVLW      0
	ADDWFC     R2, 1
	ADDWFC     R3, 1
;Controlador5A.c,114 :: 		}
L_end_micros:
	RETURN
; end of _micros

_setup_port:

;Controlador5A.c,115 :: 		void setup_port(){
;Controlador5A.c,117 :: 		CM1CON0       = 0;
	CLRF       CM1CON0+0
;Controlador5A.c,118 :: 		CM2CON0       = 0;
	CLRF       CM2CON0+0
;Controlador5A.c,121 :: 		RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
	BSF        RXDTSEL_bit+0, 7
;Controlador5A.c,122 :: 		TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
	BSF        TXCKSEL_bit+0, 2
;Controlador5A.c,123 :: 		UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Controlador5A.c,124 :: 		Delay_ms(100);       //Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_setup_port8:
	DECFSZ     R13, 1
	GOTO       L_setup_port8
	DECFSZ     R12, 1
	GOTO       L_setup_port8
	DECFSZ     R11, 1
	GOTO       L_setup_port8
	NOP
;Controlador5A.c,127 :: 		P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
	BSF        P2BSEL_bit+0, 1
;Controlador5A.c,128 :: 		CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
	BSF        CCP2SEL_bit+0, 0
;Controlador5A.c,130 :: 		ANSELA     = 0; //Nenhuma porta analogica
	CLRF       ANSELA+0
;Controlador5A.c,131 :: 		ANSELC  = 0x01; //RC0 analogico AN4, ultimo bit do ANSELC.
	MOVLW      1
	MOVWF      ANSELC+0
;Controlador5A.c,132 :: 		ADC_Init();     // Initialize ADC module with default settings
	CALL       _ADC_Init+0
;Controlador5A.c,138 :: 		TRISA2_bit = 1; //RADIO INPUT1(CCP3)
	BSF        TRISA2_bit+0, 2
;Controlador5A.c,139 :: 		TRISA3_bit = 1; //MLCR
	BSF        TRISA3_bit+0, 3
;Controlador5A.c,140 :: 		TRISA4_bit = 0; //PWM OUTPUT(P2B)
	BCF        TRISA4_bit+0, 4
;Controlador5A.c,141 :: 		TRISA5_bit = 0; //PWM OUTPUT(P2A)
	BCF        TRISA5_bit+0, 5
;Controlador5A.c,145 :: 		TRISC0_bit = 1; //AN4 (LOW BATTERY)
	BSF        TRISC0_bit+0, 0
;Controlador5A.c,146 :: 		TRISC1_bit = 1; //RADIO INPUT2(CCP4)
	BSF        TRISC1_bit+0, 1
;Controlador5A.c,147 :: 		TRISC2_bit = 1; //ERROR FLAG2
	BSF        TRISC2_bit+0, 2
;Controlador5A.c,148 :: 		TRISC3_bit = 1; //ERROR FLAG1
	BSF        TRISC3_bit+0, 3
;Controlador5A.c,149 :: 		TRISC4_bit = 0; //PWM OUTPUT(P1B)
	BCF        TRISC4_bit+0, 4
;Controlador5A.c,150 :: 		TRISC5_bit = 0; //PWM OUTPUT(P1A)
	BCF        TRISC5_bit+0, 5
;Controlador5A.c,154 :: 		GIE_bit    = 0X01;   //Habilita a interrupcao Global
	BSF        GIE_bit+0, 7
;Controlador5A.c,155 :: 		PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
	BSF        PEIE_bit+0, 6
;Controlador5A.c,156 :: 		CCP3IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP3(RADIO INPUT1)
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,157 :: 		CCP4IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP4(RADIO INPUT2)
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,158 :: 		CCP3CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,159 :: 		CCP4CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,161 :: 		}
L_end_setup_port:
	RETURN
; end of _setup_port

_failSafeCheck:

;Controlador5A.c,163 :: 		unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
;Controlador5A.c,164 :: 		if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       _last_measure+0, 0
	SUBWF      R4, 1
	MOVF       _last_measure+1, 0
	SUBWFB     R5, 1
	MOVF       _last_measure+2, 0
	SUBWFB     R6, 1
	MOVF       _last_measure+3, 0
	SUBWFB     R7, 1
	MOVF       R7, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck53
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck53
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck53
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck53:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck9
;Controlador5A.c,165 :: 		return 1;
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck9:
;Controlador5A.c,166 :: 		return 0;
	CLRF       R0
	CLRF       R1
;Controlador5A.c,167 :: 		}
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_PulseIn1:

;Controlador5A.c,169 :: 		unsigned long long PulseIn1(){  //funcao que calculava, via software, o pulso recebido
;Controlador5A.c,171 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,172 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn110:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn111
;Controlador5A.c,173 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       PulseIn1_flag_L0+0, 0
	SUBWF      R4, 1
	MOVF       PulseIn1_flag_L0+1, 0
	SUBWFB     R5, 1
	MOVF       PulseIn1_flag_L0+2, 0
	SUBWFB     R6, 1
	MOVF       PulseIn1_flag_L0+3, 0
	SUBWFB     R7, 1
	MOVF       R7, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn155
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn155
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn155
	MOVF       R4, 0
	SUBLW      128
L__PulseIn155:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn112
;Controlador5A.c,174 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn112:
;Controlador5A.c,175 :: 		}
	GOTO       L_PulseIn110
L_PulseIn111:
;Controlador5A.c,176 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn113:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn114
;Controlador5A.c,177 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       PulseIn1_flag_L0+0, 0
	SUBWF      R4, 1
	MOVF       PulseIn1_flag_L0+1, 0
	SUBWFB     R5, 1
	MOVF       PulseIn1_flag_L0+2, 0
	SUBWFB     R6, 1
	MOVF       PulseIn1_flag_L0+3, 0
	SUBWFB     R7, 1
	MOVF       R7, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn156
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn156
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn156
	MOVF       R4, 0
	SUBLW      128
L__PulseIn156:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn115
;Controlador5A.c,178 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn115:
;Controlador5A.c,179 :: 		}
	GOTO       L_PulseIn113
L_PulseIn114:
;Controlador5A.c,180 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,181 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn116:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn117
;Controlador5A.c,182 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       PulseIn1_flag_L0+0, 0
	SUBWF      R4, 1
	MOVF       PulseIn1_flag_L0+1, 0
	SUBWFB     R5, 1
	MOVF       PulseIn1_flag_L0+2, 0
	SUBWFB     R6, 1
	MOVF       PulseIn1_flag_L0+3, 0
	SUBWFB     R7, 1
	MOVF       R7, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn157
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn157
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn157
	MOVF       R4, 0
	SUBLW      128
L__PulseIn157:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn118
;Controlador5A.c,183 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn118:
;Controlador5A.c,184 :: 		}
	GOTO       L_PulseIn116
L_PulseIn117:
;Controlador5A.c,185 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
	CALL       _micros+0
	MOVF       _t1_sig1+0, 0
	SUBWF      R0, 1
	MOVF       _t1_sig1+1, 0
	SUBWFB     R1, 1
	MOVF       _t1_sig1+2, 0
	SUBWFB     R2, 1
	MOVF       _t1_sig1+3, 0
	SUBWFB     R3, 1
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,187 :: 		return t1_sig1;
;Controlador5A.c,188 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_rotateMotor1:

;Controlador5A.c,189 :: 		void rotateMotor1(unsigned long long pulseWidth){  // funcao ainda nao testada
;Controlador5A.c,191 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,192 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor159
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor159
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor159
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor159:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor119
;Controlador5A.c,193 :: 		dc = (dc - 500);
	MOVLW      244
	SUBWF      rotateMotor1_dc_L0+0, 0
	MOVWF      R0
	MOVLW      1
	SUBWFB     rotateMotor1_dc_L0+1, 0
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
;Controlador5A.c,194 :: 		dc = dc*255/500;
	MOVLW      255
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      244
	MOVWF      R4
	MOVLW      1
	MOVWF      R5
	CALL       _Div_16x16_U+0
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
;Controlador5A.c,195 :: 		pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,196 :: 		set_duty_cycle(1,dc);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,197 :: 		}
L_rotateMotor119:
;Controlador5A.c,198 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor160
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor160
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor160
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor160:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor120
;Controlador5A.c,199 :: 		dc = (500 - dc);
	MOVF       rotateMotor1_dc_L0+0, 0
	SUBLW      244
	MOVWF      R0
	MOVF       rotateMotor1_dc_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBLW      1
	MOVWF      R1
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
;Controlador5A.c,200 :: 		dc = dc*255/500;
	MOVLW      255
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16x16_U+0
	MOVLW      244
	MOVWF      R4
	MOVLW      1
	MOVWF      R5
	CALL       _Div_16x16_U+0
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
;Controlador5A.c,201 :: 		pwm_steering(1,2);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,202 :: 		set_duty_cycle(1,dc);                    //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,203 :: 		}
L_rotateMotor120:
;Controlador5A.c,205 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,211 :: 		void interrupt()
;Controlador5A.c,213 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt21
;Controlador5A.c,215 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,216 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,217 :: 		}
L_interrupt21:
;Controlador5A.c,219 :: 		if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt24
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt24
L__interrupt37:
;Controlador5A.c,221 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,222 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,223 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,224 :: 		t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,225 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,226 :: 		} //end if
	GOTO       L_interrupt25
L_interrupt24:
;Controlador5A.c,227 :: 		else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt26
;Controlador5A.c,229 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,230 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,231 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,232 :: 		t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t2_sig1+0
	MOVF       R1, 0
	MOVWF      _t2_sig1+1
	MOVF       R2, 0
	MOVWF      _t2_sig1+2
	MOVF       R3, 0
	MOVWF      _t2_sig1+3
	MOVF       _t1_sig1+0, 0
	SUBWF      _t2_sig1+0, 1
	MOVF       _t1_sig1+1, 0
	SUBWFB     _t2_sig1+1, 1
	MOVF       _t1_sig1+2, 0
	SUBWFB     _t2_sig1+2, 1
	MOVF       _t1_sig1+3, 0
	SUBWFB     _t2_sig1+3, 1
;Controlador5A.c,233 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,234 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,235 :: 		} //end else
L_interrupt26:
L_interrupt25:
;Controlador5A.c,237 :: 		if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt29
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt29
L__interrupt36:
;Controlador5A.c,239 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,240 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,241 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,242 :: 		t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
;Controlador5A.c,243 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,244 :: 		} //end if
	GOTO       L_interrupt30
L_interrupt29:
;Controlador5A.c,245 :: 		else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt31
;Controlador5A.c,247 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,248 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,249 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,250 :: 		t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t2_sig2+0
	MOVF       R1, 0
	MOVWF      _t2_sig2+1
	MOVF       R2, 0
	MOVWF      _t2_sig2+2
	MOVF       R3, 0
	MOVWF      _t2_sig2+3
	MOVF       _t1_sig2+0, 0
	SUBWF      _t2_sig2+0, 1
	MOVF       _t1_sig2+1, 0
	SUBWFB     _t2_sig2+1, 1
	MOVF       _t1_sig2+2, 0
	SUBWFB     _t2_sig2+2, 1
	MOVF       _t1_sig2+3, 0
	SUBWFB     _t2_sig2+3, 1
;Controlador5A.c,251 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,252 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,253 :: 		} //end else  */
L_interrupt31:
L_interrupt30:
;Controlador5A.c,254 :: 		} //end interrupt
L_end_interrupt:
L__interrupt62:
	RETFIE     %s
; end of _interrupt

_main:

;Controlador5A.c,257 :: 		void main() {
;Controlador5A.c,258 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz. NAO APAGAR ESSA LINHA (talvez muda-la pra dentro do setup_port)
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,259 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,260 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,261 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,263 :: 		pwm_steering(1,1);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,264 :: 		pwm_steering(2,1);
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,265 :: 		set_duty_cycle(1, 127);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      127
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,266 :: 		set_duty_cycle(2, 255);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      255
	MOVWF      FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,267 :: 		while(1){
L_main32:
;Controlador5A.c,268 :: 		char *txt = "mikroe \n";
;Controlador5A.c,274 :: 		set_duty_cycle(2,0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,275 :: 		pwm_steering(2,1);
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,276 :: 		set_duty_cycle(2, 255);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      255
	MOVWF      FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,277 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11
	MOVLW      113
	MOVWF      R12
	MOVLW      30
	MOVWF      R13
L_main34:
	DECFSZ     R13, 1
	GOTO       L_main34
	DECFSZ     R12, 1
	GOTO       L_main34
	DECFSZ     R11, 1
	GOTO       L_main34
	NOP
;Controlador5A.c,279 :: 		set_duty_cycle(2,0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,280 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,281 :: 		set_duty_cycle(2, 255);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      255
	MOVWF      FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,282 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11
	MOVLW      113
	MOVWF      R12
	MOVLW      30
	MOVWF      R13
L_main35:
	DECFSZ     R13, 1
	GOTO       L_main35
	DECFSZ     R12, 1
	GOTO       L_main35
	DECFSZ     R11, 1
	GOTO       L_main35
	NOP
;Controlador5A.c,311 :: 		}
	GOTO       L_main32
;Controlador5A.c,312 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
