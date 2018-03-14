
_micros:

;Controlador5A.c,14 :: 		unsigned long long micros(){
;Controlador5A.c,15 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
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
;Controlador5A.c,16 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,17 :: 		}
L_end_micros:
	RETURN
; end of _micros

_failSafeCheck:

;Controlador5A.c,19 :: 		unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
;Controlador5A.c,20 :: 		if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
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
	GOTO       L__failSafeCheck42
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck42
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck42
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck42:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck0
;Controlador5A.c,21 :: 		return 1;
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck0:
;Controlador5A.c,22 :: 		return 0;
	CLRF       R0
	CLRF       R1
;Controlador5A.c,23 :: 		}
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,29 :: 		void interrupt()
;Controlador5A.c,37 :: 		if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt3
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt3
L__interrupt39:
;Controlador5A.c,39 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,40 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,41 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,42 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,43 :: 		TMR1L       = 0x00;                    //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,44 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,45 :: 		TMR1ON_bit  = 0x01;                    //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,46 :: 		} //end if
	GOTO       L_interrupt4
L_interrupt3:
;Controlador5A.c,47 :: 		else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt5
;Controlador5A.c,49 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,50 :: 		TMR1ON_bit  = 0x00;                    //Interrompe a contagem do Timer1
	BCF        TMR1ON_bit+0, 0
;Controlador5A.c,51 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,52 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,53 :: 		sig1_width  = (TMR1H <<8 | TMR1L);     //Captura a largura do pulso do Sinal 1
	MOVF       TMR1H+0, 0
	MOVWF      _sig1_width+1
	CLRF       _sig1_width+0
	MOVF       TMR1L+0, 0
	IORWF       _sig1_width+0, 1
	MOVLW      0
	IORWF       _sig1_width+1, 1
;Controlador5A.c,54 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP4 = RADIO_IN2
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,55 :: 		} //end else
L_interrupt5:
L_interrupt4:
;Controlador5A.c,57 :: 		if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt8
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt8
L__interrupt38:
;Controlador5A.c,59 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,60 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,61 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,62 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,63 :: 		TMR1L       = 0x00;                    //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,64 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,65 :: 		TMR1ON_bit  = 0x01;                    //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,66 :: 		} //end if
	GOTO       L_interrupt9
L_interrupt8:
;Controlador5A.c,67 :: 		else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt10
;Controlador5A.c,69 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,70 :: 		TMR1ON_bit  = 0x00;                    //Interrompe a contagem do Timer1
	BCF        TMR1ON_bit+0, 0
;Controlador5A.c,71 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,72 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,73 :: 		sig2_width  = (TMR1H <<8 | TMR1L);     //Captura a largura do pulso do Sinal 2
	MOVF       TMR1H+0, 0
	MOVWF      _sig2_width+1
	CLRF       _sig2_width+0
	MOVF       TMR1L+0, 0
	IORWF       _sig2_width+0, 1
	MOVLW      0
	IORWF       _sig2_width+1, 1
;Controlador5A.c,74 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP3 = RADIO_IN1
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,75 :: 		} //end else  */
L_interrupt10:
L_interrupt9:
;Controlador5A.c,76 :: 		} //end interrupt
L_end_interrupt:
L__interrupt44:
	RETFIE     %s
; end of _interrupt

_error_led_blink:

;Controlador5A.c,78 :: 		void error_led_blink(unsigned time_ms){
;Controlador5A.c,80 :: 		time_ms = time_ms/250; //4 blinks por segundo
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
;Controlador5A.c,81 :: 		for(i=0; i< time_ms; i++){
	CLRF       error_led_blink_i_L0+0
	CLRF       error_led_blink_i_L0+1
L_error_led_blink11:
	MOVF       FARG_error_led_blink_time_ms+1, 0
	SUBWF      error_led_blink_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__error_led_blink46
	MOVF       FARG_error_led_blink_time_ms+0, 0
	SUBWF      error_led_blink_i_L0+0, 0
L__error_led_blink46:
	BTFSC      STATUS+0, 0
	GOTO       L_error_led_blink12
;Controlador5A.c,82 :: 		ERROR_LED = 1;
	BSF        RA0_bit+0, 0
;Controlador5A.c,83 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink14:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink14
	DECFSZ     R12, 1
	GOTO       L_error_led_blink14
	DECFSZ     R11, 1
	GOTO       L_error_led_blink14
;Controlador5A.c,84 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,85 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink15:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink15
	DECFSZ     R12, 1
	GOTO       L_error_led_blink15
	DECFSZ     R11, 1
	GOTO       L_error_led_blink15
;Controlador5A.c,81 :: 		for(i=0; i< time_ms; i++){
	INCF       error_led_blink_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       error_led_blink_i_L0+1, 1
;Controlador5A.c,86 :: 		}
	GOTO       L_error_led_blink11
L_error_led_blink12:
;Controlador5A.c,87 :: 		}
L_end_error_led_blink:
	RETURN
; end of _error_led_blink

_calibration:

;Controlador5A.c,88 :: 		void calibration(){
;Controlador5A.c,96 :: 		signal1_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal1_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal1_L_value_L0+1
;Controlador5A.c,97 :: 		signal2_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal2_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal2_L_value_L0+1
;Controlador5A.c,98 :: 		signal1_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal1_H_value_L0+0
	CLRF       calibration_signal1_H_value_L0+1
;Controlador5A.c,99 :: 		signal2_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal2_H_value_L0+0
	CLRF       calibration_signal2_H_value_L0+1
;Controlador5A.c,100 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,101 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,103 :: 		while((micros() - time_control) < 2000000){
L_calibration16:
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
	GOTO       L__calibration48
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration48
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration48
	MOVLW      128
	SUBWF      R4, 0
L__calibration48:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration17
;Controlador5A.c,104 :: 		signal_T_value = (unsigned) sig1_width;   //valor da largura do pulso do canal1
	MOVF       _sig1_width+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _sig1_width+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,105 :: 		if(signal_T_value < signal1_L_value)
	MOVF       calibration_signal1_L_value_L0+1, 0
	SUBWF      _sig1_width+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration49
	MOVF       calibration_signal1_L_value_L0+0, 0
	SUBWF      _sig1_width+0, 0
L__calibration49:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration18
;Controlador5A.c,106 :: 		signal1_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_L_value_L0+1
L_calibration18:
;Controlador5A.c,108 :: 		signal_T_value = (unsigned) sig2_width;   //valor da largura do pulso do canal2
	MOVF       _sig2_width+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _sig2_width+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,109 :: 		if(signal_T_value < signal2_L_value)
	MOVF       calibration_signal2_L_value_L0+1, 0
	SUBWF      _sig2_width+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration50
	MOVF       calibration_signal2_L_value_L0+0, 0
	SUBWF      _sig2_width+0, 0
L__calibration50:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration19
;Controlador5A.c,110 :: 		signal2_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_L_value_L0+1
L_calibration19:
;Controlador5A.c,111 :: 		}
	GOTO       L_calibration16
L_calibration17:
;Controlador5A.c,115 :: 		lower_8bits = signal1_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,116 :: 		upper_8bits = (signal1_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,117 :: 		EEPROM_Write(0X00,lower_8bits);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,118 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration20:
	DECFSZ     R13, 1
	GOTO       L_calibration20
	DECFSZ     R12, 1
	GOTO       L_calibration20
	NOP
;Controlador5A.c,119 :: 		EEPROM_Write(0X01,upper_8bits);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,120 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration21:
	DECFSZ     R13, 1
	GOTO       L_calibration21
	DECFSZ     R12, 1
	GOTO       L_calibration21
	NOP
;Controlador5A.c,123 :: 		lower_8bits = signal2_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,124 :: 		upper_8bits = (signal2_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,125 :: 		EEPROM_Write(0X02,lower_8bits);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,126 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration22:
	DECFSZ     R13, 1
	GOTO       L_calibration22
	DECFSZ     R12, 1
	GOTO       L_calibration22
	NOP
;Controlador5A.c,127 :: 		EEPROM_Write(0X03,upper_8bits);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,128 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration23:
	DECFSZ     R13, 1
	GOTO       L_calibration23
	DECFSZ     R12, 1
	GOTO       L_calibration23
	NOP
;Controlador5A.c,130 :: 		error_led_blink(1600);                      //indica a captura do valor minimo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,131 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,132 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA0_bit+0, 0
;Controlador5A.c,133 :: 		while((micros() - time_control) < 2000000){
L_calibration24:
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
	GOTO       L__calibration51
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration51
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration51
	MOVLW      128
	SUBWF      R4, 0
L__calibration51:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration25
;Controlador5A.c,134 :: 		signal_T_value = (unsigned) sig1_width;   //valor da largura do pulso do canal1
	MOVF       _sig1_width+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _sig1_width+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,135 :: 		if(signal_T_value > signal1_H_value)
	MOVF       _sig1_width+1, 0
	SUBWF      calibration_signal1_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration52
	MOVF       _sig1_width+0, 0
	SUBWF      calibration_signal1_H_value_L0+0, 0
L__calibration52:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration26
;Controlador5A.c,136 :: 		signal1_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_H_value_L0+1
L_calibration26:
;Controlador5A.c,138 :: 		signal_T_value = (unsigned) sig2_width;   //valor da largura do pulso do canal1
	MOVF       _sig2_width+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _sig2_width+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,139 :: 		if(signal_T_value > signal2_H_value)
	MOVF       _sig2_width+1, 0
	SUBWF      calibration_signal2_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration53
	MOVF       _sig2_width+0, 0
	SUBWF      calibration_signal2_H_value_L0+0, 0
L__calibration53:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration27
;Controlador5A.c,140 :: 		signal2_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_H_value_L0+1
L_calibration27:
;Controlador5A.c,141 :: 		}
	GOTO       L_calibration24
L_calibration25:
;Controlador5A.c,143 :: 		lower_8bits = signal1_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,144 :: 		upper_8bits = (signal1_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,145 :: 		EEPROM_Write(0X04,lower_8bits);
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,146 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration28:
	DECFSZ     R13, 1
	GOTO       L_calibration28
	DECFSZ     R12, 1
	GOTO       L_calibration28
	NOP
;Controlador5A.c,147 :: 		EEPROM_Write(0X05,upper_8bits);
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,148 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration29:
	DECFSZ     R13, 1
	GOTO       L_calibration29
	DECFSZ     R12, 1
	GOTO       L_calibration29
	NOP
;Controlador5A.c,150 :: 		lower_8bits = signal2_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,151 :: 		upper_8bits = (signal2_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,152 :: 		EEPROM_Write(0X06,lower_8bits);
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,153 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration30:
	DECFSZ     R13, 1
	GOTO       L_calibration30
	DECFSZ     R12, 1
	GOTO       L_calibration30
	NOP
;Controlador5A.c,154 :: 		EEPROM_Write(0X07,upper_8bits);
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,155 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration31:
	DECFSZ     R13, 1
	GOTO       L_calibration31
	DECFSZ     R12, 1
	GOTO       L_calibration31
	NOP
;Controlador5A.c,157 :: 		error_led_blink(1600);                      //indica a captura do valor maximo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,158 :: 		ERROR_LED = 0;
	BCF        RA0_bit+0, 0
;Controlador5A.c,159 :: 		}
L_end_calibration:
	RETURN
; end of _calibration

_read_eeprom_signals_data:

;Controlador5A.c,161 :: 		void read_eeprom_signals_data(){
;Controlador5A.c,165 :: 		UART1_write_text("LOW channel1: ");
	MOVLW      ?lstr1_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,166 :: 		lower_8bits = EEPROM_Read(0X00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,167 :: 		upper_8bits = EEPROM_Read(0X01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,168 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,169 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,170 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,171 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,172 :: 		lower_8bits = EEPROM_Read(0X02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,173 :: 		upper_8bits = EEPROM_Read(0X03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,174 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,175 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,176 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,177 :: 		UART1_write_text("\t");
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,178 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data32:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data32
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data32
	NOP
;Controlador5A.c,180 :: 		UART1_write_text("HIGH channel1: ");
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,181 :: 		lower_8bits = EEPROM_Read(0X04);
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,182 :: 		upper_8bits = EEPROM_Read(0X05);
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,183 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,184 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,185 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,186 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,187 :: 		lower_8bits = EEPROM_Read(0X06);
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,188 :: 		upper_8bits = EEPROM_Read(0X07);
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,189 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,190 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,191 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,192 :: 		UART1_write_text("\n");
	MOVLW      ?lstr6_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,193 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data33:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data33
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data33
	NOP
;Controlador5A.c,194 :: 		}
L_end_read_eeprom_signals_data:
	RETURN
; end of _read_eeprom_signals_data

_print_signal_received:

;Controlador5A.c,196 :: 		void print_signal_received(unsigned sig1,unsigned sig2 ){
;Controlador5A.c,199 :: 		UART1_write_text("Sinal 1: ");
	MOVLW      ?lstr7_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,200 :: 		IntToStr(sig1, buffer);
	MOVF       FARG_print_signal_received_sig1+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_print_signal_received_sig1+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_IntToStr_output+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_IntToStr_output+1
	CALL       _IntToStr+0
;Controlador5A.c,201 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,202 :: 		UART1_write_text("\t");
	MOVLW      ?lstr8_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,204 :: 		UART1_write_text("Sinal 2: ");
	MOVLW      ?lstr9_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,205 :: 		IntToStr(sig2, buffer);
	MOVF       FARG_print_signal_received_sig2+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_print_signal_received_sig2+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_IntToStr_output+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_IntToStr_output+1
	CALL       _IntToStr+0
;Controlador5A.c,206 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,207 :: 		UART1_write_text("\n");
	MOVLW      ?lstr10_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,209 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_print_signal_received34:
	DECFSZ     R13, 1
	GOTO       L_print_signal_received34
	DECFSZ     R12, 1
	GOTO       L_print_signal_received34
	DECFSZ     R11, 1
	GOTO       L_print_signal_received34
	NOP
;Controlador5A.c,210 :: 		}
L_end_print_signal_received:
	RETURN
; end of _print_signal_received

_main:

;Controlador5A.c,212 :: 		void main() {
;Controlador5A.c,213 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,214 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,215 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,216 :: 		setup_UART();
	CALL       _setup_UART+0
;Controlador5A.c,217 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr11_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr11_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,218 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,219 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	MOVLW      2
	MOVWF      FARG_pwm_steering+0
	MOVLW      0
	MOVWF      FARG_pwm_steering+1
	CALL       _pwm_steering+0
;Controlador5A.c,220 :: 		set_duty_cycle(1, 0);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	CLRF       FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,221 :: 		set_duty_cycle(2, 0);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle+1
	CLRF       FARG_set_duty_cycle+0
	CLRF       FARG_set_duty_cycle+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,222 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main35:
	DECFSZ     R13, 1
	GOTO       L_main35
	DECFSZ     R12, 1
	GOTO       L_main35
	DECFSZ     R11, 1
	GOTO       L_main35
	NOP
	NOP
;Controlador5A.c,224 :: 		while(1){
L_main36:
;Controlador5A.c,226 :: 		pulsew1 = sig1_width;
	MOVF       _sig1_width+0, 0
	MOVWF      main_pulsew1_L1+0
	MOVF       _sig1_width+1, 0
	MOVWF      main_pulsew1_L1+1
	CLRF       main_pulsew1_L1+2
	CLRF       main_pulsew1_L1+3
;Controlador5A.c,227 :: 		pulsew2 = sig2_width;
	MOVF       _sig2_width+0, 0
	MOVWF      main_pulsew2_L1+0
	MOVF       _sig2_width+1, 0
	MOVWF      main_pulsew2_L1+1
	CLRF       main_pulsew2_L1+2
	CLRF       main_pulsew2_L1+3
;Controlador5A.c,228 :: 		print_signal_received(pulsew1,pulsew2);
	MOVF       main_pulsew1_L1+0, 0
	MOVWF      FARG_print_signal_received_sig1+0
	MOVF       main_pulsew1_L1+1, 0
	MOVWF      FARG_print_signal_received_sig1+1
	MOVF       main_pulsew2_L1+0, 0
	MOVWF      FARG_print_signal_received_sig2+0
	MOVF       main_pulsew2_L1+1, 0
	MOVWF      FARG_print_signal_received_sig2+1
	CALL       _print_signal_received+0
;Controlador5A.c,229 :: 		rotateMotors(pulsew1,pulsew2);
	MOVF       main_pulsew1_L1+0, 0
	MOVWF      FARG_rotateMotors+0
	MOVF       main_pulsew1_L1+1, 0
	MOVWF      FARG_rotateMotors+1
	MOVF       main_pulsew2_L1+0, 0
	MOVWF      FARG_rotateMotors+0
	MOVF       main_pulsew2_L1+1, 0
	MOVWF      FARG_rotateMotors+1
	CALL       _rotateMotors+0
;Controlador5A.c,231 :: 		}
	GOTO       L_main36
;Controlador5A.c,232 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
