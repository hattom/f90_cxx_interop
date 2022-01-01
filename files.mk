F90SRC = main.F90 \
   sorting.F90
CXXSRC = sort_cxx.cxx
CSRC =

F90OBJ  = $(addprefix $(OBJSUBDIR)/,$(F90SRC:.F90=.o))
CXXOBJ    = $(addprefix $(OBJSUBDIR)/,$(CXXSRC:.cxx=.o))
COBJ    = $(addprefix $(OBJSUBDIR)/,$(CSRC:.c=.o))
OBJLIST = $(F90OBJ) $(COBJ) $(CXXOBJ)
export OBJLIST

$(OBJSUBDIR)/main.o: $(addprefix $(OBJSUBDIR)/, \
   sorting.o \
   sort_cxx.o )
