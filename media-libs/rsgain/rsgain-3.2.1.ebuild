EAPI=8

inherit cmake

DESCRIPTION="A simple, but powerful ReplayGain 2.0 tagging utility"
HOMEPAGE="https://github.com/complexlogic/$PN"
SRC_URI="$HOMEPAGE/releases/download/v$PV/$P-source.tar.xz"

LICENSE="Beerware"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="
	media-libs/libebur128
	dev-libs/libfmt
	media-libs/taglib
	dev-libs/inih"
RDEPEND="$BDEPEND"
DEPEND="$RDEPEND"
