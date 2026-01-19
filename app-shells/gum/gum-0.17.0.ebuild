EAPI=8

inherit go-module shell-completion

DESCRIPTION="A tool for glamorous shell scripts"
HOMEPAGE="https://github.com/charmbracelet/gum"

SRC_URI="https://github.com/charmbracelet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dist.deso.onl/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT=" test"

src_compile() {
	go build -ldflags "-X main.Version=${PV}" .
}

src_install() {
	dobin ${PN}

	# Generate and install shell completions
	./${PN} completion bash > ${PN}.bash || die
	./${PN} completion zsh > _${PN} || die
	./${PN} completion fish > ${PN}.fish || die

	newbashcomp ${PN}.bash ${PN}
	newzshcomp _${PN} _${PN}
	newfishcomp ${PN}.fish ${PN}.fish
}
