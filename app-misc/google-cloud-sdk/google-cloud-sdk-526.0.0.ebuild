EAPI=8

PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit python-single-r1

DESCRIPTION="Googe Cloud SDK"
HOMEPAGE="www.google.com"
SRC_URI="https://dl.google.com/dl/cloudsdk/release/downloads/for_packagers/linux/google-cloud-cli_${PV}.orig_amd64.tar.gz"

LICENSE="See https://cloud.google.com/terms/"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="man"

DEPEND="${PYTHON_DEPS}"
RDEPEND="dev-python/numpy"
BDEPEND=""

S="${WORKDIR}/google-cloud-sdk"

src_install() {
	elog "Running install.py"
	python "./bin/bootstrapping/install.py" \
		--quiet \
		--usage-reporting False \
		--path-update False \
		--bash-completion False \
		--additional-components "" \
		1 > /dev/null || die

	elog "Removing unnecessary files"
	rm -Rf platform/bundledpythonunix
	rm -Rf platform/gsutil/third_party/crcmod_osx
	rm -Rf platform/gsutil_py2/third_party/crcmod_osx
	rm -Rf rpm
	rm -Rf deb
	rm -Rf bin/anthoscli

	if use man; then
		elog "Installing man pages"
		doman help/man/man1/*
	fi

	rm -Rf help

	elog "Copying files"
	mkdir -p ${D}/opt
	cp -r ${S} ${D}/opt || die
	elog "Creating gcloud symlink"
	dosym /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	insinto /usr/share/zsh/site-functions

	doenvd "$FILESDIR/90google-cloud-cli"

	# Fix autocomplete not working https://github.com/desolatorxxl/desos-overlay/issues/1
	printf '%s\n%s\n' "#compdef gcloud" "$(cat completion.zsh.inc)" > completion.zsh.inc
	newins completion.zsh.inc _gcloud

	elog "Done"
}
