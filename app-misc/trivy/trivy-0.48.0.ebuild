EAPI=8
inherit go-module

DESCRIPTION="A simple and comprehensive scanner for vulnerabilities in container images."
HOMEPAGE="https://github.com/aquasecurity/trivy"

SRC_URI="https://github.com/aquasecurity/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	go build ./cmd/trivy
}

src_install() {
    dobin trivy
}
