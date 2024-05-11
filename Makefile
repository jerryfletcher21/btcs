.PHONY: install uninstall

install: install-data install-script

uninstall: uninstall-data uninstall-script

install-data:
	./install.sh install-data

install-script:
	./install.sh install-script

uninstall-data:
	./install.sh uninstall-data

uninstall-script:
	./install.sh uninstall-script
