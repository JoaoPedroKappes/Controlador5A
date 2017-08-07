
_setup_pwms:

	CLRF       T2CON+0
	MOVLW      255
	MOVWF      PR2+0
	BCF        CCPTMRS+0, 1
	BCF        CCPTMRS+0, 0
	BSF        PSTR1CON+0, 0
	BSF        PSTR1CON+0, 1
	BCF        PSTR1CON+0, 2
	BCF        PSTR1CON+0, 3
	BSF        PSTR1CON+0, 4
	MOVLW      255
	MOVWF      CCPR1L+0
	MOVLW      60
	MOVWF      CCP1CON+0
	BCF        CCPTMRS+0, 3
	BCF        CCPTMRS+0, 2
	BSF        PSTR2CON+0, 0
	BSF        PSTR2CON+0, 1
	BCF        PSTR2CON+0, 2
	BCF        PSTR2CON+0, 3
	BSF        PSTR2CON+0, 4
	MOVLW      255
	MOVWF      CCPR2L+0
	MOVLW      60
	MOVWF      CCP2CON+0
	MOVLW      4
	MOVWF      T2CON+0
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_set_duty_cycle:

	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle81
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle81:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle82
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle82:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering84
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering84:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
	BCF        PSTR1CON+0, 0
	BCF        PSTR1CON+0, 1
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering85
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering85:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
	BSF        PSTR1CON+0, 0
L_pwm_steering3:
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering86
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering86:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
	BCF        RC5_bit+0, BitPos(RC5_bit+0)
	BSF        PSTR1CON+0, 1
L_pwm_steering4:
L_pwm_steering2:
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering87
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering87:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
	BCF        PSTR2CON+0, 0
	BCF        PSTR2CON+0, 1
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering88
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering88:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
	BCF        RA4_bit+0, BitPos(RA4_bit+0)
	BSF        PSTR2CON+0, 0
L_pwm_steering6:
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering89
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering89:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
	BCF        RA5_bit+0, BitPos(RA5_bit+0)
	BSF        PSTR2CON+0, 1
L_pwm_steering7:
L_pwm_steering5:
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_setup_Timer_1:

	BCF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
	BCF        TMR1CS1_bit+0, BitPos(TMR1CS1_bit+0)
	BCF        TMR1CS0_bit+0, BitPos(TMR1CS0_bit+0)
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	CLRF       TMR1L+0
	CLRF       TMR1H+0
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_micros:

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
L_end_micros:
	RETURN
; end of _micros

_setup_port:

	CLRF       CM1CON0+0
	CLRF       CM2CON0+0
	BSF        RXDTSEL_bit+0, BitPos(RXDTSEL_bit+0)
	BSF        TXCKSEL_bit+0, BitPos(TXCKSEL_bit+0)
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
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
	BSF        P2BSEL_bit+0, BitPos(P2BSEL_bit+0)
	BSF        CCP2SEL_bit+0, BitPos(CCP2SEL_bit+0)
	CLRF       ANSELA+0
	MOVLW      1
	MOVWF      ANSELC+0
	CALL       _ADC_Init+0
	BCF        TRISA1_bit+0, BitPos(TRISA1_bit+0)
	BSF        TRISA2_bit+0, BitPos(TRISA2_bit+0)
	BSF        TRISA3_bit+0, BitPos(TRISA3_bit+0)
	BCF        TRISA4_bit+0, BitPos(TRISA4_bit+0)
	BCF        TRISA5_bit+0, BitPos(TRISA5_bit+0)
	BSF        TRISC0_bit+0, BitPos(TRISC0_bit+0)
	BSF        TRISC1_bit+0, BitPos(TRISC1_bit+0)
	BSF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
	BSF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
	BCF        TRISC5_bit+0, BitPos(TRISC5_bit+0)
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
	BSF        CCP3IE_bit+0, BitPos(CCP3IE_bit+0)
	BSF        CCP4IE_bit+0, BitPos(CCP4IE_bit+0)
	MOVLW      5
	MOVWF      CCP3CON+0
	MOVLW      5
	MOVWF      CCP4CON+0
L_end_setup_port:
	RETURN
; end of _setup_port

_failSafeCheck:

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
	GOTO       L__failSafeCheck94
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck94
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck94
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck94:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck9
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck9:
	CLRF       R0
	CLRF       R1
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_PulseIn1:

	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
L_PulseIn110:
	BTFSS      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_PulseIn111
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
	GOTO       L_PulseIn112
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn112:
	GOTO       L_PulseIn110
L_PulseIn111:
L_PulseIn113:
	BTFSC      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_PulseIn114
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
	GOTO       L__PulseIn197
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn197
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn197
	MOVF       R4, 0
	SUBLW      128
L__PulseIn197:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn115
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn115:
	GOTO       L_PulseIn113
L_PulseIn114:
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
L_PulseIn116:
	BTFSS      RA2_bit+0, BitPos(RA2_bit+0)
	GOTO       L_PulseIn117
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
	GOTO       L__PulseIn198
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn198
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn198
	MOVF       R4, 0
	SUBLW      128
L__PulseIn198:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn118
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn118:
	GOTO       L_PulseIn116
L_PulseIn117:
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
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_map:

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
L_end_map:
	RETURN
; end of _map

_rotateMotor:

	MOVF       _t2_sig1+0, 0
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      rotateMotor_pulseWidth1_L0+1
	MOVF       _t2_sig2+0, 0
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      rotateMotor_pulseWidth2_L0+1
	MOVLW      4
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor101
	MOVLW      76
	SUBWF      _t2_sig1+0, 0
L__rotateMotor101:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor19
	MOVLW      76
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      4
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor19:
	MOVF       rotateMotor_pulseWidth1_L0+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor102
	MOVF       rotateMotor_pulseWidth1_L0+0, 0
	SUBLW      108
L__rotateMotor102:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor20
	MOVLW      108
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      7
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor20:
	MOVLW      4
	SUBWF      rotateMotor_pulseWidth2_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor103
	MOVLW      76
	SUBWF      rotateMotor_pulseWidth2_L0+0, 0
L__rotateMotor103:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor21
	MOVLW      76
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      4
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor21:
	MOVF       rotateMotor_pulseWidth2_L0+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor104
	MOVF       rotateMotor_pulseWidth2_L0+0, 0
	SUBLW      108
L__rotateMotor104:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor22
	MOVLW      108
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      7
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor22:
	MOVLW      6
	SUBWF      rotateMotor_pulseWidth1_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor105
	MOVLW      14
	SUBWF      rotateMotor_pulseWidth1_L0+0, 0
L__rotateMotor105:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor25
	MOVF       rotateMotor_pulseWidth1_L0+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor106
	MOVF       rotateMotor_pulseWidth1_L0+0, 0
	SUBLW      170
L__rotateMotor106:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor25
L__rotateMotor76:
	MOVLW      220
	MOVWF      rotateMotor_pulseWidth1_L0+0
	MOVLW      5
	MOVWF      rotateMotor_pulseWidth1_L0+1
L_rotateMotor25:
	MOVLW      6
	SUBWF      rotateMotor_pulseWidth2_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor107
	MOVLW      14
	SUBWF      rotateMotor_pulseWidth2_L0+0, 0
L__rotateMotor107:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor28
	MOVF       rotateMotor_pulseWidth2_L0+1, 0
	SUBLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor108
	MOVF       rotateMotor_pulseWidth2_L0+0, 0
	SUBLW      170
L__rotateMotor108:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor28
L__rotateMotor75:
	MOVLW      220
	MOVWF      rotateMotor_pulseWidth2_L0+0
	MOVLW      5
	MOVWF      rotateMotor_pulseWidth2_L0+1
L_rotateMotor28:
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
	MOVLW      128
	XORWF      rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor109
	MOVLW      0
	SUBWF      rotateMotor_duty_cycle1_L0+0, 0
L__rotateMotor109:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor29
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	GOTO       L_rotateMotor30
L_rotateMotor29:
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotor_duty_cycle1_L0+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor_duty_cycle1_L0+1
	SUBWF      rotateMotor_duty_cycle1_L0+1, 1
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle1_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle1_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
L_rotateMotor30:
	MOVLW      128
	XORWF      rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      R0
	MOVLW      128
	SUBWF      R0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor110
	MOVLW      0
	SUBWF      rotateMotor_duty_cycle2_L0+0, 0
L__rotateMotor110:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor31
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	GOTO       L_rotateMotor32
L_rotateMotor31:
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotor_duty_cycle2_L0+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor_duty_cycle2_L0+1
	SUBWF      rotateMotor_duty_cycle2_L0+1, 1
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle2_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle2_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
L_rotateMotor32:
L_end_rotateMotor:
	RETURN
; end of _rotateMotor

_rotateMotor1:

	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	SUBWFB     FARG_rotateMotor1_pulseWidth+1, 0
	MOVWF      rotateMotor1_dc_L0+1
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1112
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1112
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1112
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor1112:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor133
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
	MOVLW      255
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16X16_U+0
	MOVLW      244
	MOVWF      R4
	MOVLW      1
	MOVWF      R5
	CALL       _Div_16X16_U+0
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
L_rotateMotor133:
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1113
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1113
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor1113
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor1113:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor134
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
	MOVLW      255
	MOVWF      R4
	CLRF       R5
	CALL       _Mul_16X16_U+0
	MOVLW      244
	MOVWF      R4
	MOVLW      1
	MOVWF      R5
	CALL       _Div_16X16_U+0
	MOVF       R0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor1_dc_L0+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
L_rotateMotor134:
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:

	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt35
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
L_interrupt35:
	BTFSS      CCP3IF_bit+0, BitPos(CCP3IF_bit+0)
	GOTO       L_interrupt38
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt38
L__interrupt78:
	BCF        CCP3IF_bit+0, BitPos(CCP3IF_bit+0)
	BCF        CCP3IE_bit+0, BitPos(CCP3IE_bit+0)
	MOVLW      4
	MOVWF      CCP3CON+0
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
	BSF        CCP3IE_bit+0, BitPos(CCP3IE_bit+0)
	GOTO       L_interrupt39
L_interrupt38:
	BTFSS      CCP3IF_bit+0, BitPos(CCP3IF_bit+0)
	GOTO       L_interrupt40
	BCF        CCP3IF_bit+0, BitPos(CCP3IF_bit+0)
	BCF        CCP3IE_bit+0, BitPos(CCP3IE_bit+0)
	MOVLW      5
	MOVWF      CCP3CON+0
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
	BSF        CCP3IE_bit+0, BitPos(CCP3IE_bit+0)
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
L_interrupt40:
L_interrupt39:
	BTFSS      CCP4IF_bit+0, BitPos(CCP4IF_bit+0)
	GOTO       L_interrupt43
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt43
L__interrupt77:
	BCF        CCP4IF_bit+0, BitPos(CCP4IF_bit+0)
	BCF        CCP4IE_bit+0, BitPos(CCP4IE_bit+0)
	MOVLW      4
	MOVWF      CCP4CON+0
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
	BSF        CCP4IE_bit+0, BitPos(CCP4IE_bit+0)
	GOTO       L_interrupt44
L_interrupt43:
	BTFSS      CCP4IF_bit+0, BitPos(CCP4IF_bit+0)
	GOTO       L_interrupt45
	BCF        CCP4IF_bit+0, BitPos(CCP4IF_bit+0)
	BCF        CCP4IE_bit+0, BitPos(CCP4IE_bit+0)
	MOVLW      5
	MOVWF      CCP4CON+0
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
	BSF        CCP4IE_bit+0, BitPos(CCP4IE_bit+0)
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
L_interrupt45:
L_interrupt44:
L_end_interrupt:
L__interrupt115:
	RETFIE     %s
; end of _interrupt

_error_led_blink:

	MOVLW      250
	MOVWF      R4
	CLRF       R5
	MOVF       FARG_error_led_blink_time_ms+0, 0
	MOVWF      R0
	MOVF       FARG_error_led_blink_time_ms+1, 0
	MOVWF      R1
	CALL       _Div_16X16_U+0
	MOVF       R0, 0
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVF       R1, 0
	MOVWF      FARG_error_led_blink_time_ms+1
	CLRF       error_led_blink_i_L0+0
	CLRF       error_led_blink_i_L0+1
L_error_led_blink46:
	MOVF       FARG_error_led_blink_time_ms+1, 0
	SUBWF      error_led_blink_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__error_led_blink117
	MOVF       FARG_error_led_blink_time_ms+0, 0
	SUBWF      error_led_blink_i_L0+0, 0
L__error_led_blink117:
	BTFSC      STATUS+0, 0
	GOTO       L_error_led_blink47
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
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
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink50:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink50
	DECFSZ     R12, 1
	GOTO       L_error_led_blink50
	DECFSZ     R11, 1
	GOTO       L_error_led_blink50
	INCF       error_led_blink_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       error_led_blink_i_L0+1, 1
	GOTO       L_error_led_blink46
L_error_led_blink47:
L_end_error_led_blink:
	RETURN
; end of _error_led_blink

_calibration:

	MOVLW      32
	MOVWF      calibration_signal1_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal1_L_value_L0+1
	MOVLW      32
	MOVWF      calibration_signal2_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal2_L_value_L0+1
	CLRF       calibration_signal1_H_value_L0+0
	CLRF       calibration_signal1_H_value_L0+1
	CLRF       calibration_signal2_H_value_L0+0
	CLRF       calibration_signal2_H_value_L0+1
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
L_calibration51:
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
	GOTO       L__calibration119
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration119
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration119
	MOVLW      128
	SUBWF      R4, 0
L__calibration119:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration52
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
	MOVF       calibration_signal1_L_value_L0+1, 0
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration120
	MOVF       calibration_signal1_L_value_L0+0, 0
	SUBWF      _t2_sig1+0, 0
L__calibration120:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration53
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_L_value_L0+1
L_calibration53:
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
	MOVF       calibration_signal2_L_value_L0+1, 0
	SUBWF      _t2_sig2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration121
	MOVF       calibration_signal2_L_value_L0+0, 0
	SUBWF      _t2_sig2+0, 0
L__calibration121:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration54
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_L_value_L0+1
L_calibration54:
	GOTO       L_calibration51
L_calibration52:
	MOVLW      255
	ANDWF      calibration_signal1_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
	MOVF       calibration_signal1_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      255
	ANDWF      calibration_signal2_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
	MOVF       calibration_signal2_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration58:
	DECFSZ     R13, 1
	GOTO       L_calibration58
	DECFSZ     R12, 1
	GOTO       L_calibration58
	NOP
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
L_calibration59:
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
	GOTO       L__calibration122
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration122
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration122
	MOVLW      128
	SUBWF      R4, 0
L__calibration122:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration60
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
	MOVF       _t2_sig1+1, 0
	SUBWF      calibration_signal1_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration123
	MOVF       _t2_sig1+0, 0
	SUBWF      calibration_signal1_H_value_L0+0, 0
L__calibration123:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration61
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_H_value_L0+1
L_calibration61:
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
	MOVF       _t2_sig2+1, 0
	SUBWF      calibration_signal2_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration124
	MOVF       _t2_sig2+0, 0
	SUBWF      calibration_signal2_H_value_L0+0, 0
L__calibration124:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration62
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_H_value_L0+1
L_calibration62:
	GOTO       L_calibration59
L_calibration60:
	MOVLW      255
	ANDWF      calibration_signal1_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
	MOVF       calibration_signal1_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      255
	ANDWF      calibration_signal2_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
	MOVF       calibration_signal2_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
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
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration66:
	DECFSZ     R13, 1
	GOTO       L_calibration66
	DECFSZ     R12, 1
	GOTO       L_calibration66
	NOP
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
L_end_calibration:
	RETURN
; end of _calibration

_read_eeprom_signals_data:

	MOVLW      ?lstr1_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
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
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr6_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data68:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data68
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data68
	NOP
L_end_read_eeprom_signals_data:
	RETURN
; end of _read_eeprom_signals_data

_print_signal_received:

	MOVLW      ?lstr7_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
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
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr8_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr9_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
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
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr10_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_print_signal_received69:
	DECFSZ     R13, 1
	GOTO       L_print_signal_received69
	DECFSZ     R12, 1
	GOTO       L_print_signal_received69
	DECFSZ     R11, 1
	GOTO       L_print_signal_received69
	NOP
L_end_print_signal_received:
	RETURN
; end of _print_signal_received

_main:

	MOVLW      114
	MOVWF      OSCCON+0
	CALL       _setup_port+0
	CALL       _setup_pwms+0
	CALL       _setup_Timer_1+0
	MOVLW      ?lstr11_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr11_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      255
	MOVWF      FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main70:
	DECFSZ     R13, 1
	GOTO       L_main70
	DECFSZ     R12, 1
	GOTO       L_main70
	DECFSZ     R11, 1
	GOTO       L_main70
	NOP
	NOP
	MOVLW      32
	MOVWF      _t2_sig2+0
	MOVLW      78
	MOVWF      _t2_sig2+1
	CLRF       _t2_sig2+2
	CLRF       _t2_sig2+3
	MOVLW      32
	MOVWF      _t2_sig1+0
	MOVLW      78
	MOVWF      _t2_sig1+1
	CLRF       _t2_sig1+2
	CLRF       _t2_sig1+3
L_main71:
	CALL       _failSafeCheck+0
	MOVF       R0, 0
	IORWF       R1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main73
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
	GOTO       L_main74
L_main73:
	CALL       _rotateMotor+0
L_main74:
	GOTO       L_main71
L_end_main:
	GOTO       $+0
; end of _main
