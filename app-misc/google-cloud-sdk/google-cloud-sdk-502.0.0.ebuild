EAPI=8

DESCRIPTION="Googe Cloud SDK"
HOMEPAGE="www.google.com"
SRC_URI="https://dl.google.com/dl/cloudsdk/release/downloads/for_packagers/linux/google-cloud-cli_${PV}.orig_amd64.tar.gz"

LICENSE="See https://cloud.google.com/terms/"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND=""
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
	rm -Rf .install
	rm -Rf platform/bundledpythonunix
	rm -Rf platform/gsutil/third_party/crcmod_osx
	rm -Rf platform/gsutil_py2/third_party/crcmod_osx
	#rm -Rf bin/anthoscli

	elog "Copying files"
	mkdir -p ${D}/opt
	cp -r ${S} ${D}/opt || die
	elog "Creating gcloud symlink"
	dosym /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	elog "Installing man pages"
	doman help/man/man1/*
	insinto /usr/share/zsh/site-functions

	# Fix autocomplete not working https://github.com/desolatorxxl/desos-overlay/issues/1
	printf '%s\n%s\n' "#compdef gcloud" "$(cat completion.zsh.inc)" > completion.zsh.inc
	newins completion.zsh.inc _gcloud

	elog "Done"
}
