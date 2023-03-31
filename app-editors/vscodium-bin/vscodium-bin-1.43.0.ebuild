# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit eutils desktop xdg-utils

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode"
HOMEPAGE="https://vscodium.com"
SRC_URI="https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz"
RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-libs/nss-3.47.1-r1:0
>=media-libs/alsa-lib-1.1.8:0
>=media-libs/libpng-1.2.46:0
>=net-print/cups-2.1.4:0
>=x11-libs/cairo-1.14.12:0
>=x11-libs/gtk+-2.24.31-r1:2
>=x11-libs/libXtst-1.2.3:0"

QA_PREBUILT="opt/${MY_PN}/*"

S="${WORKDIR}"

src_install() {
# Install in /opt
    dodir /opt
    cp -pPR "${S}" "${D}/opt/${MY_PN}"
    fperms 0755 /opt/${MY_PN}
  
    dosym "../../opt/${MY_PN}/bin/codium" "/usr/bin/${MY_PN}"
    dosym "../../opt/${MY_PN}/bin/codium" "/usr/bin/codium"
    make_desktop_entry "${MY_PN}" "VSCodium" "${MY_PN}" "Development;IDE"
    newicon "resources/app/resources/linux/code.png" "${MY_PN}.png"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
    xdg_mimeinfo_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
    xdg_mimeinfo_database_update
}
