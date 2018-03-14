
_micros:

;Controlador5A.c,16 :: 		unsigned long long micros(){
;Controlador5A.c,17 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
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
;Controlador5A.c,18 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,19 :: 		}
L_end_micros:
	RETURN
; end of _micros

_failSafeCheck:

;Controlador5A.c,21 :: 		unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
;Controlador5A.c,22 :: 		if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
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
	GOTO       L__failSafeCheck56
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck56
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck56
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck56:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck0
;Controlador5A.c,23 :: 		return 1;
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck0:
;Controlador5A.c,24 :: 		return 0;
	CLRF       R0
	CLRF       R1
;Controlador5A.c,25 :: 		}
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_PulseIn1:

;Controlador5A.c,27 :: 		unsigned long long PulseIn1(){  //funcao que calculava, via software, o pulso recebido
;Controlador5A.c,29 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,30 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn11:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn12
;Controlador5A.c,31 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn158
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn158
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn158
	MOVF       R4, 0
	SUBLW      128
L__PulseIn158:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn13
;Controlador5A.c,32 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn13:
;Controlador5A.c,33 :: 		}
	GOTO       L_PulseIn11
L_PulseIn12:
;Controlador5A.c,34 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn14:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn15
;Controlador5A.c,35 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn159
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn159
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn159
	MOVF       R4, 0
	SUBLW      128
L__PulseIn159:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn16
;Controlador5A.c,36 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn16:
;Controlador5A.c,37 :: 		}
	GOTO       L_PulseIn14
L_PulseIn15:
;Controlador5A.c,38 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,39 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn17:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn18
;Controlador5A.c,40 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
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
	GOTO       L__PulseIn160
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn160
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn160
	MOVF       R4, 0
	SUBLW      128
L__PulseIn160:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn19
;Controlador5A.c,41 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn19:
;Controlador5A.c,42 :: 		}
	GOTO       L_PulseIn17
L_PulseIn18:
;Controlador5A.c,43 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
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
;Controlador5A.c,45 :: 		return t1_sig1;
;Controlador5A.c,46 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_rotateMotor1:

;Controlador5A.c,49 :: 		void rotateMotor1(unsigned long long pulseWidth){  // funcao ainda nao testada
;Controlador5A.c,51 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,52 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor162
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor162
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor162
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor162:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor110
;Controlador5A.c,53 :: 		dc = (dc - 500);
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
;Controlador5A.c,54 :: 		dc = dc*255/500;
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
;Controlador5A.c,55 :: 		pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      1
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,56 :: 		set_duty_cycle(1,dc);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,57 :: 		}
L_rotateMotor110:
;Controlador5A.c,58 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor163
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor163
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor163
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor163:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor111
;Controlador5A.c,59 :: 		dc = (500 - dc);
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
;Controlador5A.c,60 :: 		dc = dc*255/500;
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
;Controlador5A.c,61 :: 		pwm_steering(1,2);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,62 :: 		set_duty_cycle(1,dc);                    //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,63 :: 		}
L_rotateMotor111:
;Controlador5A.c,65 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,71 :: 		void interrupt()
;Controlador5A.c,73 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt12
;Controlador5A.c,75 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,76 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,77 :: 		}
L_interrupt12:
;Controlador5A.c,79 :: 		if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt15
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt15
L__interrupt53:
;Controlador5A.c,81 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,82 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,83 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,84 :: 		t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,85 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,86 :: 		} //end if
	GOTO       L_interrupt16
L_interrupt15:
;Controlador5A.c,87 :: 		else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt17
;Controlador5A.c,89 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,90 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,91 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,92 :: 		t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,93 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,94 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,95 :: 		} //end else
L_interrupt17:
L_interrupt16:
;Controlador5A.c,97 :: 		if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt20
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt20
L__interrupt52:
;Controlador5A.c,99 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,100 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,101 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,102 :: 		t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
;Controlador5A.c,103 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,104 :: 		} //end if
	GOTO       L_interrupt21
L_interrupt20:
;Controlador5A.c,105 :: 		else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt22
;Controlador5A.c,107 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,108 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,109 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,110 :: 		t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,111 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,112 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,113 :: 		} //end else  */
L_interrupt22:
L_interrupt21:
;Controlador5A.c,114 :: 		} //end interrupt
L_end_interrupt:
L__interrupt65:
	RETFIE     %s
; end of _interrupt

_error_led_blink:

;Controlador5A.c,116 :: 		void error_led_blink(unsigned time_ms){
;Controlador5A.c,118 :: 		time_ms = time_ms/250; //4 blinks por segundo
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
;Controlador5A.c,119 :: 		for(i=0; i< time_ms; i++){
	CLRF       error_led_blink_i_L0+0
	CLRF       error_led_blink_i_L0+1
L_error_led_blink23:
	MOVF       FARG_error_led_blink_time_ms+1, 0
	SUBWF      error_led_blink_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__error_led_blink67
	MOVF       FARG_error_led_blink_time_ms+0, 0
	SUBWF      error_led_blink_i_L0+0, 0
L__error_led_blink67:
	BTFSC      STATUS+0, 0
	GOTO       L_error_led_blink24
;Controlador5A.c,120 :: 		ERROR_LED = 1;
	BSF        RA0_bit+0, 0
;Controlador5A.c,121 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink26:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink26
	DECFSZ     R12, 1
	GOTO       L_error_led_blink26
	DECFSZ     R11, 1
	GOTO       L_error_led_blink26
;Controlador5A.c,122 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,123 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink27:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink27
	DECFSZ     R12, 1
	GOTO       L_error_led_blink27
	DECFSZ     R11, 1
	GOTO       L_error_led_blink27
;Controlador5A.c,119 :: 		for(i=0; i< time_ms; i++){
	INCF       error_led_blink_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       error_led_blink_i_L0+1, 1
;Controlador5A.c,124 :: 		}
	GOTO       L_error_led_blink23
L_error_led_blink24:
;Controlador5A.c,125 :: 		}
L_end_error_led_blink:
	RETURN
; end of _error_led_blink

_calibration:

;Controlador5A.c,126 :: 		void calibration(){
;Controlador5A.c,134 :: 		signal1_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal1_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal1_L_value_L0+1
;Controlador5A.c,135 :: 		signal2_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal2_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal2_L_value_L0+1
;Controlador5A.c,136 :: 		signal1_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal1_H_value_L0+0
	CLRF       calibration_signal1_H_value_L0+1
;Controlador5A.c,137 :: 		signal2_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal2_H_value_L0+0
	CLRF       calibration_signal2_H_value_L0+1
;Controlador5A.c,138 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,139 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,141 :: 		while((micros() - time_control) < 2000000){
L_calibration28:
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
	GOTO       L__calibration69
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration69
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration69
	MOVLW      128
	SUBWF      R4, 0
L__calibration69:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration29
;Controlador5A.c,142 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,143 :: 		if(signal_T_value < signal1_L_value)
	MOVF       calibration_signal1_L_value_L0+1, 0
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration70
	MOVF       calibration_signal1_L_value_L0+0, 0
	SUBWF      _t2_sig1+0, 0
L__calibration70:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration30
;Controlador5A.c,144 :: 		signal1_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_L_value_L0+1
L_calibration30:
;Controlador5A.c,146 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal2
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,147 :: 		if(signal_T_value < signal2_L_value)
	MOVF       calibration_signal2_L_value_L0+1, 0
	SUBWF      _t2_sig2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration71
	MOVF       calibration_signal2_L_value_L0+0, 0
	SUBWF      _t2_sig2+0, 0
L__calibration71:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration31
;Controlador5A.c,148 :: 		signal2_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_L_value_L0+1
L_calibration31:
;Controlador5A.c,149 :: 		}
	GOTO       L_calibration28
L_calibration29:
;Controlador5A.c,153 :: 		lower_8bits = signal1_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,154 :: 		upper_8bits = (signal1_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,155 :: 		EEPROM_Write(0X00,lower_8bits);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,156 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration32:
	DECFSZ     R13, 1
	GOTO       L_calibration32
	DECFSZ     R12, 1
	GOTO       L_calibration32
	NOP
;Controlador5A.c,157 :: 		EEPROM_Write(0X01,upper_8bits);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,158 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration33:
	DECFSZ     R13, 1
	GOTO       L_calibration33
	DECFSZ     R12, 1
	GOTO       L_calibration33
	NOP
;Controlador5A.c,161 :: 		lower_8bits = signal2_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,162 :: 		upper_8bits = (signal2_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,163 :: 		EEPROM_Write(0X02,lower_8bits);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,164 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration34:
	DECFSZ     R13, 1
	GOTO       L_calibration34
	DECFSZ     R12, 1
	GOTO       L_calibration34
	NOP
;Controlador5A.c,165 :: 		EEPROM_Write(0X03,upper_8bits);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,166 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration35:
	DECFSZ     R13, 1
	GOTO       L_calibration35
	DECFSZ     R12, 1
	GOTO       L_calibration35
	NOP
;Controlador5A.c,168 :: 		error_led_blink(1600);                      //indica a captura do valor minimo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,169 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,170 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,171 :: 		while((micros() - time_control) < 2000000){
L_calibration36:
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
	GOTO       L__calibration72
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration72
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration72
	MOVLW      128
	SUBWF      R4, 0
L__calibration72:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration37
;Controlador5A.c,172 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,173 :: 		if(signal_T_value > signal1_H_value)
	MOVF       _t2_sig1+1, 0
	SUBWF      calibration_signal1_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration73
	MOVF       _t2_sig1+0, 0
	SUBWF      calibration_signal1_H_value_L0+0, 0
L__calibration73:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration38
;Controlador5A.c,174 :: 		signal1_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_H_value_L0+1
L_calibration38:
;Controlador5A.c,176 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal1
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,177 :: 		if(signal_T_value > signal2_H_value)
	MOVF       _t2_sig2+1, 0
	SUBWF      calibration_signal2_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration74
	MOVF       _t2_sig2+0, 0
	SUBWF      calibration_signal2_H_value_L0+0, 0
L__calibration74:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration39
;Controlador5A.c,178 :: 		signal2_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_H_value_L0+1
L_calibration39:
;Controlador5A.c,179 :: 		}
	GOTO       L_calibration36
L_calibration37:
;Controlador5A.c,181 :: 		lower_8bits = signal1_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,182 :: 		upper_8bits = (signal1_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,183 :: 		EEPROM_Write(0X04,lower_8bits);
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,184 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration40:
	DECFSZ     R13, 1
	GOTO       L_calibration40
	DECFSZ     R12, 1
	GOTO       L_calibration40
	NOP
;Controlador5A.c,185 :: 		EEPROM_Write(0X05,upper_8bits);
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,186 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration41:
	DECFSZ     R13, 1
	GOTO       L_calibration41
	DECFSZ     R12, 1
	GOTO       L_calibration41
	NOP
;Controlador5A.c,188 :: 		lower_8bits = signal2_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,189 :: 		upper_8bits = (signal2_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,190 :: 		EEPROM_Write(0X06,lower_8bits);
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,191 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration42:
	DECFSZ     R13, 1
	GOTO       L_calibration42
	DECFSZ     R12, 1
	GOTO       L_calibration42
	NOP
;Controlador5A.c,192 :: 		EEPROM_Write(0X07,upper_8bits);
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,193 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration43:
	DECFSZ     R13, 1
	GOTO       L_calibration43
	DECFSZ     R12, 1
	GOTO       L_calibration43
	NOP
;Controlador5A.c,195 :: 		error_led_blink(1600);                      //indica a captura do valor maximo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,196 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,197 :: 		}
L_end_calibration:
	RETURN
; end of _calibration

_read_eeprom_signals_data:

;Controlador5A.c,199 :: 		void read_eeprom_signals_data(){
;Controlador5A.c,203 :: 		UART1_write_text("LOW channel1: ");
	MOVLW      ?lstr1_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,204 :: 		lower_8bits = EEPROM_Read(0X00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,205 :: 		upper_8bits = EEPROM_Read(0X01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,206 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,207 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,208 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,209 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,210 :: 		lower_8bits = EEPROM_Read(0X02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,211 :: 		upper_8bits = EEPROM_Read(0X03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,212 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,213 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,214 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,215 :: 		UART1_write_text("\t");
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,216 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data44:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data44
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data44
	NOP
;Controlador5A.c,218 :: 		UART1_write_text("HIGH channel1: ");
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,219 :: 		lower_8bits = EEPROM_Read(0X04);
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,220 :: 		upper_8bits = EEPROM_Read(0X05);
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,221 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,222 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,223 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,224 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,225 :: 		lower_8bits = EEPROM_Read(0X06);
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,226 :: 		upper_8bits = EEPROM_Read(0X07);
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,227 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,228 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,229 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,230 :: 		UART1_write_text("\n");
	MOVLW      ?lstr6_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,231 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data45:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data45
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data45
	NOP
;Controlador5A.c,232 :: 		}
L_end_read_eeprom_signals_data:
	RETURN
; end of _read_eeprom_signals_data

_print_signal_received:

;Controlador5A.c,234 :: 		void print_signal_received(){
;Controlador5A.c,237 :: 		UART1_write_text("Sinal 1: ");
	MOVLW      ?lstr7_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,238 :: 		LongWordToStr(t2_sig1, buffer);
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
;Controlador5A.c,239 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,240 :: 		UART1_write_text("\t");
	MOVLW      ?lstr8_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,242 :: 		UART1_write_text("Sinal 2: ");
	MOVLW      ?lstr9_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,243 :: 		LongWordToStr(t2_sig2, buffer);
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
;Controlador5A.c,244 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,245 :: 		UART1_write_text("\n");
	MOVLW      ?lstr10_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,247 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_print_signal_received46:
	DECFSZ     R13, 1
	GOTO       L_print_signal_received46
	DECFSZ     R12, 1
	GOTO       L_print_signal_received46
	DECFSZ     R11, 1
	GOTO       L_print_signal_received46
	NOP
;Controlador5A.c,248 :: 		}
L_end_print_signal_received:
	RETURN
; end of _print_signal_received

_main:

;Controlador5A.c,250 :: 		void main() {
;Controlador5A.c,251 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz. NAO APAGAR ESSA LINHA (talvez muda-la pra dentro do setup_port)
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,252 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,253 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,254 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,257 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,258 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,259 :: 		set_duty_cycle(1, 0);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	CLRF       FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,260 :: 		set_duty_cycle(2, 0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	CLRF       FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,261 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main47:
	DECFSZ     R13, 1
	GOTO       L_main47
	DECFSZ     R12, 1
	GOTO       L_main47
	DECFSZ     R11, 1
	GOTO       L_main47
	NOP
	NOP
;Controlador5A.c,262 :: 		t2_sig2 = 15000;
	MOVLW      152
	MOVWF      _t2_sig2+0
	MOVLW      58
	MOVWF      _t2_sig2+1
	CLRF       _t2_sig2+2
	CLRF       _t2_sig2+3
;Controlador5A.c,263 :: 		t2_sig1 = 15000;
	MOVLW      152
	MOVWF      _t2_sig1+0
	MOVLW      58
	MOVWF      _t2_sig1+1
	CLRF       _t2_sig1+2
	CLRF       _t2_sig1+3
;Controlador5A.c,265 :: 		while(1){
L_main48:
;Controlador5A.c,267 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,268 :: 		set_duty_cycle(2, 0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	CLRF       FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,269 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main50:
	DECFSZ     R13, 1
	GOTO       L_main50
	DECFSZ     R12, 1
	GOTO       L_main50
	DECFSZ     R11, 1
	GOTO       L_main50
	NOP
	NOP
;Controlador5A.c,270 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,271 :: 		set_duty_cycle(2, 150);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	MOVLW      150
	MOVWF      FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,272 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11
	MOVLW      75
	MOVWF      R12
	MOVLW      190
	MOVWF      R13
L_main51:
	DECFSZ     R13, 1
	GOTO       L_main51
	DECFSZ     R12, 1
	GOTO       L_main51
	DECFSZ     R11, 1
	GOTO       L_main51
	NOP
;Controlador5A.c,273 :: 		}
	GOTO       L_main48
;Controlador5A.c,274 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
