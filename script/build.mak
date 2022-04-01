.DEFAULT_GOAL := help
.PHONY = all clean release debug upload help

include cfg/cfg.mak
include cfg/set_path.mak


all: clean release upload

clean: 
	@echo Cleaning the working area...
	@echo "Cleaning up..."
	del /q /f /s $(OUTPUT_DIR)\*.o
	del /q /f /s $(OUTPUT_DIR)\*.map
	del /q /f /s $(OUTPUT_DIR)\*.elf
	del /q /f /s $(OUTPUT_DIR)\*.HEX

release: $(OUTPUT)
	@echo RELEASE: Done Compiling...

$(OUTPUT): $(OBJ)
	$(CC) $(CFLAGS) $(INC_MCU) $(OUTPUT_FORMAT) $(MAP) $^ -o $(OUTPUT_DIR)\$@
	avr-size.exe --format=avr --mcu=$(MMCU) $(OUTPUT_DIR)\$(OUTPUT)	
	avr-objcopy.exe -j .text -j .data -O ihex $(OUTPUT_DIR)\$@ $(OUTPUT_DIR)\$(OUTPUT)	

$(OUTPUT_ELF): $(OBJ)
	$(CC) $(CFLAGS) $(INC_MCU) $(MAP) $^ -o $(OUTPUT_DIR)\$@ 
	avr-size.exe --format=avr --mcu=$(MMCU) $(OUTPUT_DIR)\$(OUTPUT_ELF)

$(OUTPUT_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_SRC)

$(OUTPUT_DIR)/%.o: $(APP_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_APP)

$(OUTPUT_DIR)/%.o: $(MCU_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_MCU)

$(OUTPUT_DIR)/%.o: $(DEV_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_DEV)

$(OUTPUT_DIR)/%.o: $(SVC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_SVC)

$(OUTPUT_DIR)/%.o: $(AVR_LIBS_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INC_AVR_LIBS)

upload:
	@echo Upload binary to board...
	$(MICRONUCLEUS_DIR) $(TYPE) $(OUTPUT_DIR)\$(OUTPUT) 

help:
	@echo.
	@echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!HELP!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	@echo.
	@echo The next script run generate a executable for $(AVR_BOARD), in order to 
	@echo compile the current project follow the next instructions.
	@echo.
	@echo Use the build system in the next way:
	@echo ./build.bat ARG1 ARG2
	@echo.
	@echo Where the ARG1 could be one of the next supported commands:
	@echo.
	@echo - all: release clean upload
	@echo - clean: clean working area
	@echo - release: compile project without debug information, generate a HEX output file
	@echo - upload: upload executable 
	@echo.
	@echo.
	@echo E.g.
	@echo.
	@echo - ./build.bat all
	@echo - ./build.bat clean
	@echo - ./build.bat release
	@echo - ./build.bat upload 
	@echo.
	@echo Enjoy!!!