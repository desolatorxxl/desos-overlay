EAPI=8
inherit go-module

DESCRIPTION="Benthos is a high performance and resilient stream processor"
HOMEPAGE="https://github.com/benthosdev/${PN}"
SRC_URI="https://github.com/benthosdev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RESTRICT+=" test"

src_install() {
	dobin target/bin/${PN}
}
