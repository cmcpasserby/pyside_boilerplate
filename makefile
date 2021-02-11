SHELL := /bin/bash

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf venv/pyinstaller

devenv:
	virtualenv --clear --python=python3.9.1 venv/dev && \
	source venv/dev/bin/activate && \
	pip install -r requirements/app.txt
	echo "dev virtualenv made at venv/dev ('source venv/dev/bin/activate' to activate)"

pyinstaller:
	virtualenv --clear --python=python3.9.1 venv/pyinstaller && \
	source venv/pyinstaller/bin/activate && \
	pip install -r requirements/pyinstaller.txt && \
	pip install -r requirements/app.txt && \
	rm -rf build/pyinstaller && \
	git clone https://github.com/pyinstaller/pyinstaller.git build/pyinstaller && \
	pushd build/pyinstaller && \
	git checkout --force v4.2 && \
	pushd bootloader && \
	export MACOSX_DEPLOYMENT_TARGET=10.13 && \
	export CFLAGS=-mmacosx-version-min=10.13 && \
	export CPPFLAGS=-mmacosx-version-min=10.13 && \
	export LDFLAGS=-mmacosx-version-min=10.13 && \
	export LINKFLAGS=-mmacosx-version-min=10.13 && \
	python ./waf all && \
	popd && \
	pip install . && \
	popd && \
	pip list && \
	export PYTHONHASHSEED=1 && \
	pyinstaller -y specs/app.spec
