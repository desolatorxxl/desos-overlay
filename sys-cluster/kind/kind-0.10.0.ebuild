EAPI=7
inherit go-module

DESCRIPTION="kind is a tool for running local Kubernetes clusters using Docker container nodes."
HOMEPAGE="https://github.com/kubernetes-sigs/kind"
SRC_URI="https://github.com/kubernetes-sigs/kind/archive/refs/tags/v${PV}.tar.gz -> kind-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="hardened"

BDEPEND=">=dev-lang/go-1.15"

RESTRICT+=" test"
S="${WORKDIR}/kind-${PV}"

src_compile() {
	CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" \
		emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" build
}

src_install() {
	dobin bin/${PN}
	bin/${PN} completion zsh > ${PN}.zsh || die
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}
}
