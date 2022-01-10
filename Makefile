SHELL := /bin/bash

SRCDIR = src
BINDIR = bin
OBJSUBDIR = obj

CC = gcc
FC = gfortran
CXX = g++
FFLAGS = -O2 -Wall -fbounds-check -J$(OBJSUBDIR)
CXXFLAGS = -O2 -Wall
LDFLAGS = -lgfortran -lstdc++ # allows linking to be done with either CC, FC, or CXX
LD = $(CC)

FFTW ?= TRUE
ifeq ($(FFTW), TRUE)
	FFTW_INC = -I/usr/include
	FFLAGS += $(FFTW_INC) -DFFTW
	FFTW_LIB = -L/usr/lib -lfftw3f
	LDFLAGS += $(FFTW_LIB)
endif

# Set reprod to true to fix the seed for testing
REPROD ?= FALSE
ifeq ($(REPROD), TRUE)
  FFLAGS += -DREPROD
endif

EXEC = bin/main
.DEFAULT_GOAL = all
.PHONY: all clean

all: $(EXEC)
## File lists and dependencies
include files.mk

$(EXEC): $(OBJLIST)
	@test -d $(@D) || mkdir -p $(@D)
	$(LD) -o $@ $^ $(LDFLAGS)

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.F90
	@test -d $(@D) || mkdir -p $(@D)
	$(FC) $(FFLAGS) $(F90INCLUDES)  -c -o $@ $<

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.f90
	@test -d $(@D) || mkdir -p $(@D)
	$(FC) $(FFLAGS) $(F90INCLUDES) -c -o $@ $<

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.f
	@test -d $(@D) || mkdir -p $(@D)
	$(FC) $(FFLAGS) $(F90INCLUDES) -c -o $@ $<

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.c
	@test -d $(@D) || mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.cxx $(SRCDIR)/%.hxx
	@test -d $(@D) || mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(OBJSUBDIR)/%.o: $(SRCDIR)/%.cu
	@test -d $(@D) || mkdir -p $(@D)
	$(CUC) $(CUDAFLAGS) -c -o $@ $<

clean:
	-rm -rf $(OBJSUBDIR)
