
_set_duty_cycle:

;motorsPWM.c,4 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
;motorsPWM.c,5 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle25
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle25:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;motorsPWM.c,6 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;motorsPWM.c,7 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle26
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle26:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;motorsPWM.c,8 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;motorsPWM.c,9 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;motorsPWM.c,10 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;motorsPWM.c,11 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering28
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering28:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;motorsPWM.c,12 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;motorsPWM.c,13 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;motorsPWM.c,14 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering29
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering29:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;motorsPWM.c,15 :: 		P1B = 0;         //port pin stays at low
	BCF        RC4_bit+0, 4
;motorsPWM.c,16 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;motorsPWM.c,17 :: 		}
L_pwm_steering3:
;motorsPWM.c,18 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering30
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering30:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;motorsPWM.c,19 :: 		P1A = 0;         //port pin stays at low
	BCF        RC5_bit+0, 5
;motorsPWM.c,20 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;motorsPWM.c,21 :: 		}
L_pwm_steering4:
;motorsPWM.c,22 :: 		}//channel1 if
L_pwm_steering2:
;motorsPWM.c,23 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering31
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering31:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;motorsPWM.c,24 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;motorsPWM.c,25 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;motorsPWM.c,26 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering32
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering32:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;motorsPWM.c,27 :: 		P2B = 0;         //port pin stays at low
	BCF        RA4_bit+0, 4
;motorsPWM.c,28 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;motorsPWM.c,29 :: 		}
L_pwm_steering6:
;motorsPWM.c,30 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering33
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering33:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;motorsPWM.c,31 :: 		P2A = 0;         //port pin stays at low
	BCF        RA5_bit+0, 5
;motorsPWM.c,32 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;motorsPWM.c,33 :: 		}
L_pwm_steering7:
;motorsPWM.c,34 :: 		}//channel2 if
L_pwm_steering5:
;motorsPWM.c,36 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_map:

;motorsPWM.c,39 :: 		long map(long x, long in_min, long in_max, long out_min, long out_max)
;motorsPWM.c,41 :: 		return (((x - in_min) * (out_max - out_min)) / (in_max - in_min)) + out_min;
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
;motorsPWM.c,42 :: 		}
L_end_map:
	RETURN
; end of _map

_rotateMotors:

;motorsPWM.c,44 :: 		void rotateMotors(unsigned int pulseWidth1,unsigned int pulseWidth2){
;motorsPWM.c,49 :: 		if(pulseWidth1 < MIN_CH_DURATION)
	MOVLW      4
	SUBWF      FARG_rotateMotors_pulseWidth1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors36
	MOVLW      76
	SUBWF      FARG_rotateMotors_pulseWidth1+0, 0
L__rotateMotors36:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors8
;motorsPWM.c,50 :: 		pulseWidth1 = MIN_CH_DURATION;
	MOVLW      76
	MOVWF      FARG_rotateMotors_pulseWidth1+0
	MOVLW      4
	MOVWF      FARG_rotateMotors_pulseWidth1+1
L_rotateMotors8:
;motorsPWM.c,51 :: 		if(pulseWidth1 > MAX_CH_DURATION)
	MOVF       FARG_rotateMotors_pulseWidth1+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors37
	MOVF       FARG_rotateMotors_pulseWidth1+0, 0
	SUBLW      108
L__rotateMotors37:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors9
;motorsPWM.c,52 :: 		pulseWidth1 = MAX_CH_DURATION;
	MOVLW      108
	MOVWF      FARG_rotateMotors_pulseWidth1+0
	MOVLW      7
	MOVWF      FARG_rotateMotors_pulseWidth1+1
L_rotateMotors9:
;motorsPWM.c,54 :: 		if(pulseWidth2 < MIN_CH_DURATION)
	MOVLW      4
	SUBWF      FARG_rotateMotors_pulseWidth2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors38
	MOVLW      76
	SUBWF      FARG_rotateMotors_pulseWidth2+0, 0
L__rotateMotors38:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors10
;motorsPWM.c,55 :: 		pulseWidth2 = MIN_CH_DURATION;
	MOVLW      76
	MOVWF      FARG_rotateMotors_pulseWidth2+0
	MOVLW      4
	MOVWF      FARG_rotateMotors_pulseWidth2+1
L_rotateMotors10:
;motorsPWM.c,56 :: 		if(pulseWidth2 > MAX_CH_DURATION)
	MOVF       FARG_rotateMotors_pulseWidth2+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors39
	MOVF       FARG_rotateMotors_pulseWidth2+0, 0
	SUBLW      108
L__rotateMotors39:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors11
;motorsPWM.c,57 :: 		pulseWidth2 = MAX_CH_DURATION;
	MOVLW      108
	MOVWF      FARG_rotateMotors_pulseWidth2+0
	MOVLW      7
	MOVWF      FARG_rotateMotors_pulseWidth2+1
L_rotateMotors11:
;motorsPWM.c,60 :: 		if((pulseWidth1 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth1 > (MEAN_CH_DURATION - DEADZONE)))
	MOVLW      6
	SUBWF      FARG_rotateMotors_pulseWidth1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors40
	MOVLW      14
	SUBWF      FARG_rotateMotors_pulseWidth1+0, 0
L__rotateMotors40:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors14
	MOVF       FARG_rotateMotors_pulseWidth1+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors41
	MOVF       FARG_rotateMotors_pulseWidth1+0, 0
	SUBLW      170
L__rotateMotors41:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors14
L__rotateMotors23:
;motorsPWM.c,61 :: 		pulseWidth1 = MEAN_CH_DURATION;
	MOVLW      220
	MOVWF      FARG_rotateMotors_pulseWidth1+0
	MOVLW      5
	MOVWF      FARG_rotateMotors_pulseWidth1+1
L_rotateMotors14:
;motorsPWM.c,63 :: 		if((pulseWidth2 < (MEAN_CH_DURATION + DEADZONE)) && (pulseWidth2 > (MEAN_CH_DURATION - DEADZONE)))
	MOVLW      6
	SUBWF      FARG_rotateMotors_pulseWidth2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors42
	MOVLW      14
	SUBWF      FARG_rotateMotors_pulseWidth2+0, 0
L__rotateMotors42:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors17
	MOVF       FARG_rotateMotors_pulseWidth2+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors43
	MOVF       FARG_rotateMotors_pulseWidth2+0, 0
	SUBLW      170
L__rotateMotors43:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotors17
L__rotateMotors22:
;motorsPWM.c,64 :: 		pulseWidth2 = MEAN_CH_DURATION;
	MOVLW      220
	MOVWF      FARG_rotateMotors_pulseWidth2+0
	MOVLW      5
	MOVWF      FARG_rotateMotors_pulseWidth2+1
L_rotateMotors17:
;motorsPWM.c,67 :: 		duty_cycle1 = map(pulseWidth1,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
	MOVF       FARG_rotateMotors_pulseWidth1+0, 0
	MOVWF      FARG_map_x+0
	MOVF       FARG_rotateMotors_pulseWidth1+1, 0
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
	MOVWF      rotateMotors_duty_cycle1_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotors_duty_cycle1_L0+1
;motorsPWM.c,68 :: 		duty_cycle2 = map(pulseWidth2,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
	MOVF       FARG_rotateMotors_pulseWidth2+0, 0
	MOVWF      FARG_map_x+0
	MOVF       FARG_rotateMotors_pulseWidth2+1, 0
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
	MOVWF      rotateMotors_duty_cycle2_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotors_duty_cycle2_L0+1
;motorsPWM.c,70 :: 		if(duty_cycle1 >= 0){
	MOVLW      128
	XORWF      rotateMotors_duty_cycle1_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors44
	MOVLW      0
	SUBWF      rotateMotors_duty_cycle1_L0+0, 0
L__rotateMotors44:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotors18
;motorsPWM.c,71 :: 		pwm_steering(1,2);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;motorsPWM.c,72 :: 		set_duty_cycle(1,duty_cycle1);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotors_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotors_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;motorsPWM.c,73 :: 		}
	GOTO       L_rotateMotors19
L_rotateMotors18:
;motorsPWM.c,75 :: 		duty_cycle1 = -duty_cycle1;
	MOVF       rotateMotors_duty_cycle1_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotors_duty_cycle1_L0+0
	MOVF       rotateMotors_duty_cycle1_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotors_duty_cycle1_L0+1
	SUBWF      rotateMotors_duty_cycle1_L0+1, 1
;motorsPWM.c,76 :: 		pwm_steering(1,1);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;motorsPWM.c,77 :: 		set_duty_cycle(1,duty_cycle1);            //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotors_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotors_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;motorsPWM.c,78 :: 		}
L_rotateMotors19:
;motorsPWM.c,80 :: 		if(duty_cycle2 >= 0){
	MOVLW      128
	XORWF      rotateMotors_duty_cycle2_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotors45
	MOVLW      0
	SUBWF      rotateMotors_duty_cycle2_L0+0, 0
L__rotateMotors45:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotors20
;motorsPWM.c,81 :: 		pwm_steering(2,2);                        //coloca no sentido anti horario de rotacao
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;motorsPWM.c,82 :: 		set_duty_cycle(2,duty_cycle2);                     //aplica o duty cycle
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotors_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotors_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;motorsPWM.c,83 :: 		}
	GOTO       L_rotateMotors21
L_rotateMotors20:
;motorsPWM.c,85 :: 		duty_cycle2 = -duty_cycle2;
	MOVF       rotateMotors_duty_cycle2_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotors_duty_cycle2_L0+0
	MOVF       rotateMotors_duty_cycle2_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotors_duty_cycle2_L0+1
	SUBWF      rotateMotors_duty_cycle2_L0+1, 1
;motorsPWM.c,86 :: 		pwm_steering(2,1);                       //coloca no sentido horario de rotacao
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;motorsPWM.c,87 :: 		set_duty_cycle(2,duty_cycle2);            //aplica o duty cycle
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotors_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotors_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;motorsPWM.c,88 :: 		}
L_rotateMotors21:
;motorsPWM.c,89 :: 		}
L_end_rotateMotors:
	RETURN
; end of _rotateMotors
