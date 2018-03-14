
_microsT:

;timeMeasure.c,6 :: 		TimeMeasure microsT(unsigned int n_interruptions){
	MOVF       R0, 0
	MOVWF      R3+0
	MOVF       R1, 0
	MOVWF      R3+1
;timeMeasure.c,8 :: 		measure.time_reg = (TMR1H <<8 | TMR1L);
	MOVF       TMR1H+0, 0
	MOVWF      R1
	CLRF       R0
	MOVF       TMR1L+0, 0
	IORWF       R0, 1
	MOVLW      0
	IORWF       R1, 1
	MOVF       R0, 0
	MOVWF      R5+2
	MOVF       R1, 0
	MOVWF      R5+3
;timeMeasure.c,9 :: 		measure.n_overflows = n_interruptions;
	MOVF       FARG_microsT_n_interruptions+0, 0
	MOVWF      R5+0
	MOVF       FARG_microsT_n_interruptions+1, 0
	MOVWF      R5+1
;timeMeasure.c,10 :: 		return measure;
	MOVLW      4
	MOVWF      R0
	MOVF       R3+0, 0
	MOVWF      FSR1L
	MOVF       R3+1, 0
	MOVWF      FSR1H
	MOVLW      R5+0
	MOVWF      FSR0L
	MOVLW      hi_addr(R5+0)
	MOVWF      FSR0H
L_microsT0:
	MOVIW      0, 2
	MOVWI      FSR1++ 
	DECF       R0, 1
	BTFSS      STATUS+0, 2
	GOTO       L_microsT0
;timeMeasure.c,11 :: 		}
L_end_microsT:
	RETURN
; end of _microsT

_timeDifference:

;timeMeasure.c,12 :: 		unsigned int timeDifference(TimeMeasure measure1, TimeMeasure measure2){
;timeMeasure.c,13 :: 		return ((measure2.n_overflows - measure2.n_overflows)*OVERFLOW_CONST + (measure2.time_reg - measure1.time_reg));
	MOVF       FARG_timeDifference_measure1+2, 0
	SUBWF      FARG_timeDifference_measure2+2, 0
	MOVWF      R0
	MOVF       FARG_timeDifference_measure1+3, 0
	SUBWFB     FARG_timeDifference_measure2+3, 0
	MOVWF      R1
;timeMeasure.c,14 :: 		}
L_end_timeDifference:
	RETURN
; end of _timeDifference
