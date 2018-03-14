#line 1 "D:/GitHub/Controlador5A/timeMeasure.c"
#line 1 "d:/github/controlador5a/constants.h"
#line 1 "d:/github/controlador5a/timemeasure.h"

typedef struct timeMeasure {unsigned int n_overflows, time_reg;} TimeMeasure;
TimeMeasure microsT(unsigned int);
unsigned int timeDifference(TimeMeasure , TimeMeasure );
#line 6 "D:/GitHub/Controlador5A/timeMeasure.c"
TimeMeasure microsT(unsigned int n_interruptions){
 TimeMeasure measure;
 measure.time_reg = (TMR1H <<8 | TMR1L);
 measure.n_overflows = n_interruptions;
 return measure;
}
unsigned int timeDifference(TimeMeasure measure1, TimeMeasure measure2){
 return ((measure2.n_overflows - measure2.n_overflows)*OVERFLOW_CONST + (measure2.time_reg - measure1.time_reg));
}
