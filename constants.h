/*** All the constants for the Main Function ***/

  // TIMERS CONSTANTS
#define TIMER6_CONST      0.032 //cada bit do timer 6 vale 32us = 0.032ms
#define OVERFLOW_TMR6_CONST 8   //cada overflow significa 8 ms

 // Signal Constants
#define SIGNAL_PERIOD     20000   //20ms
#define SIGNAL_PERIOD_OFFSET 1000/SIGNAL_PERIOD; // 1ms/20ms
#define FAIL_SAFE_TIME    500   // 500 ms
#define MAX_CH_DURATION   1900
#define MIN_CH_DURATION   1100
#define MAX_PWM           255
#define MIN_PWM           -255
#define DEADZONE          50
#define MEAN_CH_DURATION  (MIN_CH_DURATION + MAX_CH_DURATION)/2

 // Port ALIAS
#define RADIO_IN1    RA2_bit
#define RADIO_IN2    RC1_bit
#define CALIB_BUTTON RA3_bit
#define CALIB_LED    RA1_bit
#define ERROR_LED    RA0_bit
#define LOW_BAT      4 //adc channel AN4

 // PWMS
#define P1A          RC5_bit
#define P1B          RC4_bit
#define P2A          RA5_bit
#define P2B          RA4_bit