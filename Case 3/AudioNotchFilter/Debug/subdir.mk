################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../AudioCallback.c \
../AudioNotchFilter.c 

SRC_OBJS += \
./AudioCallback.doj \
./AudioNotchFilter.doj 

C_DEPS += \
./AudioCallback.d \
./AudioNotchFilter.d 


# Each subdirectory must supply rules for building sources it contributes
AudioCallback.doj: ../AudioCallback.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore Blackfin C/C++ Compiler'
	ccblkfn -c -file-attr ProjectName="AudioNotchFilter" -proc ADSP-BF706 -flags-compiler --no_wrap_diagnostics -si-revision any -g -D_DEBUG -DADI_DEBUG -DNO_UTILITY_ROM -DCORE0 @includes-a1c1dc940935d78218104ec64bd87617.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -decls-strong -cplbs -no-utility-rom -gnu-style-dependencies -MD -Mo "AudioCallback.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

AudioNotchFilter.doj: ../AudioNotchFilter.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore Blackfin C/C++ Compiler'
	ccblkfn -c -file-attr ProjectName="AudioNotchFilter" -proc ADSP-BF706 -flags-compiler --no_wrap_diagnostics -si-revision any -g -D_DEBUG -DADI_DEBUG -DNO_UTILITY_ROM -DCORE0 @includes-a1c1dc940935d78218104ec64bd87617.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -decls-strong -cplbs -no-utility-rom -gnu-style-dependencies -MD -Mo "AudioNotchFilter.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


