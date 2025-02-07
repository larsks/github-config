PLANS = $(wildcard *.tf)

README.md: README.md.in $(PLANS)
	(cat README.md.in; terraform-docs markdown --hide-empty .) > $@ || { rm -f $@; exit 1; }
