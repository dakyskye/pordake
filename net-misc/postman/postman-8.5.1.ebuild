# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils xdg

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.getpostman.com/"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64"
RESTRICT="bindist strip mirror"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PRESTRIPPED="opt/${PN}/Postman"
QA_PREBUILT="
	opt/${PN}/Postman
	opt/${PN}/_Postman
	opt/${PN}/chrome-sandbox
	opt/${PN}/libEGL.so
	opt/${PN}/libffmpeg.so
	opt/${PN}/libGLESv2.so
	opt/${PN}/libvk_swiftshader.so
	opt/${PN}/libvulkan.so
	opt/${PN}/libvulkan.so
	opt/${PN}/swiftshader/libEGL.so
	opt/${PN}/swiftshader/libGLESv2.so
"

S="${WORKDIR}/Postman/app"

src_prepare() {
	mv _Postman Postman
	default
}

src_install(){
	pax-mark m Postman
	insinto "/opt/${PN}"
	doins -r .
	dosym "/opt/${PN}/Postman" "/usr/bin/postman"
	dosym "/opt/${PN}/Postman" "/usr/bin/Postman"
	fperms +x "/opt/${PN}/Postman"
	newicon -s 128 "${S}/resources/app/assets/icon.png" postman.png
	make_desktop_entry \
		"postman" \
		"Postman" \
		"/usr/share/icons/hicolor/128x128/apps/postman.png" \
		"Development"
}

pkg_postinst(){
	xdg_icon_cache_update
}
