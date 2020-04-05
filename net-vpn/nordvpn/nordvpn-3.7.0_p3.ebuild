# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="NordVPN CLI tool for Linux"
HOMEPAGE="https://nordvpn.com"
BASE_URI="https://repo.nordvpn.com/deb/${PN}/debian/pool/main"
SRC_URI="
	amd64? ( "${BASE_URI}/${PN}_${PV/_p/-}_amd64.deb" )
	arm? ( "${BASE_URI}/${PN}_${PV/_p/-}_armhf.deb" )
	x86? ( "${BASE_URI}/${PN}_${PV/_p/-}_i386.deb" )
"

LICENSE="NordVPN"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="nordlynx systemd"
RESTRICT="mirror strip"

RDEPEND="
	dev-libs/libxslt[crypt]
	net-firewall/iptables
	sys-apps/iproute2[iptables]
	sys-apps/net-tools
	sys-process/procps
	nordlynx? (
		virtual/wireguard[module,tools]
	)
	systemd? (
		sys-apps/systemd
	)
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	rm _gpgbuilder || die
	use !systemd && ( rm -rf usr/lib || die )
	mv usr/share/doc/nordvpn/changelog.gz .
	gunzip changelog.gz
	mv usr/share/man/man1/${PN}.1.gz .
	gunzip ${PN}.1.gz
	rm -rf usr/share/man \
		usr/share/doc \
		etc
	default
}

src_install() {
	dodoc changelog
	rm changelog
	doman ${PN}.1
	rm ${PN}.1
	mkdir -p "${ED}"
	cp -r . "${ED}"/
	doinitd "${FILESDIR}/${PN}d"
}

pkg_postinst() {
	echo
	elog "Thanks for installing the NordVPN client."
	elog "Don't forget to purchase your NordVPN plan in order to use the client."
	echo
}