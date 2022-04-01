/*****************************************************************************/
/* File: typedefs.h                                                          */
/*                                                                           */
/* Description: Module for all interfaces declared in typedefs.c    */
/*              required for external access                                 */
/*                                                                           */
/* Date: 2021/12/30                                                          */
/*                                                                           */
/*****************************************************************************/
                                                                               
#ifndef TYPEDEFS_H                                                           
#define TYPEDEFS_H                                                           
                                                                               
/*****************************************************************************/
/* Include definitions                                                       */
/*****************************************************************************/


/*****************************************************************************/
/* typedefs definitions                                                      */
/*****************************************************************************/
typedef unsigned char   uint8;
/*typedef unsigned int    uint16; Disable int in avr-gcc looks is 16 bits as short type*/ 
typedef unsigned short  uint16;
typedef unsigned long   uint32;

typedef enum {
  kLow = 0U,
  kHigh = 1U,
  kOff = 0U,
  kOn = 1U,
  kDisable = 0U,
  kEnable = 1U,
  ktrue = 0U,
  kfalse = 1U,
} Boolean;

/*****************************************************************************/
/* External macro definitions                                                */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* External constant definitions                                             */
/*****************************************************************************/
                                                                               
                                                                               
/*****************************************************************************/
/* Prototype definitions for external access                                 */
/*****************************************************************************/
                                                                               
#endif /* TYPEDEFS_H */                                                     
                                                                               