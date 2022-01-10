F90SRC = main.F90 \
   sorting.F90 \
   sort_cxx_interface.F90
CXXSRC = sort_cxx.cxx
CSRC =

F90OBJ  = $(addprefix $(OBJSUBDIR)/,$(F90SRC:.F90=.o))
CXXOBJ  = $(addprefix $(OBJSUBDIR)/,$(CXXSRC:.cxx=.o))
COBJ    = $(addprefix $(OBJSUBDIR)/,$(CSRC:.c=.o))
OBJLIST = $(F90OBJ) $(COBJ) $(CXXOBJ)
export OBJLIST

$(OBJSUBDIR)/sorting.o: $(addprefix $(OBJSUBDIR)/, \
   sort_cxx_interface.o )

$(OBJSUBDIR)/main.o: $(addprefix $(OBJSUBDIR)/, \
   sorting.o )
