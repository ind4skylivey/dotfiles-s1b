.PHONY: help lint test validate dry-run audit docs install uninstall doctor backup-list

help:
	@printf '%s\n' \
		'Targets:' \
		'  make help         this list' \
		'  make lint         bash -n + ShellCheck (new scripts only)' \
		'  make test         unit tests (detect, log, dry-run, backup, link)' \
		'  make validate     repository validation (no host changes)' \
		'  make dry-run      ./install.sh --dry-run' \
		'  make doctor       ./doctor.sh' \
		'  make audit        print docs/audit/current-state.md path' \
		'  make docs         list documentation files' \
		'  make install      refuse silent privileged install; print command' \
		'  make uninstall    not implemented' \
		'  make backup-list  ./restore.sh --list'

lint validate:
	./validate.sh

test:
	bash tests/run.sh

dry-run:
	./install.sh --dry-run

doctor:
	./doctor.sh

audit:
	@printf '%s\n' docs/audit/current-state.md docs/architecture.md

docs:
	@ls -1 docs/*.md docs/audit/*.md

install:
	@printf '%s\n' \
		'make install does not run a privileged install.' \
		'Preview:  ./install.sh --dry-run' \
		'Legacy:   ./install.sh --legacy' \
		'Help:     ./install.sh --help'

uninstall:
	@printf '%s\n' 'uninstall is not implemented yet. ./install.sh --uninstall'
	@exit 3

backup-list:
	./restore.sh --list
