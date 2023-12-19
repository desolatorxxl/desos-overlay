EAPI=8

inherit go-module

DESCRIPTION="Fast and lightweight DNS proxy as ad-blocker for local network with many features"
HOMEPAGE="https://github.com/0xERR0R/blocky"

SRC_URI="https://github.com/0xERR0R/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SRC_URI+=" https://dist.deso.onl/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	go build .
}

src_install() {
	dobin $PN
	doinitd "$FILESDIR/$PN"
	insinto /etc/blocky
	doins "$FILESDIR/$PN.yml"
}
