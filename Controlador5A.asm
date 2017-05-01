
_setup_pwms:

;Controlador5A.c,20 :: 		void setup_pwms(){
;Controlador5A.c,21 :: 		T2CON = 0;   //desliga o Timer2, timer responsavel pelos PWMS
	CLRF       T2CON+0
;Controlador5A.c,22 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;Controlador5A.c,25 :: 		CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 1
;Controlador5A.c,26 :: 		CCPTMRS.B0 = 0;
	BCF        CCPTMRS+0, 0
;Controlador5A.c,29 :: 		PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 0
;Controlador5A.c,30 :: 		PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 1
;Controlador5A.c,31 :: 		PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR1CON+0, 2
;Controlador5A.c,32 :: 		PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR1CON+0, 3
;Controlador5A.c,33 :: 		PSTR1CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR1CON+0, 4
;Controlador5A.c,34 :: 		CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR1L+0
;Controlador5A.c,35 :: 		CCP1CON = 0b00111100; //see below:
	MOVLW      60
	MOVWF      CCP1CON+0
;Controlador5A.c,49 :: 		CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 3
;Controlador5A.c,50 :: 		CCPTMRS.B2 = 0;
	BCF        CCPTMRS+0, 2
;Controlador5A.c,53 :: 		PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 0
;Controlador5A.c,54 :: 		PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 1
;Controlador5A.c,55 :: 		PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR2CON+0, 2
;Controlador5A.c,56 :: 		PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR2CON+0, 3
;Controlador5A.c,57 :: 		PSTR2CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR2CON+0, 4
;Controlador5A.c,58 :: 		CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR2L+0
;Controlador5A.c,59 :: 		CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
	MOVLW      60
	MOVWF      CCP2CON+0
;Controlador5A.c,60 :: 		T2CON = 0b00000100;  //pre scaler =  1
	MOVLW      4
	MOVWF      T2CON+0
;Controlador5A.c,65 :: 		}
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_set_duty_cycle:

;Controlador5A.c,67 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
;Controlador5A.c,68 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle38
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle38:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;Controlador5A.c,69 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;Controlador5A.c,70 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle39
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle39:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;Controlador5A.c,71 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;Controlador5A.c,72 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;Controlador5A.c,73 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;Controlador5A.c,74 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering41
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering41:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;Controlador5A.c,75 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;Controlador5A.c,76 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;Controlador5A.c,77 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering42
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering42:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;Controlador5A.c,78 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;Controlador5A.c,79 :: 		}
L_pwm_steering3:
;Controlador5A.c,80 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering43
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering43:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;Controlador5A.c,81 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;Controlador5A.c,82 :: 		}
L_pwm_steering4:
;Controlador5A.c,83 :: 		}//channel1 if
L_pwm_steering2:
;Controlador5A.c,84 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering44
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering44:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;Controlador5A.c,85 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;Controlador5A.c,86 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;Controlador5A.c,87 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering45
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering45:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;Controlador5A.c,88 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;Controlador5A.c,89 :: 		}
L_pwm_steering6:
;Controlador5A.c,90 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering46
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering46:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;Controlador5A.c,91 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;Controlador5A.c,92 :: 		}
L_pwm_steering7:
;Controlador5A.c,93 :: 		}//channel2 if
L_pwm_steering5:
;Controlador5A.c,95 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_setup_Timer_1:

;Controlador5A.c,98 :: 		void setup_Timer_1(){
;Controlador5A.c,100 :: 		T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
	BCF        T1CKPS1_bit+0, 5
;Controlador5A.c,101 :: 		T1CKPS0_bit = 0x01;                        //
	BSF        T1CKPS0_bit+0, 4
;Controlador5A.c,102 :: 		TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS1_bit+0, 7
;Controlador5A.c,103 :: 		TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS0_bit+0, 6
;Controlador5A.c,104 :: 		TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,105 :: 		TMR1IE_bit  = 0x01;                        //Habilita interrupcoes de TMR1
	BSF        TMR1IE_bit+0, 0
;Controlador5A.c,106 :: 		TMR1L       = 0x00;                        //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,107 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,111 :: 		}
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_micros:

;Controlador5A.c,112 :: 		unsigned long long micros(){
;Controlador5A.c,113 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
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
;Controlador5A.c,114 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,115 :: 		}
L_end_micros:
	RETURN
; end of _micros

_setup_port:

;Controlador5A.c,116 :: 		void setup_port(){
;Controlador5A.c,118 :: 		CM1CON0       = 0;
	CLRF       CM1CON0+0
;Controlador5A.c,119 :: 		CM2CON0       = 0;
	CLRF       CM2CON0+0
;Controlador5A.c,122 :: 		RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
	BSF        RXDTSEL_bit+0, 7
;Controlador5A.c,123 :: 		TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
	BSF        TXCKSEL_bit+0, 2
;Controlador5A.c,124 :: 		UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Controlador5A.c,125 :: 		Delay_ms(100);       //Wait for UART module to stabilize
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
;Controlador5A.c,128 :: 		P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
	BSF        P2BSEL_bit+0, 1
;Controlador5A.c,129 :: 		CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
	BSF        CCP2SEL_bit+0, 0
;Controlador5A.c,135 :: 		TRISA2_bit = 1; //RADIO INPUT1(CCP3)
	BSF        TRISA2_bit+0, 2
;Controlador5A.c,136 :: 		TRISA3_bit = 1; //MLCR
	BSF        TRISA3_bit+0, 3
;Controlador5A.c,137 :: 		TRISA4_bit = 0; //PWM OUTPUT(P2B)
	BCF        TRISA4_bit+0, 4
;Controlador5A.c,138 :: 		TRISA5_bit = 0; //PWM OUTPUT(P2A)
	BCF        TRISA5_bit+0, 5
;Controlador5A.c,139 :: 		ANSELA     = 0; //Nenhuma porta analogica
	CLRF       ANSELA+0
;Controlador5A.c,142 :: 		TRISC0_bit = 1; //AN4 (LOW BATTERY)
	BSF        TRISC0_bit+0, 0
;Controlador5A.c,143 :: 		TRISC1_bit = 1; //RADIO INPUT2(CCP4)
	BSF        TRISC1_bit+0, 1
;Controlador5A.c,144 :: 		TRISC2_bit = 1; //ERROR FLAG2
	BSF        TRISC2_bit+0, 2
;Controlador5A.c,145 :: 		TRISC3_bit = 1; //ERROR FLAG1
	BSF        TRISC3_bit+0, 3
;Controlador5A.c,146 :: 		TRISC4_bit = 0; //PWM OUTPUT(P1B)
	BCF        TRISC4_bit+0, 4
;Controlador5A.c,147 :: 		TRISC5_bit = 0; //PWM OUTPUT(P1A)
	BCF        TRISC5_bit+0, 5
;Controlador5A.c,148 :: 		ANSELC  = 0x01; //RC0 analogico, ultimo bit do ANSELC.
	MOVLW      1
	MOVWF      ANSELC+0
;Controlador5A.c,151 :: 		GIE_bit    = 0X01;   //Habilita a interrupcao Global
	BSF        GIE_bit+0, 7
;Controlador5A.c,152 :: 		PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
	BSF        PEIE_bit+0, 6
;Controlador5A.c,153 :: 		CCP3IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP3(RADIO INPUT1)
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,154 :: 		CCP4IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP4(RADIO INPUT2)
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,155 :: 		CCP3CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,156 :: 		CCP4CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,159 :: 		}
L_end_setup_port:
	RETURN
; end of _setup_port

_PulseIn1:

;Controlador5A.c,160 :: 		unsigned long long PulseIn1(){
;Controlador5A.c,162 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,163 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn19:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn110
;Controlador5A.c,164 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn151
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn151
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn151
	MOVF       R4, 0
	SUBLW      128
L__PulseIn151:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn111
;Controlador5A.c,165 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn111:
;Controlador5A.c,166 :: 		}
	GOTO       L_PulseIn19
L_PulseIn110:
;Controlador5A.c,167 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn112:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn113
;Controlador5A.c,168 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn152
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn152
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn152
	MOVF       R4, 0
	SUBLW      128
L__PulseIn152:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn114
;Controlador5A.c,169 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn114:
;Controlador5A.c,170 :: 		}
	GOTO       L_PulseIn112
L_PulseIn113:
;Controlador5A.c,171 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,172 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn115:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn116
;Controlador5A.c,173 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
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
	GOTO       L__PulseIn153
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn153
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn153
	MOVF       R4, 0
	SUBLW      128
L__PulseIn153:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn117
;Controlador5A.c,174 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn117:
;Controlador5A.c,175 :: 		}
	GOTO       L_PulseIn115
L_PulseIn116:
;Controlador5A.c,176 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
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
;Controlador5A.c,178 :: 		return t1_sig1;
;Controlador5A.c,179 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_rotateMotor1:

;Controlador5A.c,180 :: 		void rotateMotor1(unsigned long long pulseWidth){
;Controlador5A.c,182 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,183 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor155
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor155
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor155
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor155:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor118
;Controlador5A.c,184 :: 		dc = (dc - 500);
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
;Controlador5A.c,185 :: 		dc = dc*255/500;
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
;Controlador5A.c,186 :: 		pwm_steering(1,1);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,187 :: 		set_duty_cycle(1,dc);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,188 :: 		}
L_rotateMotor118:
;Controlador5A.c,189 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor156
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor156
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor156
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor156:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor119
;Controlador5A.c,190 :: 		dc = (500 - dc);
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
;Controlador5A.c,191 :: 		dc = dc*255/500;
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
;Controlador5A.c,192 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,193 :: 		set_duty_cycle(1,dc);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,194 :: 		}
L_rotateMotor119:
;Controlador5A.c,196 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,198 :: 		void interrupt()
;Controlador5A.c,200 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt20
;Controlador5A.c,202 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,203 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,204 :: 		}
L_interrupt20:
;Controlador5A.c,206 :: 		if(CCP3IF_bit && CCP3CON.B0)             //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt23
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt23
L__interrupt35:
;Controlador5A.c,208 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,209 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,210 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,211 :: 		t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,212 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,213 :: 		} //end if
	GOTO       L_interrupt24
L_interrupt23:
;Controlador5A.c,214 :: 		else if(CCP3IF_bit)                      //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt25
;Controlador5A.c,216 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,217 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,218 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,219 :: 		t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,220 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,221 :: 		} //end else
L_interrupt25:
L_interrupt24:
;Controlador5A.c,223 :: 		if(CCP4IF_bit && CCP4CON.B0)        //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt28
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt28
L__interrupt34:
;Controlador5A.c,225 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,226 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,227 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,228 :: 		t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
;Controlador5A.c,229 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,230 :: 		} //end if
	GOTO       L_interrupt29
L_interrupt28:
;Controlador5A.c,231 :: 		else if(CCP4IF_bit)                      //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt30
;Controlador5A.c,233 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,234 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,235 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,236 :: 		t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,237 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,238 :: 		} //end else  */
L_interrupt30:
L_interrupt29:
;Controlador5A.c,239 :: 		} //end interrupt
L_end_interrupt:
L__interrupt58:
	RETFIE     %s
; end of _interrupt

_main:

;Controlador5A.c,242 :: 		void main() {
;Controlador5A.c,243 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,244 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,245 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,246 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,249 :: 		while(1){
L_main31:
;Controlador5A.c,250 :: 		char *txt = "mikroe \n";
;Controlador5A.c,262 :: 		UART1_write_text("Sinal 1: ");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,263 :: 		LongWordToStr(t2_sig1, buffer);
	MOVF       _t2_sig1+0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       _t2_sig1+1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       _t2_sig1+2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       _t2_sig1+3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_LongWordToStr_output+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_LongWordToStr_output+1
	CALL       _LongWordToStr+0
;Controlador5A.c,264 :: 		UART1_write_text(buffer);
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,265 :: 		UART1_write_text("\t");
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,267 :: 		UART1_write_text("Sinal 2: ");
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,268 :: 		LongWordToStr(t2_sig2, buffer);
	MOVF       _t2_sig2+0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       _t2_sig2+1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       _t2_sig2+2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       _t2_sig2+3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_LongWordToStr_output+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_LongWordToStr_output+1
	CALL       _LongWordToStr+0
;Controlador5A.c,269 :: 		UART1_write_text(buffer);
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,270 :: 		UART1_write_text("\n");
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,271 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_main33:
	DECFSZ     R13, 1
	GOTO       L_main33
	DECFSZ     R12, 1
	GOTO       L_main33
	NOP
;Controlador5A.c,272 :: 		}
	GOTO       L_main31
;Controlador5A.c,273 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
