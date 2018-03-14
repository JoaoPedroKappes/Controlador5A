/*** Time measuring Headers ***/
typedef struct timeMeasure {unsigned int n_overflows, time_reg;} TimeMeasure;
TimeMeasure microsT(unsigned int);
unsigned int timeDifference(TimeMeasure , TimeMeasure );