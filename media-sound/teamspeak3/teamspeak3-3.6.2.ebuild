# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="TeamSpeak is software for quality voice communication via the Internet"
HOMEPAGE="https://www.teamspeak.com/"
SRC_URI="https://files.teamspeak-services.com/releases/client/${PV}/TeamSpeak3-Client-linux_amd64-${PV}.run"
S="${WORKDIR}"

LICENSE="teamspeak3"
SLOT="0"
KEYWORDS="-* amd64"

RDEPEND="
	dev-libs/libxslt
	dev-libs/nss
	dev-libs/libxml2-compat
	x11-libs/libxkbcommon
	x11-libs/libXScrnSaver
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-image
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-renderutil
"

RESTRICT="bindist mirror"

QA_PREBUILT="opt/teamspeak3/*"

src_unpack() {
	mkdir -p "${S}" || die
	cd "${S}" || die
	sh "${DISTDIR}/TeamSpeak3-Client-linux_amd64-${PV}.run" --tar -xf 2>/dev/null || die "Failed to extract .run file"
}

src_prepare() {
	default

	# Fix permissions as done in Arch PKGBUILD
	find . -type d -exec chmod 755 {} \; || die
	find . -type f -exec chmod 644 {} \; || die
	find . -name '*.so*' -exec chmod 755 {} \; || die
	chmod +x ts3client* package_inst QtWebEngineProcess 2>/dev/null

	# Fix symlink issue (https://forum.teamspeak.com/threads/134617)
	sed -i "s|cd.*|cd /opt/teamspeak3|" ts3client_runscript.sh || die

	# Fix for Wayland - force xcb platform
	sed -i "s|ts3client_linux_amd64|ts3client_linux_amd64 -platform xcb|" ts3client_runscript.sh || die

	# Remove wayland plugins (not used since we force xcb platform)
	rm -rf platforms/libqwayland*.so || die

	# Remove webp plugin (requires libwebp.so.6 which may not be available)
	rm -f imageformats/libqwebp.so || die
}

src_install() {
	# Install to /opt/teamspeak3
	insinto /opt/teamspeak3
	doins -r *

	# Make executables executable
	fperms 0755 /opt/teamspeak3/ts3client_linux_amd64
	fperms 0755 /opt/teamspeak3/ts3client_runscript.sh
	fperms 0755 /opt/teamspeak3/package_inst
	fperms 0755 /opt/teamspeak3/QtWebEngineProcess
	fperms 0755 /opt/teamspeak3/error_report

	# Make all .so files executable
	find "${ED}/opt/teamspeak3" -name '*.so*' -exec chmod 755 {} \;

	# Create symlink in /usr/bin
	dosym /opt/teamspeak3/ts3client_runscript.sh /usr/bin/teamspeak3

	# Install icon from package
	newicon -s 128 styles/default/logo-128x128.png teamspeak3.png

	# Create desktop entry
	make_desktop_entry teamspeak3 "TeamSpeak 3" teamspeak3 "Audio;AudioVideo;Network"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
