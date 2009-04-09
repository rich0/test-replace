# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-8.1.4.ebuild,v 1.3 2009/04/09 21:35:14 ulm Exp $

inherit eutils gnome2-utils nsplugins

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/reader/"
IUSE="cups ldap minimal nsplugin"

SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/8.x/${PV}"
SRC_FOOT="-${PV}-1.i486.tar.bz2"

LINGUA_LIST="da:dan de:deu en:enu es:esp fi:suo fr:fra it:ita ja:jpn ko:kor nb:nor nl:nld pt:ptb sv:sve zh_CN:chs zh_TW:cht"
DEFAULT_URI="${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT}"
for ll in ${LINGUA_LIST} ; do
	iuse_l="linguas_${ll/:*}"
	src_l=${ll/*:}
	IUSE="${IUSE} ${iuse_l}"
	DEFAULT_URI="!${iuse_l}? ( ${DEFAULT_URI} )"
	SRC_URI="${SRC_URI}
		${iuse_l}? ( ${SRC_HEAD}/${src_l}/AdobeReader_${src_l}${SRC_FOOT} )"
done
SRC_URI="${SRC_URI}
	${DEFAULT_URI}"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
RESTRICT="strip mirror"

# mozilla-firefox-bin won't work because it doesn't have gtkembedmoz.so
RDEPEND="media-libs/fontconfig
	cups? ( net-print/cups )
	x86? ( >=x11-libs/gtk+-2.0
			ldap? ( net-nds/openldap )
			!minimal? ( || ( net-libs/xulrunner
						net-libs/xulrunner-bin
						www-client/mozilla-firefox
						www-client/seamonkey
						www-client/seamonkey-bin ) ) )
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.4.2
			>=app-emulation/emul-linux-x86-gtklibs-2.0
			!minimal? ( || ( net-libs/xulrunner-bin
						www-client/seamonkey-bin ) ) )"
QA_TEXTRELS="opt/Adobe/Reader8/Reader/intellinux/plug_ins/PPKLite.api
	opt/Adobe/Reader8/Browser/intellinux/nppdf.so
	opt/netscape/plugins/nppdf.so"
QA_EXECSTACK="opt/Adobe/Reader8/Reader/intellinux/plug_ins/Annots.api
	opt/Adobe/Reader8/Reader/intellinux/plug_ins/PPKLite.api
	opt/Adobe/Reader8/Reader/intellinux/bin/acroread
	opt/Adobe/Reader8/Reader/intellinux/bin/SynchronizerApp-binary
	opt/Adobe/Reader8/Reader/intellinux/lib/libsccore.so
	opt/Adobe/Reader8/Reader/intellinux/lib/libcrypto.so.0.9.7"

INSTALLDIR=/opt

S="${WORKDIR}/AdobeReader"

# Actually, ahv segfaults when run standalone so presumably
# it isn't intended for direct use - so the only launcher is
# acroread after all.
LAUNCHERS="Adobe/Reader8/bin/acroread"
#	Adobe/HelpViewer/1.0/intellinux/bin/ahv"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"
}

# Determine lingua from filename
acroread_get_ll() {
	local f_src_l ll lingua src_l
	f_src_l=${1/${SRC_FOOT}}
	f_src_l=${f_src_l/*_}
	for ll in ${LINGUA_LIST} ; do
		lingua=${ll/:*}
		src_l=${ll/*:}
		if [[ ${src_l} == ${f_src_l} ]] ; then
			echo ${lingua}
			return
		fi
	done
	die "Failed to match file $1 to a LINGUA; please report."
}

src_unpack() {
	local ll linguas fl launcher
	# Unpack all into the same place; overwrite common files.
	fl=""
	for pkg in ${A} ; do
		cd "${WORKDIR}"
		unpack ${pkg}
		cd "${S}"
		if [[ ${pkg} =~ ^AdobeReader_ ]] ; then
			tar xf ILINXR.TAR ||
				die "Failed to unpack ILINXR.TAR; is distfile corrupt?"
			tar xf COMMON.TAR ||
				die "Failed to unpack COMMON.TAR; is distfile corrupt?"
			ll=$(acroread_get_ll ${pkg})
			for launcher in ${LAUNCHERS} ; do
				mv ${launcher} ${launcher}.${ll}
			done
			if [[ -z ${fl} ]] ; then
				fl=${ll}
				linguas="${ll}"
			else
				linguas="${linguas} ${ll}"
			fi
		fi
	done
	if [[ ${linguas} == ${fl} ]] ; then
		# Only one lingua selected - skip building the wrappers
		for launcher in ${LAUNCHERS} ; do
			mv ${launcher}.${fl} ${launcher} ||
				die "Failed to put ${launcher}.${fl} back to ${launcher}; please report."
		done
	else
		# Build wrappers.  Launch the acroread for the environment variable
		# LANG (matched with a trailing * so that for example 'de_DE' matches
		# 'de', 'en_GB' matches 'en' etc).
		#
		# HelpViewer is new - We don't know if Adobe are likely to
		# internationalize it or not.
		for launcher in ${LAUNCHERS} ; do
			cat > ${launcher} <<-EOF
				#!/bin/bash
				# Copyright 1999-2009 Gentoo Foundation
				# Distributed under the terms of the GNU General Public License v2
				#
				# Automatically generated by ${CATEGORY}/${PF}

				# Exec the acroread script for the language chosen in
				# LC_ALL/LC_MESSAGES/LANG (first found takes precedence, as in glibc)
				L=\${LC_ALL}
				L=\${L:-\${LC_MESSAGES}}
				L=\${L:-\${LANG}}
				case \${L} in
			EOF
			for ll in ${linguas} ; do
				echo "${ll}*) exec ${INSTALLDIR}/${launcher}.${ll} \"\$@\";;" >> ${launcher}
			done
			# default to English (in particular for LANG=C)
			cat >> ${launcher} <<-EOF
				*) exec ${INSTALLDIR}/${launcher}.${fl} "\$@";;
				esac
			EOF
			chmod 755 ${launcher}
		done
	fi

	# remove cruft
	rm "${S}"/Adobe/Reader8/bin/UNINSTALL
	rm "${S}"/Adobe/Reader8/Resource/Support/vnd.*.desktop

	# replace some configuration sections
	for binfile in "${S}"/Adobe/Reader8/bin/* ; do
		sed -i -e '/Font-config/,+10d' \
			-e "/acrogre.conf/r ${FILESDIR}/gentoo_config" -e //N \
			"${binfile}" || die "sed failed"
	done
}

src_install() {
	# Install desktop files
	domenu Adobe/Reader8/Resource/Support || die "Installing desktop files failed."

	# Install commonly used icon sizes
	for res in 16x16 22x22 32x32 48x48 64x64 128x128 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		doins Adobe/Reader8/Resource/Icons/${res}/* || die "Installing icons failed."
	done

	dodir /opt || die "Creating directoy failed."
	chown -R --dereference -L root:0 Adobe
	cp -dpR Adobe "${D}"opt/

	# The Browser_Plugin_HowTo.txt is now in a subdirectory, which
	# is named according to the language the user is using.
	# Ie. for German, it is in a DEU directory. See bug #118015
	dodoc Adobe/Reader8/Browser/HowTo/*/Browser_Plugin_HowTo.txt || die "Installing docs failed."

	if use nsplugin ; then
		exeinto /opt/netscape/plugins
		doexe Adobe/Reader8/Browser/intellinux/nppdf.so || die "Installing the browser plugin failed."
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	dodir /opt/bin || die "Creating directory failed."
	for launcher in ${LAUNCHERS} ; do
		dosym /opt/${launcher} /opt/bin/${launcher/*bin\/} || die "Installing launcher symlinks failed."
	done

	# We need to set a MOZILLA_COMP_PATH for seamonkey and firefox since
	# they don't install a configuration file for libgtkembedmoz.so
	# detection in /etc/gre.d/ like xulrunner does.
	if ! use minimal ; then
		if use x86 ; then
			for lib in /opt/seamonkey /usr/lib/seamonkey /usr/lib/mozilla-firefox ; do
				if [[ -f ${lib}/libgtkembedmoz.so ]] ; then
					echo "MOZILLA_COMP_PATH=${lib}" >> "${D}"${INSTALLDIR}/Adobe/Reader8/Reader/GlobalPrefs/mozilla_config
					elog "Adobe Reader depends on libgtkembedmoz.so, which I've found on"
					elog "your system in ${lib}, and configured in ${INSTALLDIR}/Adobe/Reader8/Reader/GlobalPrefs/mozilla_config."
					break # don't search any more libraries
				fi
			done
		fi
		if use amd64 ; then
			for lib in /opt/seamonkey ; do
				if [[ -f ${lib}/libgtkembedmoz.so ]] ; then
					echo "MOZILLA_COMP_PATH=${lib}" >> "${D}"${INSTALLDIR}/Adobe/Reader8/Reader/GlobalPrefs/mozilla_config
					elog "Adobe Reader depends on libgtkembedmoz.so, which I've found on"
					elog "your system in ${lib}, and configured in ${INSTALLDIR}/Adobe/Reader8/Reader/GlobalPrefs/mozilla_config."
					break # don't search any more libraries
				fi
			done
		fi
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst () {
	local ll lc
	lc=0
	for ll in ${LINGUA_LIST} ; do
		use linguas_${ll/:*} && (( lc = ${lc} + 1 ))
	done
	if [[ ${lc} > 1 ]] ; then
		echo
		elog "Multiple languages have been installed, selected via a wrapper script."
		elog "The language is selected according to the LANG environment variable"
		elog "(defaulting to English if LANG is not set, or no matching language"
		elog "version is installed). Users may need to remove their preferences in"
		elog "~/.adobe to switch languages."
		echo
	fi

	if use minimal ; then
		echo
		ewarn "If you want html support and/or view the Adobe Reader help you have"
		ewarn "to re-emerge acroread with USE=\"-minimal\"."
		echo
	fi

	if use nsplugin ; then
		echo
		elog "If you're running a 64bit browser you may also want to install"
		elog "\"www-plugins/nspluginwrapper\" to be able to use the Adobe Reader"
		elog "browser plugin."
		echo
	fi

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
