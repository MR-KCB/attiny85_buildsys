############################
## Start user configuration 
############################
# Application output name 
APPLICATION_NAME = APP
# board definition for avr-gcc compiler
MMCU = attiny85
############################
## End user configuration 
############################


# Output configuration
OUTPUT = $(APPLICATION_NAME).hex
OUTPUT_ELF =  $(subst .hex,.elf,$(OUTPUT))
MAP_FILE = $(subst .hex,.map,$(OUTPUT))


#compiler flags, compiler definitions, linker flags
CC = avr-gcc.exe
STD = -std=c99
MAP = -Wl,-Map=$(OUTPUT_DIR)\$(MAP_FILE)
GNR_FLAGS = -flto -Wall -ffunction-sections -fdata-sections -fno-exceptions \
						-Wno-error=narrowing
DEFINES_FLAGS = -D__AVR_ATtiny85__ -DF_CPU=16000000L
# -O0	optimization for compilation time (default)
# -O1 or -O	optimization for code size and execution time
# -O2	optimization more for code size and execution time
# -O3	optimization more for code size and execution time
# -Os	optimization for code size
# -Ofast	O3 with fast none accurate math calculations								 
DEBUG_INFO_FLAG = -g0
OPTIM_FLAG = -Os

CFLAGS = $(STD) -mmcu=$(MMCU) $(OPTIM_FLAG) $(DEBUG_INFO_FLAG) $(DEFINES_FLAGS) $(GNR_FLAGS)

#micronucleus config and command
MICRONUCLEUS_DIR = "$(CWD)\tools\micronucleus\micronucleus.exe"
TYPE = --type intel-hex

