/*** Time measuring Functios ***/
#include "constants.h"
#include "timeMeasure.h"


TimeMeasure microsT(unsigned int n_interruptions){
  TimeMeasure measure;
  measure.time_reg = (TMR1H <<8 | TMR1L);
  measure.n_overflows = n_interruptions;
  return measure;
}
unsigned int timeDifference(TimeMeasure measure1, TimeMeasure measure2){
  return ((measure2.n_overflows - measure2.n_overflows)*OVERFLOW_CONST + (measure2.time_reg - measure1.time_reg));
}