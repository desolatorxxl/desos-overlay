EAPI=8

DESCRIPTION="resource monitor that shows usage and stats for processor, memory, disks, network and processes."
HOMEPAGE="https://github.com/aristocratos/btop"
SRC_URI="https://github.com/aristocratos/btop/archive/refs/tags/v${PV}.tar.gz -> ${PV}.tar.gz"
KEYWORDS="amd64"

LICENSE="Apache License 2.0"
SLOT="0"

DOCS=( README.md )

src_prepare() {
	default
	sed -i 's/\/usr\/local/\/opt/g' Makefile
}
