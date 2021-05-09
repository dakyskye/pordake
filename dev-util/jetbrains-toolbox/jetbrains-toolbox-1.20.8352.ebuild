# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils desktop

DESCRIPTION="Manage all your JetBrains Projects and Tools"
HOMEPAGE="https://www.jetbrains.com/toolbox/app"
SRC_URI="https://download.jetbrains.com/toolbox/${PF}.tar.gz"

LICENSE="JetBrainsToolbox"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-fs/fuse:*"
RDEPEND="${DEPEND}"

QA_PRESTRIPPED="/opt/${PN}/${PN}"
QA_PREBUILT="
	opt/${PN}/${PN}
	opt/${PN}/squashfs-root/AppRun
	opt/${PN}/squashfs-root/glibcversion
	opt/${PN}/squashfs-root/jetbrains-toolbox
	opt/${PN}/squashfs-root/jetbrains-toolbox-helper
	opt/${PN}/squashfs-root/libappindicator3.so.1
	opt/${PN}/squashfs-root/libcef.so
	opt/${PN}/squashfs-root/libdbusmenu-glib.so.4
	opt/${PN}/squashfs-root/libdbusmenu-gtk3.so.4
	opt/${PN}/squashfs-root/libindicator3.so.7
	opt/${PN}/squashfs-root/libxcb-keysyms.so.1
	opt/${PN}/squashfs-root/libXss.so.1
	opt/${PN}/squashfs-root/unzip
	opt/${PN}/squashfs-root/swiftshader/libEGL.so
	opt/${PN}/squashfs-root/swiftshader/libGLESv2.so
	opt/${PN}/squashfs-root/jre/lib/jexec
	opt/${PN}/squashfs-root/jre/lib/jspawnhelper
"

src_compile() {
        ./"${PN}" --appimage-extract
}

src_install() {
	insinto "/opt/${PN}/"
	doins -r .
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"
	doicon "${S}/squashfs-root/toolbox-tray-color.png"
	domenu "${S}/squashfs-root/${PN}.desktop"
	fperms +x "/opt/${PN}/${PN}"
	fperms +x "/opt/${PN}/squashfs-root/AppRun"
	fperms +x "/opt/${PN}/squashfs-root/glibcversion"
	fperms +x "/opt/${PN}/squashfs-root/jetbrains-toolbox"
	fperms +x "/opt/${PN}/squashfs-root/jetbrains-toolbox-helper"
	fperms +x "/opt/${PN}/squashfs-root/libappindicator3.so.1"
	fperms +x "/opt/${PN}/squashfs-root/libcef.so"
	fperms +x "/opt/${PN}/squashfs-root/libdbusmenu-glib.so.4"
	fperms +x "/opt/${PN}/squashfs-root/libdbusmenu-gtk3.so.4"
	fperms +x "/opt/${PN}/squashfs-root/libindicator3.so.7"
	fperms +x "/opt/${PN}/squashfs-root/libxcb-keysyms.so.1"
	fperms +x "/opt/${PN}/squashfs-root/libXss.so.1"
	fperms +x "/opt/${PN}/squashfs-root/unzip"
	fperms +x "/opt/${PN}/squashfs-root/swiftshader/libEGL.so"
	fperms +x "/opt/${PN}/squashfs-root/swiftshader/libGLESv2.so"
	fperms +x "/opt/${PN}/squashfs-root/jre/lib/jexec"
	fperms +x "/opt/${PN}/squashfs-root/jre/lib/jspawnhelper"
}

pkg_postinst() {
		xdg_desktop_database_update
}
