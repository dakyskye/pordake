# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop autotools xdg

DESCRIPTION="Tray icon for the Spotify Linux client application"
HOMEPAGE="https://github.com/tsmetana/spotify-tray"
SRC_URI="https://github.com/tsmetana/spotify-tray/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/gtk+:3
"

RDEPEND="
	${DEPEND}
	media-sound/spotify
"

src_prepare(){
	default
	eautoreconf
}

src_install(){
	insinto "/usr/bin/"
	doins -r .
	domenu "${FILESDIR}/${PN}.desktop"
	doins "src/${PN}"
	fperms +x "/usr/bin/${PN}"
}

pkg_postinst(){
	xdg_pkg_postinst
	elog "Tray icon for Spotify Linux client has been installed"
	elog "You may want to alias spotify to spotify-client in your shell"
}
