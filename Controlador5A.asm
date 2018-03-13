
_set_duty_cycle:

;Controlador5A.c,14 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
;Controlador5A.c,15 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle81
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle81:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;Controlador5A.c,16 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;Controlador5A.c,17 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle82
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle82:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;Controlador5A.c,18 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;Controlador5A.c,19 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;Controlador5A.c,20 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;Controlador5A.c,21 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering84
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering84:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;Controlador5A.c,22 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;Controlador5A.c,23 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;Controlador5A.c,24 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering85
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering85:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;Controlador5A.c,25 :: 		P1B = 0;         //port pin stays at low
	BCF        RC4_bit+0, 4
;Controlador5A.c,26 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;Controlador5A.c,27 :: 		}
L_pwm_steering3:
;Controlador5A.c,28 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering86
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering86:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;Controlador5A.c,29 :: 		P1A = 0;         //port pin stays at low
	BCF        RC5_bit+0, 5
;Controlador5A.c,30 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;Controlador5A.c,31 :: 		}
L_pwm_steering4:
;Controlador5A.c,32 :: 		}//channel1 if
L_pwm_steering2:
;Controlador5A.c,33 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering87
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering87:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;Controlador5A.c,34 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;Controlador5A.c,35 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;Controlador5A.c,36 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering88
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering88:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;Controlador5A.c,37 :: 		P2B = 0;         //port pin stays at low
	BCF        RA4_bit+0, 4
;Controlador5A.c,38 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;Controlador5A.c,39 :: 		}
L_pwm_steering6:
;Controlador5A.c,40 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering89
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering89:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;Controlador5A.c,41 :: 		P2A = 0;         //port pin stays at low
	BCF        RA5_bit+0, 5
;Controlador5A.c,42 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;Controlador5A.c,43 :: 		}
L_pwm_steering7:
;Controlador5A.c,44 :: 		}//channel2 if
L_pwm_steering5:
;Controlador5A.c,46 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_micros:

;Controlador5A.c,49 :: 		unsigned long long micros(){
;Controlador5A.c,50 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
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
;Controlador5A.c,51 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,52 :: 		}
L_end_micros:
	RETURN
; end of _micros

_failSafeCheck:

;Controlador5A.c,54 :: 		unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
;Controlador5A.c,55 :: 		if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
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
	GOTO       L__failSafeCheck92
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck92
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck92
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck92:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck8
;Controlador5A.c,56 :: 		return 1;
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck8:
;Controlador5A.c,57 :: 		return 0;
	CLRF       R0
	CLRF       R1
;Controlador5A.c,58 :: 		}
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_PulseIn1:

;Controlador5A.c,60 :: 		unsigned long long PulseIn1(){  //funcao que calculava, via software, o pulso recebido
;Controlador5A.c,62 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,63 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn19:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn110
;Controlador5A.c,64 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn194
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn194
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn194
	MOVF       R4, 0
	SUBLW      128
L__PulseIn194:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn111
;Controlador5A.c,65 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn111:
;Controlador5A.c,66 :: 		}
	GOTO       L_PulseIn19
L_PulseIn110:
;Controlador5A.c,67 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn112:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn113
;Controlador5A.c,68 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn195
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn195
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn195
	MOVF       R4, 0
	SUBLW      128
L__PulseIn195:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn114
;Controlador5A.c,69 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn114:
;Controlador5A.c,70 :: 		}
	GOTO       L_PulseIn112
L_PulseIn113:
;Controlador5A.c,71 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,72 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn115:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn116
;Controlador5A.c,73 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
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
	GOTO       L__PulseIn196
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn196
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn196
	MOVF       R4, 0
	SUBLW      128
L__PulseIn196:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn117
;Controlador5A.c,74 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn117:
;Controlador5A.c,75 :: 		}
	GOTO       L_PulseIn115
L_PulseIn116:
;Controlador5A.c,76 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
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
;Controlador5A.c,78 :: 		return t1_sig1;
;Controlador5A.c,79 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_map:

;Controlador5A.c,82 :: 		long map(long x, long in_min, long in_max, long out_min, long out_max)
;Controlador5A.c,84 :: 		return ((x - in_min) * (out_max - out_min) / (in_max - in_min)) + out_min;
	MOVF       FARG_map_x+0, 0
	MOVWF      R4
	MOVF       FARG_map_x+1, 0
	MOVWF      R5
	MOVF       FARG_map_x+2, 0
	MOVWF      R6
	MOVF       FARG_map_x+3, 0
	MOVWF      R7
	MOVF       FARG_map_in_min+0, 0
	SUBWF      R4, 1
	MOVF       FARG_map_in_min+1, 0
	SUBWFB     R5, 1
	MOVF       FARG_map_in_min+2, 0
	SUBWFB     R6, 1
	MOVF       FARG_map_in_min+3, 0
	SUBWFB     R7, 1
	MOVF       FARG_map_out_max+0, 0
	MOVWF      R0
	MOVF       FARG_map_out_max+1, 0
	MOVWF      R1
	MOVF       FARG_map_out_max+2, 0
	MOVWF      R2
	MOVF       FARG_map_out_max+3, 0
	MOVWF      R3
	MOVF       FARG_map_out_min+0, 0
	SUBWF      R0, 1
	MOVF       FARG_map_out_min+1, 0
	SUBWFB     R1, 1
	MOVF       FARG_map_out_min+2, 0
	SUBWFB     R2, 1
	MOVF       FARG_map_out_min+3, 0
	SUBWFB     R3, 1
	CALL       _Mul_32x32_U+0
	MOVF       FARG_map_in_max+0, 0
	MOVWF      R4
	MOVF       FARG_map_in_max+1, 0
	MOVWF      R5
	MOVF       FARG_map_in_max+2, 0
	MOVWF      R6
	MOVF       FARG_map_in_max+3, 0
	MOVWF      R7
	MOVF       FARG_map_in_min+0, 0
	SUBWF      R4, 1
	MOVF       FARG_map_in_min+1, 0
	SUBWFB     R5, 1
	MOVF       FARG_map_in_min+2, 0
	SUBWFB     R6, 1
	MOVF       FARG_map_in_min+3, 0
	SUBWFB     R7, 1
	CALL       _Div_32x32_S+0
	MOVF       FARG_map_out_min+0, 0
	ADDWF      R0, 1
	MOVF       FARG_map_out_min+1, 0
	ADDWFC     R1, 1
	MOVF       FARG_map_out_min+2, 0
	ADDWFC     R2, 1
	MOVF       FARG_map_out_min+3, 0
	ADDWFC     R3, 1
;Controlador5A.c,85 :: 		}
L_end_map:
	RETURN
; end of _map

_rotateMotor:

;Controlador5A.c,86 :: 		void rotateMotor(){
;Controlador5A.c,91 :: 		pulseWidth1 = t2_sig1;   //lê o pulso do canal 1
	MOVF       _t2_sig1+0, 0
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      rotateMotor_pulseWidth1_L0+1
;Controlador5A.c,92 :: 		pulseWidth2 = t2_sig2;   //lê o pulso do canal 2
	MOVF       _t2_sig2+0, 0
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      rotateMotor_pulseWidth2_L0+1
;Controlador5A.c,95 :: 		if(pulseWidth1 < MIN_CH_DURATION)
	MOVLW      4
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor99
	MOVLW      76
	SUBWF      _t2_sig1+0, 0
L__rotateMotor99:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor18
;Controlador5A.c,96 :: 		pulseWidth1 = MIN_CH_DURATION;
	MOVLW      76
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      4
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor18:
;Controlador5A.c,97 :: 		if(pulseWidth1 > MAX_CH_DURATION)
	MOVF       rotateMotor_pulseWidth1_L0+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor100
	MOVF       rotateMotor_pulseWidth1_L0+0, 0
	SUBLW      108
L__rotateMotor100:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor19
;Controlador5A.c,98 :: 		pulseWidth1 = MAX_CH_DURATION;
	MOVLW      108
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      7
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor19:
;Controlador5A.c,100 :: 		if(pulseWidth2 < MIN_CH_DURATION)
	MOVLW      4
	SUBWF      rotateMotor_pulseWidth2_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor101
	MOVLW      76
	SUBWF      rotateMotor_pulseWidth2_L0+0, 0
L__rotateMotor101:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor20
;Controlador5A.c,101 :: 		pulseWidth2 = MIN_CH_DURATION;
	MOVLW      76
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      4
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor20:
;Controlador5A.c,102 :: 		if(pulseWidth2 > MAX_CH_DURATION)
	MOVF       rotateMotor_pulseWidth2_L0+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor102
	MOVF       rotateMotor_pulseWidth2_L0+0, 0
	SUBLW      108
L__rotateMotor102:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor21
;Controlador5A.c,103 :: 		pulseWidth2 = MAX_CH_DURATION;
	MOVLW      108
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      7
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor21:
;Controlador5A.c,106 :: 		if((pulseWidth1 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth1 > (MEAN_CH_DURATION - DEADZONE)))
	MOVLW      6
	SUBWF      rotateMotor_pulseWidth1_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor103
	MOVLW      14
	SUBWF      rotateMotor_pulseWidth1_L0+0, 0
L__rotateMotor103:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor24
	MOVF       rotateMotor_pulseWidth1_L0+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor104
	MOVF       rotateMotor_pulseWidth1_L0+0, 0
	SUBLW      170
L__rotateMotor104:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor24
L__rotateMotor77:
;Controlador5A.c,107 :: 		pulseWidth1 = MEAN_CH_DURATION;
	MOVLW      220
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      5
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor24:
;Controlador5A.c,109 :: 		if((pulseWidth2 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth2 > (MEAN_CH_DURATION - DEADZONE)))
	MOVLW      6
	SUBWF      rotateMotor_pulseWidth2_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor105
	MOVLW      14
	SUBWF      rotateMotor_pulseWidth2_L0+0, 0
L__rotateMotor105:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor27
	MOVF       rotateMotor_pulseWidth2_L0+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor106
	MOVF       rotateMotor_pulseWidth2_L0+0, 0
	SUBLW      170
L__rotateMotor106:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor27
L__rotateMotor76:
;Controlador5A.c,110 :: 		pulseWidth2 = MEAN_CH_DURATION;
	MOVLW      220
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      5
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor27:
;Controlador5A.c,113 :: 		duty_cycle1 = map(pulseWidth1,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
	MOVF       rotateMotor_pulseWidth1_L0+0, 0
	MOVWF      FARG_map_x+0
	MOVF       rotateMotor_pulseWidth1_L0+1, 0
	MOVWF      FARG_map_x+1
	CLRF       FARG_map_x+2
	CLRF       FARG_map_x+3
	MOVLW      76
	MOVWF      FARG_map_in_min+0
	MOVLW      4
	MOVWF      FARG_map_in_min+1
	CLRF       FARG_map_in_min+2
	CLRF       FARG_map_in_min+3
	MOVLW      108
	MOVWF      FARG_map_in_max+0
	MOVLW      7
	MOVWF      FARG_map_in_max+1
	CLRF       FARG_map_in_max+2
	CLRF       FARG_map_in_max+3
	MOVLW      1
	MOVWF      FARG_map_out_min+0
	MOVLW      255
	MOVWF      FARG_map_out_min+1
	MOVLW      255
	MOVWF      FARG_map_out_min+2
	MOVWF      FARG_map_out_min+3
	MOVLW      255
	MOVWF      FARG_map_out_max+0
	CLRF       FARG_map_out_max+1
	CLRF       FARG_map_out_max+2
	CLRF       FARG_map_out_max+3
	CALL       _map+0
	MOVF       R0, 0
	MOVWF      rotateMotor_duty_cycle1_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor_duty_cycle1_L0+1
;Controlador5A.c,114 :: 		duty_cycle2 = map(pulseWidth2,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
	MOVF       rotateMotor_pulseWidth2_L0+0, 0
	MOVWF      FARG_map_x+0
	MOVF       rotateMotor_pulseWidth2_L0+1, 0
	MOVWF      FARG_map_x+1
	CLRF       FARG_map_x+2
	CLRF       FARG_map_x+3
	MOVLW      76
	MOVWF      FARG_map_in_min+0
	MOVLW      4
	MOVWF      FARG_map_in_min+1
	CLRF       FARG_map_in_min+2
	CLRF       FARG_map_in_min+3
	MOVLW      108
	MOVWF      FARG_map_in_max+0
	MOVLW      7
	MOVWF      FARG_map_in_max+1
	CLRF       FARG_map_in_max+2
	CLRF       FARG_map_in_max+3
	MOVLW      1
	MOVWF      FARG_map_out_min+0
	MOVLW      255
	MOVWF      FARG_map_out_min+1
	MOVLW      255
	MOVWF      FARG_map_out_min+2
	MOVWF      FARG_map_out_min+3
	MOVLW      255
	MOVWF      FARG_map_out_max+0
	CLRF       FARG_map_out_max+1
	CLRF       FARG_map_out_max+2
	CLRF       FARG_map_out_max+3
	CALL       _map+0
	MOVF       R0, 0
	MOVWF      rotateMotor_duty_cycle2_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor_duty_cycle2_L0+1
;Controlador5A.c,116 :: 		if(duty_cycle1 >= 0){
	MOVLW      128
	XORWF      rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor107
	MOVLW      0
	SUBWF      rotateMotor_duty_cycle1_L0+0, 0
L__rotateMotor107:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor28
;Controlador5A.c,117 :: 		pwm_steering(1,2);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,118 :: 		set_duty_cycle(1,duty_cycle1);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,119 :: 		}
	GOTO       L_rotateMotor29
L_rotateMotor28:
;Controlador5A.c,121 :: 		duty_cycle1 = -duty_cycle1;
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotor_duty_cycle1_L0+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor_duty_cycle1_L0+1
	SUBWF      rotateMotor_duty_cycle1_L0+1, 1
;Controlador5A.c,122 :: 		pwm_steering(1,1);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,123 :: 		set_duty_cycle(1,duty_cycle1);            //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,124 :: 		}
L_rotateMotor29:
;Controlador5A.c,126 :: 		if(duty_cycle2 >= 0){
	MOVLW      128
	XORWF      rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor108
	MOVLW      0
	SUBWF      rotateMotor_duty_cycle2_L0+0, 0
L__rotateMotor108:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor30
;Controlador5A.c,127 :: 		pwm_steering(2,2);                        //coloca no sentido anti horario de rotacao
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,128 :: 		set_duty_cycle(2,duty_cycle2);                     //aplica o duty cycle
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,129 :: 		}
	GOTO       L_rotateMotor31
L_rotateMotor30:
;Controlador5A.c,131 :: 		duty_cycle2 = -duty_cycle2;
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotor_duty_cycle2_L0+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor_duty_cycle2_L0+1
	SUBWF      rotateMotor_duty_cycle2_L0+1, 1
;Controlador5A.c,132 :: 		pwm_steering(2,1);                       //coloca no sentido horario de rotacao
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,133 :: 		set_duty_cycle(2,duty_cycle2);            //aplica o duty cycle
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,134 :: 		}
L_rotateMotor31:
;Controlador5A.c,135 :: 		}
L_end_rotateMotor:
	RETURN
; end of _rotateMotor

_rotateMotor1:

;Controlador5A.c,137 :: 		void rotateMotor1(unsigned long long pulseWidth){  // funcao ainda nao testada
;Controlador5A.c,139 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,140 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1110
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1110
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1110
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor1110:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor132
;Controlador5A.c,141 :: 		dc = (dc - 500);
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
;Controlador5A.c,142 :: 		dc = dc*255/500;
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
;Controlador5A.c,143 :: 		pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,144 :: 		set_duty_cycle(1,dc);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,145 :: 		}
L_rotateMotor132:
;Controlador5A.c,146 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1111
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1111
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1111
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor1111:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor133
;Controlador5A.c,147 :: 		dc = (500 - dc);
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
;Controlador5A.c,148 :: 		dc = dc*255/500;
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
;Controlador5A.c,149 :: 		pwm_steering(1,2);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,150 :: 		set_duty_cycle(1,dc);                    //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,151 :: 		}
L_rotateMotor133:
;Controlador5A.c,153 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,159 :: 		void interrupt()
;Controlador5A.c,161 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt34
;Controlador5A.c,163 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,164 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,165 :: 		}
L_interrupt34:
;Controlador5A.c,167 :: 		if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt37
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt37
L__interrupt79:
;Controlador5A.c,169 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,170 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,171 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,172 :: 		t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,173 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,174 :: 		} //end if
	GOTO       L_interrupt38
L_interrupt37:
;Controlador5A.c,175 :: 		else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt39
;Controlador5A.c,177 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,178 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,179 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,180 :: 		t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,181 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,182 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,183 :: 		} //end else
L_interrupt39:
L_interrupt38:
;Controlador5A.c,185 :: 		if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt42
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt42
L__interrupt78:
;Controlador5A.c,187 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,188 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,189 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,190 :: 		t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
;Controlador5A.c,191 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,192 :: 		} //end if
	GOTO       L_interrupt43
L_interrupt42:
;Controlador5A.c,193 :: 		else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt44
;Controlador5A.c,195 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,196 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,197 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,198 :: 		t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,199 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,200 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,201 :: 		} //end else  */
L_interrupt44:
L_interrupt43:
;Controlador5A.c,202 :: 		} //end interrupt
L_end_interrupt:
L__interrupt113:
	RETFIE     %s
; end of _interrupt

_error_led_blink:

;Controlador5A.c,204 :: 		void error_led_blink(unsigned time_ms){
;Controlador5A.c,206 :: 		time_ms = time_ms/250; //4 blinks por segundo
	MOVLW      250
	MOVWF      R4
	CLRF       R5
	MOVF       FARG_error_led_blink_time_ms+0, 0
	MOVWF      R0
	MOVF       FARG_error_led_blink_time_ms+1, 0
	MOVWF      R1
	CALL       _Div_16x16_U+0
	MOVF       R0, 0
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVF       R1, 0
	MOVWF      FARG_error_led_blink_time_ms+1
;Controlador5A.c,207 :: 		for(i=0; i< time_ms; i++){
	CLRF       error_led_blink_i_L0+0
	CLRF       error_led_blink_i_L0+1
L_error_led_blink45:
	MOVF       FARG_error_led_blink_time_ms+1, 0
	SUBWF      error_led_blink_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__error_led_blink115
	MOVF       FARG_error_led_blink_time_ms+0, 0
	SUBWF      error_led_blink_i_L0+0, 0
L__error_led_blink115:
	BTFSC      STATUS+0, 0
	GOTO       L_error_led_blink46
;Controlador5A.c,208 :: 		ERROR_LED = 1;
	BSF        RA0_bit+0, 0
;Controlador5A.c,209 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink48:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink48
	DECFSZ     R12, 1
	GOTO       L_error_led_blink48
	DECFSZ     R11, 1
	GOTO       L_error_led_blink48
;Controlador5A.c,210 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,211 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink49:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink49
	DECFSZ     R12, 1
	GOTO       L_error_led_blink49
	DECFSZ     R11, 1
	GOTO       L_error_led_blink49
;Controlador5A.c,207 :: 		for(i=0; i< time_ms; i++){
	INCF       error_led_blink_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       error_led_blink_i_L0+1, 1
;Controlador5A.c,212 :: 		}
	GOTO       L_error_led_blink45
L_error_led_blink46:
;Controlador5A.c,213 :: 		}
L_end_error_led_blink:
	RETURN
; end of _error_led_blink

_calibration:

;Controlador5A.c,214 :: 		void calibration(){
;Controlador5A.c,222 :: 		signal1_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal1_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal1_L_value_L0+1
;Controlador5A.c,223 :: 		signal2_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal2_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal2_L_value_L0+1
;Controlador5A.c,224 :: 		signal1_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal1_H_value_L0+0
	CLRF       calibration_signal1_H_value_L0+1
;Controlador5A.c,225 :: 		signal2_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal2_H_value_L0+0
	CLRF       calibration_signal2_H_value_L0+1
;Controlador5A.c,226 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,227 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,229 :: 		while((micros() - time_control) < 2000000){
L_calibration50:
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       calibration_time_control_L0+0, 0
	SUBWF      R4, 1
	MOVF       calibration_time_control_L0+1, 0
	SUBWFB     R5, 1
	MOVF       calibration_time_control_L0+2, 0
	SUBWFB     R6, 1
	MOVF       calibration_time_control_L0+3, 0
	SUBWFB     R7, 1
	MOVLW      0
	SUBWF      R7, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration117
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration117
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration117
	MOVLW      128
	SUBWF      R4, 0
L__calibration117:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration51
;Controlador5A.c,230 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,231 :: 		if(signal_T_value < signal1_L_value)
	MOVF       calibration_signal1_L_value_L0+1, 0
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration118
	MOVF       calibration_signal1_L_value_L0+0, 0
	SUBWF      _t2_sig1+0, 0
L__calibration118:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration52
;Controlador5A.c,232 :: 		signal1_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_L_value_L0+1
L_calibration52:
;Controlador5A.c,234 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal2
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,235 :: 		if(signal_T_value < signal2_L_value)
	MOVF       calibration_signal2_L_value_L0+1, 0
	SUBWF      _t2_sig2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration119
	MOVF       calibration_signal2_L_value_L0+0, 0
	SUBWF      _t2_sig2+0, 0
L__calibration119:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration53
;Controlador5A.c,236 :: 		signal2_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_L_value_L0+1
L_calibration53:
;Controlador5A.c,237 :: 		}
	GOTO       L_calibration50
L_calibration51:
;Controlador5A.c,241 :: 		lower_8bits = signal1_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,242 :: 		upper_8bits = (signal1_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,243 :: 		EEPROM_Write(0X00,lower_8bits);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,244 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration54:
	DECFSZ     R13, 1
	GOTO       L_calibration54
	DECFSZ     R12, 1
	GOTO       L_calibration54
	NOP
;Controlador5A.c,245 :: 		EEPROM_Write(0X01,upper_8bits);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,246 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration55:
	DECFSZ     R13, 1
	GOTO       L_calibration55
	DECFSZ     R12, 1
	GOTO       L_calibration55
	NOP
;Controlador5A.c,249 :: 		lower_8bits = signal2_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,250 :: 		upper_8bits = (signal2_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,251 :: 		EEPROM_Write(0X02,lower_8bits);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,252 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration56:
	DECFSZ     R13, 1
	GOTO       L_calibration56
	DECFSZ     R12, 1
	GOTO       L_calibration56
	NOP
;Controlador5A.c,253 :: 		EEPROM_Write(0X03,upper_8bits);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,254 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration57:
	DECFSZ     R13, 1
	GOTO       L_calibration57
	DECFSZ     R12, 1
	GOTO       L_calibration57
	NOP
;Controlador5A.c,256 :: 		error_led_blink(1600);                      //indica a captura do valor minimo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,257 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,258 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,259 :: 		while((micros() - time_control) < 2000000){
L_calibration58:
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      R4
	MOVF       R1, 0
	MOVWF      R5
	MOVF       R2, 0
	MOVWF      R6
	MOVF       R3, 0
	MOVWF      R7
	MOVF       calibration_time_control_L0+0, 0
	SUBWF      R4, 1
	MOVF       calibration_time_control_L0+1, 0
	SUBWFB     R5, 1
	MOVF       calibration_time_control_L0+2, 0
	SUBWFB     R6, 1
	MOVF       calibration_time_control_L0+3, 0
	SUBWFB     R7, 1
	MOVLW      0
	SUBWF      R7, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration120
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration120
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration120
	MOVLW      128
	SUBWF      R4, 0
L__calibration120:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration59
;Controlador5A.c,260 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,261 :: 		if(signal_T_value > signal1_H_value)
	MOVF       _t2_sig1+1, 0
	SUBWF      calibration_signal1_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration121
	MOVF       _t2_sig1+0, 0
	SUBWF      calibration_signal1_H_value_L0+0, 0
L__calibration121:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration60
;Controlador5A.c,262 :: 		signal1_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_H_value_L0+1
L_calibration60:
;Controlador5A.c,264 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal1
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,265 :: 		if(signal_T_value > signal2_H_value)
	MOVF       _t2_sig2+1, 0
	SUBWF      calibration_signal2_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration122
	MOVF       _t2_sig2+0, 0
	SUBWF      calibration_signal2_H_value_L0+0, 0
L__calibration122:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration61
;Controlador5A.c,266 :: 		signal2_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_H_value_L0+1
L_calibration61:
;Controlador5A.c,267 :: 		}
	GOTO       L_calibration58
L_calibration59:
;Controlador5A.c,269 :: 		lower_8bits = signal1_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,270 :: 		upper_8bits = (signal1_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,271 :: 		EEPROM_Write(0X04,lower_8bits);
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,272 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration62:
	DECFSZ     R13, 1
	GOTO       L_calibration62
	DECFSZ     R12, 1
	GOTO       L_calibration62
	NOP
;Controlador5A.c,273 :: 		EEPROM_Write(0X05,upper_8bits);
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,274 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration63:
	DECFSZ     R13, 1
	GOTO       L_calibration63
	DECFSZ     R12, 1
	GOTO       L_calibration63
	NOP
;Controlador5A.c,276 :: 		lower_8bits = signal2_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,277 :: 		upper_8bits = (signal2_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,278 :: 		EEPROM_Write(0X06,lower_8bits);
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,279 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration64:
	DECFSZ     R13, 1
	GOTO       L_calibration64
	DECFSZ     R12, 1
	GOTO       L_calibration64
	NOP
;Controlador5A.c,280 :: 		EEPROM_Write(0X07,upper_8bits);
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,281 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration65:
	DECFSZ     R13, 1
	GOTO       L_calibration65
	DECFSZ     R12, 1
	GOTO       L_calibration65
	NOP
;Controlador5A.c,283 :: 		error_led_blink(1600);                      //indica a captura do valor maximo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,284 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,285 :: 		}
L_end_calibration:
	RETURN
; end of _calibration

_read_eeprom_signals_data:

;Controlador5A.c,287 :: 		void read_eeprom_signals_data(){
;Controlador5A.c,291 :: 		UART1_write_text("LOW channel1: ");
	MOVLW      ?lstr1_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,292 :: 		lower_8bits = EEPROM_Read(0X00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,293 :: 		upper_8bits = EEPROM_Read(0X01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,294 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,295 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,296 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,297 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,298 :: 		lower_8bits = EEPROM_Read(0X02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,299 :: 		upper_8bits = EEPROM_Read(0X03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,300 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,301 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,302 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,303 :: 		UART1_write_text("\t");
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,304 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data66:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data66
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data66
	NOP
;Controlador5A.c,306 :: 		UART1_write_text("HIGH channel1: ");
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,307 :: 		lower_8bits = EEPROM_Read(0X04);
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,308 :: 		upper_8bits = EEPROM_Read(0X05);
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,309 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,310 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,311 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,312 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,313 :: 		lower_8bits = EEPROM_Read(0X06);
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,314 :: 		upper_8bits = EEPROM_Read(0X07);
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,315 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,316 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,317 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,318 :: 		UART1_write_text("\n");
	MOVLW      ?lstr6_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,319 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data67:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data67
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data67
	NOP
;Controlador5A.c,320 :: 		}
L_end_read_eeprom_signals_data:
	RETURN
; end of _read_eeprom_signals_data

_print_signal_received:

;Controlador5A.c,322 :: 		void print_signal_received(){
;Controlador5A.c,325 :: 		UART1_write_text("Sinal 1: ");
	MOVLW      ?lstr7_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,326 :: 		LongWordToStr(t2_sig1, buffer);
	MOVF       _t2_sig1+0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       _t2_sig1+1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       _t2_sig1+2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       _t2_sig1+3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_LongWordToStr_output+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_LongWordToStr_output+1
	CALL       _LongWordToStr+0
;Controlador5A.c,327 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,328 :: 		UART1_write_text("\t");
	MOVLW      ?lstr8_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,330 :: 		UART1_write_text("Sinal 2: ");
	MOVLW      ?lstr9_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,331 :: 		LongWordToStr(t2_sig2, buffer);
	MOVF       _t2_sig2+0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       _t2_sig2+1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       _t2_sig2+2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       _t2_sig2+3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_LongWordToStr_output+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_LongWordToStr_output+1
	CALL       _LongWordToStr+0
;Controlador5A.c,332 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,333 :: 		UART1_write_text("\n");
	MOVLW      ?lstr10_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,335 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_print_signal_received68:
	DECFSZ     R13, 1
	GOTO       L_print_signal_received68
	DECFSZ     R12, 1
	GOTO       L_print_signal_received68
	DECFSZ     R11, 1
	GOTO       L_print_signal_received68
	NOP
;Controlador5A.c,336 :: 		}
L_end_print_signal_received:
	RETURN
; end of _print_signal_received

_main:

;Controlador5A.c,338 :: 		void main() {
;Controlador5A.c,339 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz. NAO APAGAR ESSA LINHA (talvez muda-la pra dentro do setup_port)
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,340 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,341 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,342 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,345 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,346 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,347 :: 		set_duty_cycle(1, 0);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,348 :: 		set_duty_cycle(2, 0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,349 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main69:
	DECFSZ     R13, 1
	GOTO       L_main69
	DECFSZ     R12, 1
	GOTO       L_main69
	DECFSZ     R11, 1
	GOTO       L_main69
	NOP
	NOP
;Controlador5A.c,350 :: 		t2_sig2 = 20000;
	MOVLW      32
	MOVWF      _t2_sig2+0
	MOVLW      78
	MOVWF      _t2_sig2+1
	CLRF       _t2_sig2+2
	CLRF       _t2_sig2+3
;Controlador5A.c,351 :: 		t2_sig1 = 20000;
	MOVLW      32
	MOVWF      _t2_sig1+0
	MOVLW      78
	MOVWF      _t2_sig1+1
	CLRF       _t2_sig1+2
	CLRF       _t2_sig1+3
;Controlador5A.c,353 :: 		while(1){
L_main70:
;Controlador5A.c,354 :: 		char *txt = "mikroe \n";
;Controlador5A.c,360 :: 		if(!CALIB_BUTTON){
	BTFSC      RA3_bit+0, 3
	GOTO       L_main72
;Controlador5A.c,361 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main73:
	DECFSZ     R13, 1
	GOTO       L_main73
	DECFSZ     R12, 1
	GOTO       L_main73
	DECFSZ     R11, 1
	GOTO       L_main73
	NOP
	NOP
;Controlador5A.c,362 :: 		CALIB_LED = 1;
	BSF        RA1_bit+0, 1
;Controlador5A.c,363 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,364 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main74:
	DECFSZ     R13, 1
	GOTO       L_main74
	DECFSZ     R12, 1
	GOTO       L_main74
	DECFSZ     R11, 1
	GOTO       L_main74
	NOP
	NOP
;Controlador5A.c,365 :: 		CALIB_LED = 0;
	BCF        RA1_bit+0, 1
;Controlador5A.c,366 :: 		ERROR_LED = 1;
	BSF        RA0_bit+0, 0
;Controlador5A.c,367 :: 		}
	GOTO       L_main75
L_main72:
;Controlador5A.c,369 :: 		CALIB_LED = 0;
	BCF        RA1_bit+0, 1
;Controlador5A.c,370 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,371 :: 		}
L_main75:
;Controlador5A.c,372 :: 		}
	GOTO       L_main70
;Controlador5A.c,373 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
