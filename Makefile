# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = SphinxDocs
SOURCEDIR     = source
BUILDDIR      = build
GIT_PUB_LOCAL_DIR = docs_repo

publish:
	ssh-add -l
	git clone $(GIT_PUB_REPO) $(GIT_PUB_LOCAL_DIR) && cp -r $(BUILDDIR)/html docs_repo/$(GIT_PUB_DIR) && cd $(GIT_PUB_LOCAL_DIR) && git add . && git commit -m "Updating docs." && git push $(GIT_PUB_REPO) $(GIT_PUB_BRANCH)


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)