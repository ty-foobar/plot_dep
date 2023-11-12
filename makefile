SHELL = /bin/bash

DIR_FIG = fig
GNUPLOT_DEP = gnuplot.dep
GNUPLOT_SCRPTS = $(wildcard $(DIR_FIG)/*.plt)
GNUPLOT_FIGS = $(patsubst %.plt,%.pdf,$(GNUPLOT_SCRPTS))

all: $(GNUPLOT_DEP) somedocument

$(GNUPLOT_DEP): dep.sh $(GNUPLOT_SCRPTS)
	@./$< $@

somedocument: $(GNUPLOT_FIGS)

$(GNUPLOT_FIGS): %.pdf: %.plt
	@cd $(DIR_FIG); gnuplot $(notdir $<)

clean:
	rm -f $(GNUPLOT_DEP) $(GNUPLOT_FIGS)

-include $(GNUPLOT_DEP)
