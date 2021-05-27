# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

DESCRIPTION="A set of command-line tools for the Google Cloud Platform."
HOMEPAGE="https://cloud.google.com/sdk/"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${P}-linux-x86_64.tar.gz"
RESTRICT=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install(){
	insinto "/opt/${PN}"
	doins -r .

	for bin_file in bin/*; do
		bin_filename="${bin_file#bin/}"
		fperms +x "/opt/${PN}/${bin_file}"
		dosym "/opt/${PN}/${bin_file}" "/usr/bin/${bin_filename}"
	done
}

pkg_postinst(){
	xdg_pkg_postinst
	elog "To install additional GCloud components, run gcloud components install <component>"
	elog "To list available GCloud components, run gcloud components list"
}
