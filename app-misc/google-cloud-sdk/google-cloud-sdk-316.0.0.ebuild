# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Googe Cloud SDK"
HOMEPAGE="www.google.com"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-316.0.0-linux-x86_64.tar.gz"

LICENSE="See https://cloud.google.com/terms/"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodir ${ROOT}/usr/share/google-cloud-sdk
	cp -R "${S}/" "${D}/usr/share/" || die "Install failed!"

	python "./bin/bootstrapping/install.py" \
		--quiet \
		--usage-reporting False \
		--path-update False \
		--bash-completion False \
		--additional-components "" \
		1 > /dev/null

	#dosym ${D}/usr/share/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	#doman ${D}/usr/share/google-cloud-sdk/help/man/man1/*.1
}
