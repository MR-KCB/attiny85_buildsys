# 1. Table of Contents
- [1. Table of Contents](#1-table-of-contents)
- [2. Introduction](#2-introduction)
- [3. Goal](#3-goal)
- [4. How to use](#4-how-to-use)
	- [4.1. Adding a new folder](#41-adding-a-new-folder)
	- [4.2. How to compile](#42-how-to-compile)
	- [4.3. Upload tool micronucleus](#43-upload-tool-micronucleus)
	- [4.4. Makefile](#44-makefile)
		- [4.4.1. cfg.mak](#441-cfgmak)
		- [4.4.2. set_path.mak](#442-set_pathmak)
		- [4.4.3. build.mak](#443-buildmak)
- [5. Hardware compatible](#5-hardware-compatible)
- [6. Drivers for Attiny85](#6-drivers-for-attiny85)

# 2. Introduction 
Build system for Attiny85, the current project was develop to generate you own libraries and project from scratch, some libraries from AVR-GCC toolchain are available, but the main purpose is generate your own components.  

# 3. Goal
The goal is to make a system with the capabilities to compile and upload your own programs with micronucluos tool and avr-gcc toolchain.

# 4. How to use
## 4.1. Adding a new folder 
If we want to add a new folder to be compiled we should add some variables into some makefiles for that check the next sections: in *Makefile* section check first *set_path.mak* and after that follow with *build.mak*

## 4.2. How to compile
In order to compile, run build.bat with the next arguments.
```
Use the build system in the next way:
./build.bat ARG1 ARG2

Where the ARG1 could be one of the next supported commands:
- all: release/debug clean upload (required the ARG2(debug/release))
- clean: clean working area
- release: compile project without debug information, generate a HEX output file
- debug: compile project with debug information, generate a HEX and ELF output file
- upload: upload executable 

The ARG2 is used in "all" command to indicate the compilation type and could be one
of the next commands:
- release: compile project without debug information, generate a HEX output file 
- debug: compile project with debug information, generate a HEX and ELF output file

E.g.
- ./build.bat all
- ./build.bat clean
- ./build.bat release
- ./build.bat upload 
```

## 4.3. Upload tool micronucleus
The build system use the avrdude to upload the compiled project, for that reason the microcontroller must have a bootloader.

The current build system is already tested with micronucleus, for more information go to: https://github.com/micronucleus/micronucleus.

## 4.4. Makefile 
The actual output file is generated with help of some makefiles as cfg.mak, set_path.mak and build.mak, in the next subsections will explain each makefile and how to configure for you own project.
### 4.4.1. cfg.mak
The configuration makefile (cfg.mak) is used to configure parameter as application output name, port, baudrate and other things like compiler flags.

Here is encapsulated almost the main configuration for output and upload the output file the system.

```
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
```

### 4.4.2. set_path.mak
The set_path makefile is used to declare all folder with our source code to be compiled, as shown in block below.

```
# Source code structure
SRC_DIR = $(CWD)\src
APP_DIR = $(SRC_DIR)\app

# Creating rules
# SRC
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(SRC))
INC_SRC = -I$(SRC_DIR) 

# APP
APP = $(wildcard $(APP_DIR)/*.c)
OBJ += $(patsubst $(APP_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(APP))
INC_APP = -I$(APP_DIR)
```

In order to add a new folder, we should add a set of variables with our new folder name and the necessary includes to compile.

- Add folder directory variable
```
# Source code structure
COMP_DIR = $(CWD)\COMP
```

- Add the rule for our new folder, the new rule shall contain a variable with C files (e.g. COMP), append the object file into OBJ variable (e.g. OBJ), and the include variable (e.g.INC_COMP) for all required files and libraries for the compilation.
```
# COMP
COMP = $(wildcard $(COMP_DIR)/*.c)
OBJ += $(patsubst $(COMP_DIR)/%.c, $(OUTPUT_DIR)/%.o, $(COMP))
INC_COMP = -I$(COMP_DIR)
```
- Add the prints for the console (optional), in def_path, def_rule, and def_includes the new variables created shall be added in order to print the information into the console.
```
def_path:
	@echo Defining directories...
	@echo $(COMP_DIR)

def_rule:
	@echo Defining rules...
	@echo $(COMP)

def_includes:
	@echo Defining includes...
	@echo $(INC_COMP)
```

### 4.4.3. build.mak
The build makefile is where all compilation rules will be called, for that reason we need to add the rule for the new folders. Go and find the next structure and add your new rule with the new folder. 
```
The structure for the rules is the next:
$(OUTPUT_DIR)/%.o: $(**COMP_DIR**)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(**INC_SRC**)

Add the new rule with the same structure only replace the the BOLD word with your own folder to be added.
$(OUTPUT_DIR)/%.o: $(**SRC_DIR**)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(**INC_COMP**)

```

# 5. Hardware compatible 
- Attiny85 (Micronucleus bootloader)

# 6. Drivers for Attiny85
The drivers could be find in the next link: https://github.com/micronucleus/micronucleus/tree/v2.6/windows_driver_installer