EAPI=7
inherit go-module

DESCRIPTION="Popeye - A Kubernetes Cluster Sanitizer"
HOMEPAGE="https://github.com/derailed/popeye"
SRC_URI="https://github.com/derailed/popeye/archive/refs/tags/v${PV}.tar.gz -> popeye-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="hardened"

BDEPEND=">=dev-lang/go-1.15"

RESTRICT+=" test"
S="${WORKDIR}/popeye-${PV}"

src_compile() {
	CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')" \
		emake -j1 GOFLAGS="" GOLDFLAGS="" LDFLAGS="" build
}

src_install() {
	dobin execs/${PN}
}
