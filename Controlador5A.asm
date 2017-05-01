
_setup_pwms:

;Controlador5A.c,18 :: 		void setup_pwms(){
;Controlador5A.c,19 :: 		T2CON = 0;
	CLRF       T2CON+0
;Controlador5A.c,20 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;Controlador5A.c,23 :: 		CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 1
;Controlador5A.c,24 :: 		CCPTMRS.B0 = 0;
	BCF        CCPTMRS+0, 0
;Controlador5A.c,27 :: 		PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 0
;Controlador5A.c,28 :: 		PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 1
;Controlador5A.c,29 :: 		PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR1CON+0, 2
;Controlador5A.c,30 :: 		PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR1CON+0, 3
;Controlador5A.c,31 :: 		PSTR1CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR1CON+0, 4
;Controlador5A.c,32 :: 		CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR1L+0
;Controlador5A.c,33 :: 		CCP1CON = 0b00111100; //see below:
	MOVLW      60
	MOVWF      CCP1CON+0
;Controlador5A.c,47 :: 		CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 3
;Controlador5A.c,48 :: 		CCPTMRS.B2 = 0;
	BCF        CCPTMRS+0, 2
;Controlador5A.c,51 :: 		PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 0
;Controlador5A.c,52 :: 		PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 1
;Controlador5A.c,53 :: 		PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR2CON+0, 2
;Controlador5A.c,54 :: 		PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR2CON+0, 3
;Controlador5A.c,55 :: 		PSTR2CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR2CON+0, 4
;Controlador5A.c,56 :: 		CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR2L+0
;Controlador5A.c,57 :: 		CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
	MOVLW      60
	MOVWF      CCP2CON+0
;Controlador5A.c,58 :: 		T2CON = 0b00000100;  //pre scaler =  1
	MOVLW      4
	MOVWF      T2CON+0
;Controlador5A.c,63 :: 		}
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_set_duty_cycle:

;Controlador5A.c,65 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){
;Controlador5A.c,66 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle26
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle26:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;Controlador5A.c,67 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;Controlador5A.c,68 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle27
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle27:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;Controlador5A.c,69 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;Controlador5A.c,70 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;Controlador5A.c,71 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;Controlador5A.c,72 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering29
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering29:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;Controlador5A.c,73 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;Controlador5A.c,74 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;Controlador5A.c,75 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering30
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering30:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;Controlador5A.c,76 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;Controlador5A.c,77 :: 		}
L_pwm_steering3:
;Controlador5A.c,78 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering31
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering31:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;Controlador5A.c,79 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;Controlador5A.c,80 :: 		}
L_pwm_steering4:
;Controlador5A.c,81 :: 		}//channel1 if
L_pwm_steering2:
;Controlador5A.c,82 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering32
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering32:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;Controlador5A.c,83 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;Controlador5A.c,84 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;Controlador5A.c,85 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering33
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering33:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;Controlador5A.c,86 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;Controlador5A.c,87 :: 		}
L_pwm_steering6:
;Controlador5A.c,88 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering34
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering34:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;Controlador5A.c,89 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;Controlador5A.c,90 :: 		}
L_pwm_steering7:
;Controlador5A.c,91 :: 		}//channel2 if
L_pwm_steering5:
;Controlador5A.c,93 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_setup_Timer_1:

;Controlador5A.c,96 :: 		void setup_Timer_1(){
;Controlador5A.c,98 :: 		T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
	BCF        T1CKPS1_bit+0, 5
;Controlador5A.c,99 :: 		T1CKPS0_bit = 0x01;                        //
	BSF        T1CKPS0_bit+0, 4
;Controlador5A.c,100 :: 		TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS1_bit+0, 7
;Controlador5A.c,101 :: 		TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS0_bit+0, 6
;Controlador5A.c,102 :: 		TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,103 :: 		TMR1IE_bit  = 0x01;                        //Habilita interrupcoes de TMR1
	BSF        TMR1IE_bit+0, 0
;Controlador5A.c,104 :: 		TMR1L       = 0x00;                        //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,105 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,109 :: 		}
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_micros:

;Controlador5A.c,110 :: 		unsigned long long micros(){
;Controlador5A.c,111 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 0.5us
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
;Controlador5A.c,112 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,113 :: 		}
L_end_micros:
	RETURN
; end of _micros

_setup_port:

;Controlador5A.c,114 :: 		void setup_port(){
;Controlador5A.c,116 :: 		CM1CON0       = 0;
	CLRF       CM1CON0+0
;Controlador5A.c,117 :: 		CM2CON0       = 0;
	CLRF       CM2CON0+0
;Controlador5A.c,120 :: 		RXDTSEL_bit = 1;       //RXDTSEL: RX/DT function is on RA1
	BSF        RXDTSEL_bit+0, 7
;Controlador5A.c,121 :: 		TXCKSEL_bit = 1;       //TXDTSEL: TX/CK function is on RA0
	BSF        TXCKSEL_bit+0, 2
;Controlador5A.c,122 :: 		UART1_Init(9600);    // Initialize UART module at 9600 bps      153600 = 9600*16
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Controlador5A.c,123 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
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
;Controlador5A.c,126 :: 		P2BSEL_bit =  1;   //P2BSEL: 1 = P2B function is on RA4
	BSF        P2BSEL_bit+0, 1
;Controlador5A.c,127 :: 		CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
	BSF        CCP2SEL_bit+0, 0
;Controlador5A.c,133 :: 		TRISA2_bit = 1; //RADIO INPUT1(CCP3)
	BSF        TRISA2_bit+0, 2
;Controlador5A.c,134 :: 		TRISA3_bit = 1; //MLCR
	BSF        TRISA3_bit+0, 3
;Controlador5A.c,135 :: 		TRISA4_bit = 0; //PWM OUTPUT(P2B)
	BCF        TRISA4_bit+0, 4
;Controlador5A.c,136 :: 		TRISA5_bit = 0; //PWM OUTPUT(P2A)
	BCF        TRISA5_bit+0, 5
;Controlador5A.c,137 :: 		ANSELA     = 0; //Nenhuma porta analogica
	CLRF       ANSELA+0
;Controlador5A.c,140 :: 		TRISC0_bit = 1; //AN4 (LOW BATTERY)
	BSF        TRISC0_bit+0, 0
;Controlador5A.c,141 :: 		TRISC1_bit = 1; //RADIO INPUT2(CCP4)
	BSF        TRISC1_bit+0, 1
;Controlador5A.c,142 :: 		TRISC2_bit = 1; //ERROR FLAG2
	BSF        TRISC2_bit+0, 2
;Controlador5A.c,143 :: 		TRISC3_bit = 1; //ERROR FLAG1
	BSF        TRISC3_bit+0, 3
;Controlador5A.c,144 :: 		TRISC4_bit = 0; //PWM OUTPUT(P1B)
	BCF        TRISC4_bit+0, 4
;Controlador5A.c,145 :: 		TRISC5_bit = 0; //PWM OUTPUT(P1A)
	BCF        TRISC5_bit+0, 5
;Controlador5A.c,146 :: 		ANSELC  = 0x01; //RC0 analogico, ultimo bit do ANSELC.
	MOVLW      1
	MOVWF      ANSELC+0
;Controlador5A.c,150 :: 		}
L_end_setup_port:
	RETURN
; end of _setup_port

_PulseIn1:

;Controlador5A.c,151 :: 		unsigned long long PulseIn1(){
;Controlador5A.c,153 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,154 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn19:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn110
;Controlador5A.c,155 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn139
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn139
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn139
	MOVF       R4, 0
	SUBLW      128
L__PulseIn139:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn111
;Controlador5A.c,156 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn111:
;Controlador5A.c,157 :: 		}
	GOTO       L_PulseIn19
L_PulseIn110:
;Controlador5A.c,158 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,159 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn112:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn113
;Controlador5A.c,160 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn140
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn140
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn140
	MOVF       R4, 0
	SUBLW      128
L__PulseIn140:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn114
;Controlador5A.c,161 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn114:
;Controlador5A.c,162 :: 		}
	GOTO       L_PulseIn112
L_PulseIn113:
;Controlador5A.c,163 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,164 :: 		flag = t1_sig1;
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,165 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn115:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn116
;Controlador5A.c,166 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
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
	GOTO       L__PulseIn141
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn141
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn141
	MOVF       R4, 0
	SUBLW      128
L__PulseIn141:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn117
;Controlador5A.c,167 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn117:
;Controlador5A.c,168 :: 		}
	GOTO       L_PulseIn115
L_PulseIn116:
;Controlador5A.c,169 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
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
;Controlador5A.c,171 :: 		return t1_sig1;
;Controlador5A.c,172 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_rotateMotor1:

;Controlador5A.c,173 :: 		void rotateMotor1(unsigned long long pulseWidth){
;Controlador5A.c,175 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,176 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor143
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor143
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor143
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor143:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor118
;Controlador5A.c,177 :: 		dc = (dc - 500);
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
;Controlador5A.c,178 :: 		dc = dc*255/500;
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
;Controlador5A.c,179 :: 		pwm_steering(1,1);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,180 :: 		set_duty_cycle(1,dc);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,181 :: 		}
L_rotateMotor118:
;Controlador5A.c,182 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor144
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor144
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor144
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor144:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor119
;Controlador5A.c,183 :: 		dc = (500 - dc);
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
;Controlador5A.c,184 :: 		dc = dc*255/500;
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
;Controlador5A.c,185 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,186 :: 		set_duty_cycle(1,dc);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,187 :: 		}
L_rotateMotor119:
;Controlador5A.c,189 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,191 :: 		void interrupt()
;Controlador5A.c,193 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt20
;Controlador5A.c,195 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,196 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,197 :: 		}
L_interrupt20:
;Controlador5A.c,198 :: 		} //end interrupt
L_end_interrupt:
L__interrupt46:
	RETFIE     %s
; end of _interrupt

_main:

;Controlador5A.c,201 :: 		void main() {
;Controlador5A.c,202 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,203 :: 		GIE_bit    = 0X01;   //Habilita a interrupcao Global
	BSF        GIE_bit+0, 7
;Controlador5A.c,204 :: 		PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
	BSF        PEIE_bit+0, 6
;Controlador5A.c,205 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,206 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,207 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,210 :: 		while(1){
L_main21:
;Controlador5A.c,211 :: 		char *txt = "mikroe \n";
;Controlador5A.c,217 :: 		t = pulseIn1();
	CALL       _PulseIn1+0
;Controlador5A.c,223 :: 		LongWordToStr(t, buffer);
	MOVF       R0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       R1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       R2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       R3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_LongWordToStr_output+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_LongWordToStr_output+1
	CALL       _LongWordToStr+0
;Controlador5A.c,225 :: 		UART1_write_text(buffer);
	MOVLW      main_buffer_L1+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(main_buffer_L1+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,226 :: 		UART1_write_text("\n");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,227 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_main23:
	DECFSZ     R13, 1
	GOTO       L_main23
	DECFSZ     R12, 1
	GOTO       L_main23
	NOP
;Controlador5A.c,228 :: 		}
	GOTO       L_main21
;Controlador5A.c,229 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
