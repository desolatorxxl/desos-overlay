EAPI=8

DESCRIPTION="Command-line tool for managing Microsoft Azure resources"
HOMEPAGE="https://github.com/Azure/azure-cli"

MY_PV="${PV}-1~bookworm"
SRC_URI="https://packages.microsoft.com/repos/azure-cli/pool/main/a/azure-cli/azure-cli_${MY_PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RESTRICT="mirror strip bindist"

RDEPEND="
	app-arch/bzip2
	dev-libs/libffi:=
	dev-libs/openssl:0=
	sys-apps/util-linux
	sys-libs/zlib
"

QA_PREBUILT="opt/az/*"

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
	unpack ./data.tar.xz
}

src_install() {
	dodir /opt
	cp -pPR "${WORKDIR}/opt/az" "${ED}/opt/" || die

	exeinto /usr/bin
	newexe "${WORKDIR}/usr/bin/az" az

	insinto /usr/share/bash-completion/completions
	newins "${WORKDIR}/etc/bash_completion.d/azure-cli" az
}
