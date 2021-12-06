EAPI=8

DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter"
SRC_URI="https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-$PV.tgz"
LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="amd64 x86"

RDEPEND=">=dev-java/openjdk-jre-bin-11"

S="${WORKDIR}/apache-jmeter-${PV}"

src_install() {
	dodir /opt/${PN}
	cp -aR * "${D}/opt/${PN}/"
	dosym ${D}/opt/$PN/bin/jmeter /usr/bin/jmeter
}
