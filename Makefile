WORKDIR:=$(shell mktemp -d)
PKGDIR:=$(WORKDIR)/foreman-packaging

$(PKGDIR):
	cd $(WORKDIR) && git clone https://github.com/theforeman/foreman-packaging.git

data/deb-%.json: $(PKGDIR)
	cd $(PKGDIR) && git checkout deb/$* && python3 $(CURDIR)/compare_deb_repo.py --json > $(CURDIR)/$@
