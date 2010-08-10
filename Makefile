#
# $Id: Makefile,v 1.1.1.1 2008-06-07 03:17:22 maas Exp $
#

NAME=oUnit
OBJECTS=oUnit.cmo
XOBJECTS=$(OBJECTS:.cmo=.cmx)

ARCHIVE=oUnit.cma
XARCHIVE=$(ARCHIVE:.cma=.cmxa)

PRINTEXC_MLI=$(shell ocamlc -where)/printexc.mli

OCAMLPP_DEFINES=$(shell grep get_backtrace $(PRINTEXC_MLI) >/dev/null && echo -DBACKTRACE)
OCAMLPP=-pp "camlp4o pa_macro.cmo $(OCAMLPP_DEFINES)"
OCAMLRUN=ocamlrun
OCAMLC=ocamlc $(OCAMLPP) -g
OCAMLOPT=ocamlopt $(OCAMLPP)
OCAMLDEP=ocamldep $(OCAMLPP)
MKLIB=ocamlmklib
OCAMLDOC=ocamldoc
OCAMLFIND=ocamlfind

COMPFLAGS=-w A

### End of configuration section

all: $(ARCHIVE)
allopt: $(XARCHIVE)

debug:
	@echo Printexc: $(PRINTEXC_MLI)
	@echo Macros: $(OCAMLPP_DEFINES)
$(ARCHIVE): $(OBJECTS)
	$(OCAMLC) -a -o $(ARCHIVE) $(OBJECTS)
$(XARCHIVE): $(XOBJECTS)
	$(OCAMLOPT) -a -o $(XARCHIVE) $(XOBJECTS)

depend: *.ml *.mli
	$(OCAMLDEP) *.mli *.ml > depend

.PHONY: test
test: unittest
	./unittest
.PHONY: testopt
testopt: unittest.opt
	./unittest.opt
.PHONY: testall
testall: test testopt

unittest: $(OBJECTS) $(TEST_OBJECTS)
	$(OCAMLFIND) ocamlc -o unittest -package unix -linkpkg \
	$(OBJECTS) test_OUnit.ml

unittest.opt: $(XOBJECTS) $(TEST_XOBJECTS)
	$(OCAMLFIND) ocamlopt -o unittest.opt -package unix -linkpkg \
	$(XOBJECTS) test_OUnit.ml

.PHONY: install
install: all
	{ test ! -f $(XARCHIVE) || extra="$(XARCHIVE) $(NAME).a"; }; \
	$(OCAMLFIND) install $(NAME) META $(NAME).mli $(NAME).cmi $(ARCHIVE) \
	$$extra

.PHONY: uninstall
uninstall:
	$(OCAMLFIND) remove $(NAME)

.PHONY: doc
doc: FORCE
	{ test -d doc || mkdir doc; };
	cd doc; $(OCAMLDOC) -html -I .. ../$(NAME).mli

.PHONY: clean
clean::
	rm -f *~ *.cm* *.o *.a *.so unittest unittest.opt doc/*.html doc/*.css

FORCE:

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.mli.cmi:
	$(OCAMLC) -c $(COMPFLAGS) $<
.ml.cmo:
	$(OCAMLC) -c $(COMPFLAGS) $<
.ml.cmx:
	$(OCAMLOPT) -c $(COMPFLAGS) $<
.c.o:
	$(OCAMLC) -c -ccopt "$(CFLAGS)" $<

include depend
