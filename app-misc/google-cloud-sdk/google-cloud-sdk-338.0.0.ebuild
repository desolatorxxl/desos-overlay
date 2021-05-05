EAPI=7

DESCRIPTION="Googe Cloud SDK"
HOMEPAGE="www.google.com"
SRC_URI="https://dl.google.com/dl/cloudsdk/release/downloads/for_packagers/linux/google-cloud-sdk_${PV}.orig.tar.gz"

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
	mkdir -p ${D}/opt
	elog "Copying files"
	cp -r ${S} ${D}/opt || die
	elog "Creating gcloud symlink"
	dosym ${D}/opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	elog "Installing man pages"
	doman help/man/man1/*
	insinto /usr/share/zsh/site-functions
	newins completion.zsh.inc _gcloud
	elog "Done"
}
