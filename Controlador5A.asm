
_setup_pwms:

;Controlador5A.c,37 :: 		void setup_pwms(){
;Controlador5A.c,38 :: 		T2CON = 0;   //desliga o Timer2, timer responsavel pelos PWMS
	CLRF       T2CON+0
;Controlador5A.c,39 :: 		PR2 = 255;
	MOVLW      255
	MOVWF      PR2+0
;Controlador5A.c,42 :: 		CCPTMRS.B1 = 0;    //00 = CCP1 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 1
;Controlador5A.c,43 :: 		CCPTMRS.B0 = 0;
	BCF        CCPTMRS+0, 0
;Controlador5A.c,46 :: 		PSTR1CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 0
;Controlador5A.c,47 :: 		PSTR1CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR1CON+0, 1
;Controlador5A.c,48 :: 		PSTR1CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR1CON+0, 2
;Controlador5A.c,49 :: 		PSTR1CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR1CON+0, 3
;Controlador5A.c,50 :: 		PSTR1CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR1CON+0, 4
;Controlador5A.c,51 :: 		CCPR1L  = 0b11111111; //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR1L+0
;Controlador5A.c,52 :: 		CCP1CON = 0b00111100; //see below:
	MOVLW      60
	MOVWF      CCP1CON+0
;Controlador5A.c,66 :: 		CCPTMRS.B3 = 0;    //00 = CCP2 is based off Timer2 in PWM mode
	BCF        CCPTMRS+0, 3
;Controlador5A.c,67 :: 		CCPTMRS.B2 = 0;
	BCF        CCPTMRS+0, 2
;Controlador5A.c,70 :: 		PSTR2CON.B0 = 1;   //1 = P1A pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 0
;Controlador5A.c,71 :: 		PSTR2CON.B1 = 1;   //1 = P1B pin has the PWM waveform with polarity control from CCP1M<1:0>
	BSF        PSTR2CON+0, 1
;Controlador5A.c,72 :: 		PSTR2CON.B2 = 0;   //0 = P1C pin is assigned to port pin
	BCF        PSTR2CON+0, 2
;Controlador5A.c,73 :: 		PSTR2CON.B3 = 0;   //0 = P1D pin is assigned to port pin
	BCF        PSTR2CON+0, 3
;Controlador5A.c,74 :: 		PSTR2CON.B4 = 1;   //Steering Sync bit, 0 = Output steering update occurs at the beginning of the instruction cycle boundary
	BSF        PSTR2CON+0, 4
;Controlador5A.c,75 :: 		CCPR2L  = 0b11111111;  //colocando nivel logico alto nas duas saidas para travar os motores
	MOVLW      255
	MOVWF      CCPR2L+0
;Controlador5A.c,76 :: 		CCP2CON = 0b00111100; //Mesma configuracao do ECCP1
	MOVLW      60
	MOVWF      CCP2CON+0
;Controlador5A.c,77 :: 		T2CON = 0b00000100;  //pre scaler =  1
	MOVLW      4
	MOVWF      T2CON+0
;Controlador5A.c,82 :: 		}
L_end_setup_pwms:
	RETURN
; end of _setup_pwms

_set_duty_cycle:

;Controlador5A.c,84 :: 		void set_duty_cycle(unsigned int channel, unsigned int duty ){ //funcao responsavel por setar o dutycicle nos PWMS, variando de 0 a 255
;Controlador5A.c,85 :: 		if(channel == 1)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle67
	MOVLW      1
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle67:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle0
;Controlador5A.c,86 :: 		CCPR1L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR1L+0
L_set_duty_cycle0:
;Controlador5A.c,87 :: 		if(channel == 2)
	MOVLW      0
	XORWF      FARG_set_duty_cycle_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_duty_cycle68
	MOVLW      2
	XORWF      FARG_set_duty_cycle_channel+0, 0
L__set_duty_cycle68:
	BTFSS      STATUS+0, 2
	GOTO       L_set_duty_cycle1
;Controlador5A.c,88 :: 		CCPR2L = duty;
	MOVF       FARG_set_duty_cycle_duty+0, 0
	MOVWF      CCPR2L+0
L_set_duty_cycle1:
;Controlador5A.c,89 :: 		}
L_end_set_duty_cycle:
	RETURN
; end of _set_duty_cycle

_pwm_steering:

;Controlador5A.c,90 :: 		void pwm_steering(unsigned int channel,unsigned int port){
;Controlador5A.c,91 :: 		if(channel == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering70
	MOVLW      1
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering70:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering2
;Controlador5A.c,92 :: 		PSTR1CON.B0 = 0;   //1 = P1A pin is assigned to port pin
	BCF        PSTR1CON+0, 0
;Controlador5A.c,93 :: 		PSTR1CON.B1 = 0;   //1 = P1B pin is assigned to port pin
	BCF        PSTR1CON+0, 1
;Controlador5A.c,94 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering71
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering71:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering3
;Controlador5A.c,95 :: 		P1B = 0;         //port pin stays at low
	BCF        RC4_bit+0, 4
;Controlador5A.c,96 :: 		PSTR1CON.B0 = 1; //1 = P1A pin has the PWM waveform
	BSF        PSTR1CON+0, 0
;Controlador5A.c,97 :: 		}
L_pwm_steering3:
;Controlador5A.c,98 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering72
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering72:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering4
;Controlador5A.c,99 :: 		P1A = 0;         //port pin stays at low
	BCF        RC5_bit+0, 5
;Controlador5A.c,100 :: 		PSTR1CON.B1 = 1; //1 = P1B pin has the PWM waveform
	BSF        PSTR1CON+0, 1
;Controlador5A.c,101 :: 		}
L_pwm_steering4:
;Controlador5A.c,102 :: 		}//channel1 if
L_pwm_steering2:
;Controlador5A.c,103 :: 		if(channel == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_channel+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering73
	MOVLW      2
	XORWF      FARG_pwm_steering_channel+0, 0
L__pwm_steering73:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering5
;Controlador5A.c,104 :: 		PSTR2CON.B0 = 0;   //1 = P2A pin is assigned to port pin
	BCF        PSTR2CON+0, 0
;Controlador5A.c,105 :: 		PSTR2CON.B1 = 0;   //1 = P2B pin is assigned to port pin
	BCF        PSTR2CON+0, 1
;Controlador5A.c,106 :: 		if(port == 1){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering74
	MOVLW      1
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering74:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering6
;Controlador5A.c,107 :: 		P2B = 0;         //port pin stays at low
	BCF        RA4_bit+0, 4
;Controlador5A.c,108 :: 		PSTR2CON.B0 = 1; //1 = P2A pin has the PWM waveform
	BSF        PSTR2CON+0, 0
;Controlador5A.c,109 :: 		}
L_pwm_steering6:
;Controlador5A.c,110 :: 		if(port == 2){
	MOVLW      0
	XORWF      FARG_pwm_steering_port+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pwm_steering75
	MOVLW      2
	XORWF      FARG_pwm_steering_port+0, 0
L__pwm_steering75:
	BTFSS      STATUS+0, 2
	GOTO       L_pwm_steering7
;Controlador5A.c,111 :: 		P2A = 0;         //port pin stays at low
	BCF        RA5_bit+0, 5
;Controlador5A.c,112 :: 		PSTR2CON.B1 = 1; //1 = P2B pin has the PWM waveform
	BSF        PSTR2CON+0, 1
;Controlador5A.c,113 :: 		}
L_pwm_steering7:
;Controlador5A.c,114 :: 		}//channel2 if
L_pwm_steering5:
;Controlador5A.c,116 :: 		}
L_end_pwm_steering:
	RETURN
; end of _pwm_steering

_setup_Timer_1:

;Controlador5A.c,119 :: 		void setup_Timer_1(){
;Controlador5A.c,121 :: 		T1CKPS1_bit = 0x00;                        //Prescaller TMR1 1:2, cada bit do timer1 e correspondente a 1 us
	BCF        T1CKPS1_bit+0, 5
;Controlador5A.c,122 :: 		T1CKPS0_bit = 0x01;                        //
	BSF        T1CKPS0_bit+0, 4
;Controlador5A.c,123 :: 		TMR1CS1_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS1_bit+0, 7
;Controlador5A.c,124 :: 		TMR1CS0_bit = 0x00;                        //Clock: Fosc/4 = instruction clock
	BCF        TMR1CS0_bit+0, 6
;Controlador5A.c,125 :: 		TMR1ON_bit  = 0x01;                        //Inicia a contagem do Timer1
	BSF        TMR1ON_bit+0, 0
;Controlador5A.c,126 :: 		TMR1IE_bit  = 0x01;                        //Habilita interrupcoes de TMR1
	BSF        TMR1IE_bit+0, 0
;Controlador5A.c,127 :: 		TMR1L       = 0x00;                        //zera o Timer1
	CLRF       TMR1L+0
;Controlador5A.c,128 :: 		TMR1H       = 0x00;
	CLRF       TMR1H+0
;Controlador5A.c,132 :: 		}
L_end_setup_Timer_1:
	RETURN
; end of _setup_Timer_1

_micros:

;Controlador5A.c,133 :: 		unsigned long long micros(){
;Controlador5A.c,134 :: 		return  (TMR1H <<8 | TMR1L)* TIMER1_CONST     //cada bit do timer 1 vale 1us
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
;Controlador5A.c,135 :: 		+ n_interrupts_timer1*OVERFLOW_CONST; //numero de interrupcoes vezes o valor maximo do Timer 1 (2^16)
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
;Controlador5A.c,136 :: 		}
L_end_micros:
	RETURN
; end of _micros

_setup_port:

;Controlador5A.c,137 :: 		void setup_port(){
;Controlador5A.c,139 :: 		CM1CON0       = 0;
	CLRF       CM1CON0+0
;Controlador5A.c,140 :: 		CM2CON0       = 0;
	CLRF       CM2CON0+0
;Controlador5A.c,143 :: 		RXDTSEL_bit = 1;     //RXDTSEL: RX/DT function is on RA1
	BSF        RXDTSEL_bit+0, 7
;Controlador5A.c,144 :: 		TXCKSEL_bit = 1;     //TXDTSEL: TX/CK function is on RA0
	BSF        TXCKSEL_bit+0, 2
;Controlador5A.c,145 :: 		UART1_Init(9600);    //Initialize UART module at 9600 bps      153600 = 9600*16
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Controlador5A.c,146 :: 		Delay_ms(100);       //Wait for UART module to stabilize
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
;Controlador5A.c,149 :: 		P2BSEL_bit =  1;    //P2BSEL: 1 = P2B function is on RA4
	BSF        P2BSEL_bit+0, 1
;Controlador5A.c,150 :: 		CCP2SEL_bit =  1;   //CCP2SEL:1 = CCP2/P2A function is on RA5
	BSF        CCP2SEL_bit+0, 0
;Controlador5A.c,152 :: 		ANSELA     = 0; //Nenhuma porta analogica
	CLRF       ANSELA+0
;Controlador5A.c,153 :: 		ANSELC  = 0x01; //RC0 analogico AN4, ultimo bit do ANSELC.
	MOVLW      1
	MOVWF      ANSELC+0
;Controlador5A.c,154 :: 		ADC_Init();     // Initialize ADC module with default settings
	CALL       _ADC_Init+0
;Controlador5A.c,159 :: 		TRISA1_bit = 0; //RX(UART) e LED_ERROR
	BCF        TRISA1_bit+0, 1
;Controlador5A.c,160 :: 		TRISA2_bit = 1; //RADIO INPUT1(CCP3)
	BSF        TRISA2_bit+0, 2
;Controlador5A.c,161 :: 		TRISA3_bit = 1; //MLCR
	BSF        TRISA3_bit+0, 3
;Controlador5A.c,162 :: 		TRISA4_bit = 0; //PWM OUTPUT(P2B)
	BCF        TRISA4_bit+0, 4
;Controlador5A.c,163 :: 		TRISA5_bit = 0; //PWM OUTPUT(P2A)
	BCF        TRISA5_bit+0, 5
;Controlador5A.c,167 :: 		TRISC0_bit = 1; //AN4 (LOW BATTERY)
	BSF        TRISC0_bit+0, 0
;Controlador5A.c,168 :: 		TRISC1_bit = 1; //RADIO INPUT2(CCP4)
	BSF        TRISC1_bit+0, 1
;Controlador5A.c,169 :: 		TRISC2_bit = 1; //ERROR FLAG2
	BSF        TRISC2_bit+0, 2
;Controlador5A.c,170 :: 		TRISC3_bit = 1; //ERROR FLAG1
	BSF        TRISC3_bit+0, 3
;Controlador5A.c,171 :: 		TRISC4_bit = 0; //PWM OUTPUT(P1B)
	BCF        TRISC4_bit+0, 4
;Controlador5A.c,172 :: 		TRISC5_bit = 0; //PWM OUTPUT(P1A)
	BCF        TRISC5_bit+0, 5
;Controlador5A.c,176 :: 		GIE_bit    = 0X01;   //Habilita a interrupcao Global
	BSF        GIE_bit+0, 7
;Controlador5A.c,177 :: 		PEIE_bit   = 0X01;   //Habilita a interrupcao por perifericos
	BSF        PEIE_bit+0, 6
;Controlador5A.c,178 :: 		CCP3IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP3(RADIO INPUT1)
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,179 :: 		CCP4IE_bit  = 0x01;  //Habilita interrupcoes do modulo CCP4(RADIO INPUT2)
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,180 :: 		CCP3CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,181 :: 		CCP4CON     = 0x05;  //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,183 :: 		}
L_end_setup_port:
	RETURN
; end of _setup_port

_failSafeCheck:

;Controlador5A.c,185 :: 		unsigned failSafeCheck(){ //confere se ainda esta recebendo sinal
;Controlador5A.c,186 :: 		if((micros() - last_measure) > FAIL_SAFE_TIME )//compara o tempo do ultimo sinal recebido
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
	GOTO       L__failSafeCheck80
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck80
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__failSafeCheck80
	MOVF       R4, 0
	SUBLW      128
L__failSafeCheck80:
	BTFSC      STATUS+0, 0
	GOTO       L_failSafeCheck9
;Controlador5A.c,187 :: 		return 1;
	MOVLW      1
	MOVWF      R0
	MOVLW      0
	MOVWF      R1
	GOTO       L_end_failSafeCheck
L_failSafeCheck9:
;Controlador5A.c,188 :: 		return 0;
	CLRF       R0
	CLRF       R1
;Controlador5A.c,189 :: 		}
L_end_failSafeCheck:
	RETURN
; end of _failSafeCheck

_PulseIn1:

;Controlador5A.c,191 :: 		unsigned long long PulseIn1(){  //funcao que calculava, via software, o pulso recebido
;Controlador5A.c,193 :: 		flag = micros();
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      PulseIn1_flag_L0+0
	MOVF       R1, 0
	MOVWF      PulseIn1_flag_L0+1
	MOVF       R2, 0
	MOVWF      PulseIn1_flag_L0+2
	MOVF       R3, 0
	MOVWF      PulseIn1_flag_L0+3
;Controlador5A.c,194 :: 		while(RADIO_IN1){   //garante que nao pegamos o sinal na metade, espera o sinal acabar para medi-lo de novo
L_PulseIn110:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn111
;Controlador5A.c,195 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn182
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn182
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn182
	MOVF       R4, 0
	SUBLW      128
L__PulseIn182:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn112
;Controlador5A.c,196 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn112:
;Controlador5A.c,197 :: 		}
	GOTO       L_PulseIn110
L_PulseIn111:
;Controlador5A.c,198 :: 		while(RADIO_IN1 == 0){   //espera o sinal
L_PulseIn113:
	BTFSC      RA2_bit+0, 2
	GOTO       L_PulseIn114
;Controlador5A.c,199 :: 		if((micros() - flag) > FAIL_SAFE_TIME) //flag de nao recebimento do sinal
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
	GOTO       L__PulseIn183
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn183
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn183
	MOVF       R4, 0
	SUBLW      128
L__PulseIn183:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn115
;Controlador5A.c,200 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn115:
;Controlador5A.c,201 :: 		}
	GOTO       L_PulseIn113
L_PulseIn114:
;Controlador5A.c,202 :: 		t1_sig1 = micros(); //mede o inicio do sinal
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,203 :: 		while(RADIO_IN1){   //espera o sinal acabar
L_PulseIn116:
	BTFSS      RA2_bit+0, 2
	GOTO       L_PulseIn117
;Controlador5A.c,204 :: 		if((micros() - flag) > FAIL_SAFE_TIME)//flag de nao recebimento do sinal
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
	GOTO       L__PulseIn184
	MOVF       R6, 0
	SUBLW      30
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn184
	MOVF       R5, 0
	SUBLW      132
	BTFSS      STATUS+0, 2
	GOTO       L__PulseIn184
	MOVF       R4, 0
	SUBLW      128
L__PulseIn184:
	BTFSC      STATUS+0, 0
	GOTO       L_PulseIn118
;Controlador5A.c,205 :: 		return 0;
	CLRF       R0
	CLRF       R1
	CLRF       R2
	CLRF       R3
	GOTO       L_end_PulseIn1
L_PulseIn118:
;Controlador5A.c,206 :: 		}
	GOTO       L_PulseIn116
L_PulseIn117:
;Controlador5A.c,207 :: 		t1_sig1 = micros() - t1_sig1;//faz a diferenca entre as duas medidas de tempo
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
;Controlador5A.c,209 :: 		return t1_sig1;
;Controlador5A.c,210 :: 		}
L_end_PulseIn1:
	RETURN
; end of _PulseIn1

_map:

;Controlador5A.c,213 :: 		long map(long x, long in_min, long in_max, long out_min, long out_max)
;Controlador5A.c,215 :: 		return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
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
;Controlador5A.c,216 :: 		}
L_end_map:
	RETURN
; end of _map

_rotateMotor:

;Controlador5A.c,217 :: 		void rotateMotor(){
;Controlador5A.c,220 :: 		pulseWidth = t2_sig1;   //le o pulso do canal 1
	MOVF       _t2_sig1+0, 0
	MOVWF      rotateMotor_pulseWidth_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      rotateMotor_pulseWidth_L0+1
;Controlador5A.c,223 :: 		if(pulseWidth < MIN_CH_DURATION)
	MOVLW      3
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor87
	MOVLW      236
	SUBWF      _t2_sig1+0, 0
L__rotateMotor87:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor19
;Controlador5A.c,224 :: 		pulseWidth = MIN_CH_DURATION;
	MOVLW      236
	MOVWF      rotateMotor_pulseWidth_L0+0
	MOVLW      3
	MOVWF      rotateMotor_pulseWidth_L0+1
L_rotateMotor19:
;Controlador5A.c,225 :: 		if(pulseWidth > MAX_CH_DURATION)
	MOVF       rotateMotor_pulseWidth_L0+1, 0
	SUBLW      7
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor88
	MOVF       rotateMotor_pulseWidth_L0+0, 0
	SUBLW      135
L__rotateMotor88:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor20
;Controlador5A.c,226 :: 		pulseWidth = MAX_CH_DURATION;
	MOVLW      135
	MOVWF      rotateMotor_pulseWidth_L0+0
	MOVLW      7
	MOVWF      rotateMotor_pulseWidth_L0+1
L_rotateMotor20:
;Controlador5A.c,229 :: 		duty_cycle = map(pulseWidth,MIN_CH_DURATION,MAX_CH_DURATION,MIN_PWM,MAX_PWM);
	MOVF       rotateMotor_pulseWidth_L0+0, 0
	MOVWF      FARG_map_x+0
	MOVF       rotateMotor_pulseWidth_L0+1, 0
	MOVWF      FARG_map_x+1
	CLRF       FARG_map_x+2
	CLRF       FARG_map_x+3
	MOVLW      236
	MOVWF      FARG_map_in_min+0
	MOVLW      3
	MOVWF      FARG_map_in_min+1
	CLRF       FARG_map_in_min+2
	CLRF       FARG_map_in_min+3
	MOVLW      135
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
	MOVWF      rotateMotor_duty_cycle_L0+0
	MOVF       R1, 0
	MOVWF      rotateMotor_duty_cycle_L0+1
;Controlador5A.c,231 :: 		if(duty_cycle >= 0){
	MOVLW      128
	XORWF      R1, 0
	MOVWF      R4
	MOVLW      128
	SUBWF      R4, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor89
	MOVLW      0
	SUBWF      R0, 0
L__rotateMotor89:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor21
;Controlador5A.c,232 :: 		pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,233 :: 		set_duty_cycle(1,duty_cycle);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,234 :: 		}
	GOTO       L_rotateMotor22
L_rotateMotor21:
;Controlador5A.c,236 :: 		duty_cycle = -duty_cycle;
	MOVF       rotateMotor_duty_cycle_L0+0, 0
	SUBLW      0
	MOVWF      rotateMotor_duty_cycle_L0+0
	MOVF       rotateMotor_duty_cycle_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor_duty_cycle_L0+1
	SUBWF      rotateMotor_duty_cycle_L0+1, 1
;Controlador5A.c,237 :: 		pwm_steering(1,2);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,238 :: 		set_duty_cycle(1,duty_cycle);            //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor_duty_cycle_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor_duty_cycle_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,239 :: 		}
L_rotateMotor22:
;Controlador5A.c,242 :: 		}
L_end_rotateMotor:
	RETURN
; end of _rotateMotor

_rotateMotor1:

;Controlador5A.c,243 :: 		void rotateMotor1(unsigned long long pulseWidth){  // funcao ainda nao testada
;Controlador5A.c,245 :: 		dc = (pulseWidth-1000);
	MOVLW      232
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
	MOVWF      rotateMotor1_dc_L0+0
	MOVLW      3
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       rotateMotor1_dc_L0+1
	SUBWF      rotateMotor1_dc_L0+1, 1
;Controlador5A.c,246 :: 		if(pulseWidth >= 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor191
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor191
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor191
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor191:
	BTFSS      STATUS+0, 0
	GOTO       L_rotateMotor123
;Controlador5A.c,247 :: 		dc = (dc - 500);
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
;Controlador5A.c,248 :: 		dc = dc*255/500;
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
;Controlador5A.c,249 :: 		pwm_steering(1,1);                        //coloca no sentido anti horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      1
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,250 :: 		set_duty_cycle(1,dc);                     //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,251 :: 		}
L_rotateMotor123:
;Controlador5A.c,252 :: 		if(pulseWidth < 1500){
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor192
	MOVLW      0
	SUBWF      FARG_rotateMotor1_pulseWidth+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor192
	MOVLW      5
	SUBWF      FARG_rotateMotor1_pulseWidth+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotateMotor192
	MOVLW      220
	SUBWF      FARG_rotateMotor1_pulseWidth+0, 0
L__rotateMotor192:
	BTFSC      STATUS+0, 0
	GOTO       L_rotateMotor124
;Controlador5A.c,253 :: 		dc = (500 - dc);
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
;Controlador5A.c,254 :: 		dc = dc*255/500;
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
;Controlador5A.c,255 :: 		pwm_steering(1,2);                       //coloca no sentido horario de rotacao
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,256 :: 		set_duty_cycle(1,dc);                    //aplica o duty cycle
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVF       rotateMotor1_dc_L0+0, 0
	MOVWF      FARG_set_duty_cycle_duty+0
	MOVF       rotateMotor1_dc_L0+1, 0
	MOVWF      FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,257 :: 		}
L_rotateMotor124:
;Controlador5A.c,259 :: 		}
L_end_rotateMotor1:
	RETURN
; end of _rotateMotor1

_interrupt:
	CLRF       PCLATH+0
	CLRF       STATUS+0

;Controlador5A.c,265 :: 		void interrupt()
;Controlador5A.c,267 :: 		if(TMR1IF_bit)            //interrupcao pelo estouro do Timer1
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt25
;Controlador5A.c,269 :: 		TMR1IF_bit = 0;          //Limpa a flag de interrupcao
	BCF        TMR1IF_bit+0, 0
;Controlador5A.c,270 :: 		n_interrupts_timer1++;   //incrementa a flag do overflow do timer1
	INCF       _n_interrupts_timer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _n_interrupts_timer1+1, 1
;Controlador5A.c,271 :: 		}
L_interrupt25:
;Controlador5A.c,273 :: 		if(CCP3IF_bit && CCP3CON.B0)            //Interrupcao do modulo CCP3 e modo de captura configurado para borda de subida?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt28
	BTFSS      CCP3CON+0, 0
	GOTO       L_interrupt28
L__interrupt64:
;Controlador5A.c,275 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,276 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,277 :: 		CCP3CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP3CON+0
;Controlador5A.c,278 :: 		t1_sig1     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig1+0
	MOVF       R1, 0
	MOVWF      _t1_sig1+1
	MOVF       R2, 0
	MOVWF      _t1_sig1+2
	MOVF       R3, 0
	MOVWF      _t1_sig1+3
;Controlador5A.c,279 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,280 :: 		} //end if
	GOTO       L_interrupt29
L_interrupt28:
;Controlador5A.c,281 :: 		else if(CCP3IF_bit)                     //Interrupcao do modulo CCP3?
	BTFSS      CCP3IF_bit+0, 4
	GOTO       L_interrupt30
;Controlador5A.c,283 :: 		CCP3IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP3IF_bit+0, 4
;Controlador5A.c,284 :: 		CCP3IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP3IE_bit+0, 4
;Controlador5A.c,285 :: 		CCP3CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP3CON+0
;Controlador5A.c,286 :: 		t2_sig1     = micros() - t1_sig1;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,287 :: 		CCP3IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP3IE_bit+0, 4
;Controlador5A.c,288 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,289 :: 		} //end else
L_interrupt30:
L_interrupt29:
;Controlador5A.c,291 :: 		if(CCP4IF_bit && CCP4CON.B0)            //Interrupcao do modulo CCP4 e modo de captura configurado para borda de subida?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt33
	BTFSS      CCP4CON+0, 0
	GOTO       L_interrupt33
L__interrupt63:
;Controlador5A.c,293 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,294 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,295 :: 		CCP4CON     = 0x04;                    //Configura captura por borda de descida
	MOVLW      4
	MOVWF      CCP4CON+0
;Controlador5A.c,296 :: 		t1_sig2     = micros();                //Guarda o valor do timer1 da primeira captura.
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _t1_sig2+0
	MOVF       R1, 0
	MOVWF      _t1_sig2+1
	MOVF       R2, 0
	MOVWF      _t1_sig2+2
	MOVF       R3, 0
	MOVWF      _t1_sig2+3
;Controlador5A.c,297 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,298 :: 		} //end if
	GOTO       L_interrupt34
L_interrupt33:
;Controlador5A.c,299 :: 		else if(CCP4IF_bit)                     //Interrupcao do modulo CCP4?
	BTFSS      CCP4IF_bit+0, 5
	GOTO       L_interrupt35
;Controlador5A.c,301 :: 		CCP4IF_bit  = 0x00;                    //Limpa a flag para nova captura
	BCF        CCP4IF_bit+0, 5
;Controlador5A.c,302 :: 		CCP4IE_bit  = 0x00;                    //Desabilita interrupcao do periferico CCP
	BCF        CCP4IE_bit+0, 5
;Controlador5A.c,303 :: 		CCP4CON     = 0x05;                    //Configura captura por borda de subida
	MOVLW      5
	MOVWF      CCP4CON+0
;Controlador5A.c,304 :: 		t2_sig2     = micros() - t1_sig2;      //Guarda o valor do timer1 da segunda captura.
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
;Controlador5A.c,305 :: 		CCP4IE_bit  = 0x01;                    //Habilita interrupcao do periferico CCP
	BSF        CCP4IE_bit+0, 5
;Controlador5A.c,306 :: 		last_measure = micros();               //guarda o tempo da ultima medida para o controle fail safe
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      _last_measure+0
	MOVF       R1, 0
	MOVWF      _last_measure+1
	MOVF       R2, 0
	MOVWF      _last_measure+2
	MOVF       R3, 0
	MOVWF      _last_measure+3
;Controlador5A.c,307 :: 		} //end else  */
L_interrupt35:
L_interrupt34:
;Controlador5A.c,308 :: 		} //end interrupt
L_end_interrupt:
L__interrupt94:
	RETFIE     %s
; end of _interrupt

_error_led_blink:

;Controlador5A.c,310 :: 		void error_led_blink(unsigned time_ms){
;Controlador5A.c,312 :: 		time_ms = time_ms/250; //4 blinks por segundo
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
;Controlador5A.c,313 :: 		for(i=0; i< time_ms; i++){
	CLRF       error_led_blink_i_L0+0
	CLRF       error_led_blink_i_L0+1
L_error_led_blink36:
	MOVF       FARG_error_led_blink_time_ms+1, 0
	SUBWF      error_led_blink_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__error_led_blink96
	MOVF       FARG_error_led_blink_time_ms+0, 0
	SUBWF      error_led_blink_i_L0+0, 0
L__error_led_blink96:
	BTFSC      STATUS+0, 0
	GOTO       L_error_led_blink37
;Controlador5A.c,314 :: 		ERROR_LED = 1;
	BSF        RA1_bit+0, 1
;Controlador5A.c,315 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink39:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink39
	DECFSZ     R12, 1
	GOTO       L_error_led_blink39
	DECFSZ     R11, 1
	GOTO       L_error_led_blink39
;Controlador5A.c,316 :: 		ERROR_LED = 0;
	BCF        RA1_bit+0, 1
;Controlador5A.c,317 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11
	MOVLW      8
	MOVWF      R12
	MOVLW      119
	MOVWF      R13
L_error_led_blink40:
	DECFSZ     R13, 1
	GOTO       L_error_led_blink40
	DECFSZ     R12, 1
	GOTO       L_error_led_blink40
	DECFSZ     R11, 1
	GOTO       L_error_led_blink40
;Controlador5A.c,313 :: 		for(i=0; i< time_ms; i++){
	INCF       error_led_blink_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       error_led_blink_i_L0+1, 1
;Controlador5A.c,318 :: 		}
	GOTO       L_error_led_blink36
L_error_led_blink37:
;Controlador5A.c,319 :: 		}
L_end_error_led_blink:
	RETURN
; end of _error_led_blink

_calibration:

;Controlador5A.c,320 :: 		void calibration(){
;Controlador5A.c,328 :: 		signal1_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal1_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal1_L_value_L0+1
;Controlador5A.c,329 :: 		signal2_L_value = 20000;                    //Tempo maximo, frequencia = 50 ... T=20ms
	MOVLW      32
	MOVWF      calibration_signal2_L_value_L0+0
	MOVLW      78
	MOVWF      calibration_signal2_L_value_L0+1
;Controlador5A.c,330 :: 		signal1_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal1_H_value_L0+0
	CLRF       calibration_signal1_H_value_L0+1
;Controlador5A.c,331 :: 		signal2_H_value = 0;                        //Tempo minimo
	CLRF       calibration_signal2_H_value_L0+0
	CLRF       calibration_signal2_H_value_L0+1
;Controlador5A.c,332 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,333 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA1_bit+0, 1
;Controlador5A.c,335 :: 		while((micros() - time_control) < 2000000){
L_calibration41:
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
	GOTO       L__calibration98
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration98
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration98
	MOVLW      128
	SUBWF      R4, 0
L__calibration98:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration42
;Controlador5A.c,336 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,337 :: 		if(signal_T_value < signal1_L_value)
	MOVF       calibration_signal1_L_value_L0+1, 0
	SUBWF      _t2_sig1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration99
	MOVF       calibration_signal1_L_value_L0+0, 0
	SUBWF      _t2_sig1+0, 0
L__calibration99:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration43
;Controlador5A.c,338 :: 		signal1_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_L_value_L0+1
L_calibration43:
;Controlador5A.c,340 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal2
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,341 :: 		if(signal_T_value < signal2_L_value)
	MOVF       calibration_signal2_L_value_L0+1, 0
	SUBWF      _t2_sig2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration100
	MOVF       calibration_signal2_L_value_L0+0, 0
	SUBWF      _t2_sig2+0, 0
L__calibration100:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration44
;Controlador5A.c,342 :: 		signal2_L_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_L_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_L_value_L0+1
L_calibration44:
;Controlador5A.c,343 :: 		}
	GOTO       L_calibration41
L_calibration42:
;Controlador5A.c,347 :: 		lower_8bits = signal1_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,348 :: 		upper_8bits = (signal1_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,349 :: 		EEPROM_Write(0X00,lower_8bits);
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,350 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration45:
	DECFSZ     R13, 1
	GOTO       L_calibration45
	DECFSZ     R12, 1
	GOTO       L_calibration45
	NOP
;Controlador5A.c,351 :: 		EEPROM_Write(0X01,upper_8bits);
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,352 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration46:
	DECFSZ     R13, 1
	GOTO       L_calibration46
	DECFSZ     R12, 1
	GOTO       L_calibration46
	NOP
;Controlador5A.c,355 :: 		lower_8bits = signal2_L_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_L_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,356 :: 		upper_8bits = (signal2_L_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_L_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,357 :: 		EEPROM_Write(0X02,lower_8bits);
	MOVLW      2
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,358 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration47:
	DECFSZ     R13, 1
	GOTO       L_calibration47
	DECFSZ     R12, 1
	GOTO       L_calibration47
	NOP
;Controlador5A.c,359 :: 		EEPROM_Write(0X03,upper_8bits);
	MOVLW      3
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,360 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration48:
	DECFSZ     R13, 1
	GOTO       L_calibration48
	DECFSZ     R12, 1
	GOTO       L_calibration48
	NOP
;Controlador5A.c,362 :: 		error_led_blink(1600);                      //indica a captura do valor minimo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,363 :: 		time_control = micros();                    //controla o tempo de captura
	CALL       _micros+0
	MOVF       R0, 0
	MOVWF      calibration_time_control_L0+0
	MOVF       R1, 0
	MOVWF      calibration_time_control_L0+1
	MOVF       R2, 0
	MOVWF      calibration_time_control_L0+2
	MOVF       R3, 0
	MOVWF      calibration_time_control_L0+3
;Controlador5A.c,364 :: 		ERROR_LED = 1;                              //indica a captura do pulso
	BSF        RA1_bit+0, 1
;Controlador5A.c,365 :: 		while((micros() - time_control) < 2000000){
L_calibration49:
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
	GOTO       L__calibration101
	MOVLW      30
	SUBWF      R6, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration101
	MOVLW      132
	SUBWF      R5, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration101
	MOVLW      128
	SUBWF      R4, 0
L__calibration101:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration50
;Controlador5A.c,366 :: 		signal_T_value = (unsigned) t2_sig1;   //valor da largura do pulso do canal1
	MOVF       _t2_sig1+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig1+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,367 :: 		if(signal_T_value > signal1_H_value)
	MOVF       _t2_sig1+1, 0
	SUBWF      calibration_signal1_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration102
	MOVF       _t2_sig1+0, 0
	SUBWF      calibration_signal1_H_value_L0+0, 0
L__calibration102:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration51
;Controlador5A.c,368 :: 		signal1_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal1_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal1_H_value_L0+1
L_calibration51:
;Controlador5A.c,370 :: 		signal_T_value = (unsigned) t2_sig2;   //valor da largura do pulso do canal1
	MOVF       _t2_sig2+0, 0
	MOVWF      calibration_signal_T_value_L0+0
	MOVF       _t2_sig2+1, 0
	MOVWF      calibration_signal_T_value_L0+1
;Controlador5A.c,371 :: 		if(signal_T_value > signal2_H_value)
	MOVF       _t2_sig2+1, 0
	SUBWF      calibration_signal2_H_value_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration103
	MOVF       _t2_sig2+0, 0
	SUBWF      calibration_signal2_H_value_L0+0, 0
L__calibration103:
	BTFSC      STATUS+0, 0
	GOTO       L_calibration52
;Controlador5A.c,372 :: 		signal2_H_value = signal_T_value;
	MOVF       calibration_signal_T_value_L0+0, 0
	MOVWF      calibration_signal2_H_value_L0+0
	MOVF       calibration_signal_T_value_L0+1, 0
	MOVWF      calibration_signal2_H_value_L0+1
L_calibration52:
;Controlador5A.c,373 :: 		}
	GOTO       L_calibration49
L_calibration50:
;Controlador5A.c,375 :: 		lower_8bits = signal1_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal1_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,376 :: 		upper_8bits = (signal1_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal1_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,377 :: 		EEPROM_Write(0X04,lower_8bits);
	MOVLW      4
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,378 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_calibration53:
	DECFSZ     R13, 1
	GOTO       L_calibration53
	DECFSZ     R12, 1
	GOTO       L_calibration53
	NOP
;Controlador5A.c,379 :: 		EEPROM_Write(0X05,upper_8bits);
	MOVLW      5
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,380 :: 		delay_ms(10);
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
;Controlador5A.c,382 :: 		lower_8bits = signal2_H_value & 0xff;        //seleciona os 8 bits menos significativos
	MOVLW      255
	ANDWF      calibration_signal2_H_value_L0+0, 0
	MOVWF      R3
	MOVF       R3, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,383 :: 		upper_8bits = (signal2_H_value >> 8) & 0xff; //seleciona os 8 bits mais significativos
	MOVF       calibration_signal2_H_value_L0+1, 0
	MOVWF      R0
	CLRF       R1
	MOVLW      255
	ANDWF      R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,384 :: 		EEPROM_Write(0X06,lower_8bits);
	MOVLW      6
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       R3, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,385 :: 		delay_ms(10);
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
;Controlador5A.c,386 :: 		EEPROM_Write(0X07,upper_8bits);
	MOVLW      7
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _upper_8bits+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Controlador5A.c,387 :: 		delay_ms(10);
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
;Controlador5A.c,389 :: 		error_led_blink(1600);                      //indica a captura do valor maximo
	MOVLW      64
	MOVWF      FARG_error_led_blink_time_ms+0
	MOVLW      6
	MOVWF      FARG_error_led_blink_time_ms+1
	CALL       _error_led_blink+0
;Controlador5A.c,390 :: 		ERROR_LED = 0;
	BCF        RA1_bit+0, 1
;Controlador5A.c,391 :: 		}
L_end_calibration:
	RETURN
; end of _calibration

_read_eeprom_signals_data:

;Controlador5A.c,393 :: 		void read_eeprom_signals_data(){
;Controlador5A.c,397 :: 		UART1_write_text("LOW channel1: ");
	MOVLW      ?lstr1_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,398 :: 		lower_8bits = EEPROM_Read(0X00);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,399 :: 		upper_8bits = EEPROM_Read(0X01);
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,400 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,401 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,402 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,403 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr2_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,404 :: 		lower_8bits = EEPROM_Read(0X02);
	MOVLW      2
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,405 :: 		upper_8bits = EEPROM_Read(0X03);
	MOVLW      3
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,406 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,407 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,408 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,409 :: 		UART1_write_text("\t");
	MOVLW      ?lstr3_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,410 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data57:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data57
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data57
	NOP
;Controlador5A.c,412 :: 		UART1_write_text("HIGH channel1: ");
	MOVLW      ?lstr4_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,413 :: 		lower_8bits = EEPROM_Read(0X04);
	MOVLW      4
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,414 :: 		upper_8bits = EEPROM_Read(0X05);
	MOVLW      5
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,415 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,416 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,417 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,418 :: 		UART1_write_text(" channel2: ");
	MOVLW      ?lstr5_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,419 :: 		lower_8bits = EEPROM_Read(0X06);
	MOVLW      6
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _lower_8bits+0
;Controlador5A.c,420 :: 		upper_8bits = EEPROM_Read(0X07);
	MOVLW      7
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0, 0
	MOVWF      _upper_8bits+0
;Controlador5A.c,421 :: 		signal_value = (upper_8bits << 8) | lower_8bits;
	MOVF       R0, 0
	MOVWF      FARG_WordToStr_input+1
	CLRF       FARG_WordToStr_input+0
	MOVF       _lower_8bits+0, 0
	IORWF       FARG_WordToStr_input+0, 1
	MOVLW      0
	IORWF       FARG_WordToStr_input+1, 1
;Controlador5A.c,422 :: 		WordToStr(signal_value, buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_WordToStr_output+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_WordToStr_output+1
	CALL       _WordToStr+0
;Controlador5A.c,423 :: 		UART1_write_text(buffer);
	MOVLW      read_eeprom_signals_data_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(read_eeprom_signals_data_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,424 :: 		UART1_write_text("\n");
	MOVLW      ?lstr6_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,425 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12
	MOVLW      248
	MOVWF      R13
L_read_eeprom_signals_data58:
	DECFSZ     R13, 1
	GOTO       L_read_eeprom_signals_data58
	DECFSZ     R12, 1
	GOTO       L_read_eeprom_signals_data58
	NOP
;Controlador5A.c,426 :: 		}
L_end_read_eeprom_signals_data:
	RETURN
; end of _read_eeprom_signals_data

_print_signal_received:

;Controlador5A.c,428 :: 		void print_signal_received(){
;Controlador5A.c,431 :: 		UART1_write_text("Sinal 1: ");
	MOVLW      ?lstr7_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,432 :: 		LongWordToStr(t2_sig1, buffer);
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
;Controlador5A.c,433 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,434 :: 		UART1_write_text("\t");
	MOVLW      ?lstr8_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,436 :: 		UART1_write_text("Sinal 2: ");
	MOVLW      ?lstr9_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,437 :: 		LongWordToStr(t2_sig2, buffer);
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
;Controlador5A.c,438 :: 		UART1_write_text(buffer);
	MOVLW      print_signal_received_buffer_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(print_signal_received_buffer_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,439 :: 		UART1_write_text("\n");
	MOVLW      ?lstr10_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,441 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11
	MOVLW      4
	MOVWF      R12
	MOVLW      186
	MOVWF      R13
L_print_signal_received59:
	DECFSZ     R13, 1
	GOTO       L_print_signal_received59
	DECFSZ     R12, 1
	GOTO       L_print_signal_received59
	DECFSZ     R11, 1
	GOTO       L_print_signal_received59
	NOP
;Controlador5A.c,442 :: 		}
L_end_print_signal_received:
	RETURN
; end of _print_signal_received

_main:

;Controlador5A.c,444 :: 		void main() {
;Controlador5A.c,445 :: 		OSCCON = 0b01110010; //Coloca o oscillador interno a 8Mz. NAO APAGAR ESSA LINHA (talvez muda-la pra dentro do setup_port)
	MOVLW      114
	MOVWF      OSCCON+0
;Controlador5A.c,446 :: 		setup_port();
	CALL       _setup_port+0
;Controlador5A.c,447 :: 		setup_pwms();
	CALL       _setup_pwms+0
;Controlador5A.c,448 :: 		setup_Timer_1();
	CALL       _setup_Timer_1+0
;Controlador5A.c,449 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr11_Controlador5A+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr11_Controlador5A+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;Controlador5A.c,450 :: 		pwm_steering(1,2);
	MOVLW      1
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,451 :: 		pwm_steering(2,2);
	MOVLW      2
	MOVWF      FARG_pwm_steering_channel+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_channel+1
	MOVLW      2
	MOVWF      FARG_pwm_steering_port+0
	MOVLW      0
	MOVWF      FARG_pwm_steering_port+1
	CALL       _pwm_steering+0
;Controlador5A.c,452 :: 		set_duty_cycle(1, 0);
	MOVLW      1
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	CLRF       FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,453 :: 		set_duty_cycle(2, 255);
	MOVLW      2
	MOVWF      FARG_set_duty_cycle_channel+0
	MOVLW      0
	MOVWF      FARG_set_duty_cycle_channel+1
	MOVLW      255
	MOVWF      FARG_set_duty_cycle_duty+0
	CLRF       FARG_set_duty_cycle_duty+1
	CALL       _set_duty_cycle+0
;Controlador5A.c,454 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11
	MOVLW      38
	MOVWF      R12
	MOVLW      93
	MOVWF      R13
L_main60:
	DECFSZ     R13, 1
	GOTO       L_main60
	DECFSZ     R12, 1
	GOTO       L_main60
	DECFSZ     R11, 1
	GOTO       L_main60
	NOP
	NOP
;Controlador5A.c,455 :: 		t2_sig2 = 20000;
	MOVLW      32
	MOVWF      _t2_sig2+0
	MOVLW      78
	MOVWF      _t2_sig2+1
	CLRF       _t2_sig2+2
	CLRF       _t2_sig2+3
;Controlador5A.c,456 :: 		t2_sig1 = 20000;
	MOVLW      32
	MOVWF      _t2_sig1+0
	MOVLW      78
	MOVWF      _t2_sig1+1
	CLRF       _t2_sig1+2
	CLRF       _t2_sig1+3
;Controlador5A.c,458 :: 		while(1){
L_main61:
;Controlador5A.c,459 :: 		char *txt = "mikroe \n";
;Controlador5A.c,466 :: 		print_signal_received();
	CALL       _print_signal_received+0
;Controlador5A.c,517 :: 		}
	GOTO       L_main61
;Controlador5A.c,518 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
