WORKDIR:=$(shell mktemp -d)
PKGDIR:=$(WORKDIR)/foreman-packaging

$(PKGDIR):
	cd $(WORKDIR) && git clone https://github.com/theforeman/foreman-packaging.git

data/deb-%.json: $(PKGDIR)
	cd $(PKGDIR) && git checkout deb/$* && python3 $(CURDIR)/compare_deb_repo.py --json > $(CURDIR)/$@

index.html: data/deb-3.1.json data/deb-3.2.json data/deb-3.3.json data/deb-develop.json
	python3 visualize.py > index.html
