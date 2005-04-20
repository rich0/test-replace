# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.6.0_rc1.ebuild,v 1.2 2005/04/20 14:41:27 st_lim Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="$IUSE minimal"
MOD_PV="4.6.0"
MY_PV="${PV/_rc1/-rc}"
S="${WORKDIR}/${PN}-${MOD_PV}"

SRC_URI="http://drupal.org/files/projects/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/php"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz

	if ! use minimal ; then
		cd ${S}/modules
		einfo "Unpacking drupal"
		wget http://www.drupal.org/files/projects/drupal-${MOD_PV}.tar.gz
		tar xfz drupal-${PV}.tar.gz

		einfo "Unpacking album"
		wget http://www.drupal.org/files/projects/album-${MOD_PV}.tar.gz
		tar xfz album-${PV}.tar.gz

		einfo "Unpacking amazontools"
		wget http://www.drupal.org/files/projects/amazontools-${MOD_PV}.tar.gz
		tar xfz amazontools-${PV}.tar.gz

		einfo "Unpacking article"
		wget http://www.drupal.org/files/projects/article-${MOD_PV}.tar.gz
		tar xfz article-${PV}.tar.gz

		einfo "Unpacking attachment"
		wget http://www.drupal.org/files/projects/attachment-${MOD_PV}.tar.gz
		tar xfz attachment-${PV}.tar.gz

		einfo "Unpacking bookreview"
		wget http://www.drupal.org/files/projects/bookreview-${MOD_PV}.tar.gz
		tar xfz bookreview-${PV}.tar.gz

		einfo "Unpacking buddylist"
		wget http://www.drupal.org/files/projects/buddylist-${MOD_PV}.tar.gz
		tar xfz buddylist-${PV}.tar.gz

		einfo "Unpacking codefilter"
		wget http://www.drupal.org/files/projects/codefilter-${MOD_PV}.tar.gz
		tar xfz codefilter-${PV}.tar.gz

		einfo "Unpacking commentcloser"
		wget http://www.drupal.org/files/projects/commentcloser-${MOD_PV}.tar.gz
		tar xfz commentcloser-${PV}.tar.gz

		einfo "Unpacking contextlinks"
		wget http://www.drupal.org/files/projects/contextlinks-${MOD_PV}.tar.gz
		tar xfz contextlinks-${PV}.tar.gz

		einfo "Unpacking customerror"
		wget http://www.drupal.org/files/projects/customerror-${MOD_PV}.tar.gz
		tar xfz customerror-${PV}.tar.gz

		einfo "Unpacking daily"
		wget http://www.drupal.org/files/projects/daily-${MOD_PV}.tar.gz
		tar xfz daily-${PV}.tar.gz

		einfo "Unpacking dba"
		wget http://www.drupal.org/files/projects/dba-${MOD_PV}.tar.gz
		tar xfz dba-${PV}.tar.gz

		einfo "Unpacking diff"
		wget http://www.drupal.org/files/projects/diff-${MOD_PV}.tar.gz
		tar xfz diff-${PV}.tar.gz

		einfo "Unpacking download_counter"
		wget http://www.drupal.org/files/projects/download_counter-${MOD_PV}.tar.gz
		tar xfz download_counter-${PV}.tar.gz

		einfo "Unpacking ezmlm"
		wget http://www.drupal.org/files/projects/ezmlm-${MOD_PV}.tar.gz
		tar xfz ezmlm-${PV}.tar.gz

		einfo "Unpacking feedback"
		wget http://www.drupal.org/files/projects/feedback-${MOD_PV}.tar.gz
		tar xfz feedback-${PV}.tar.gz

		einfo "Unpacking filemanager"
		wget http://www.drupal.org/files/projects/filemanager-${MOD_PV}.tar.gz
		tar xfz filemanager-${PV}.tar.gz

		einfo "Unpacking flexinode"
		wget http://www.drupal.org/files/projects/flexinode-${MOD_PV}.tar.gz
		tar xfz flexinode-${PV}.tar.gz

		einfo "Unpacking foaf"
		wget http://www.drupal.org/files/projects/foaf-${MOD_PV}.tar.gz
		tar xfz foaf-${PV}.tar.gz

		einfo "Unpacking folksonomy"
		wget http://www.drupal.org/files/projects/folksonomy-${MOD_PV}.tar.gz
		tar xfz folksonomy-${PV}.tar.gz

		einfo "Unpacking fontsize"
		wget http://www.drupal.org/files/projects/fontsize-${MOD_PV}.tar.gz
		tar xfz fontsize-${PV}.tar.gz

		einfo "Unpacking forms"
		wget http://www.drupal.org/files/projects/forms-${MOD_PV}.tar.gz
		tar xfz forms-${PV}.tar.gz

		einfo "Unpacking form_mail"
		wget http://www.drupal.org/files/projects/form_mail-${MOD_PV}.tar.gz
		tar xfz form_mail-${PV}.tar.gz

		einfo "Unpacking freelinking"
		wget http://www.drupal.org/files/projects/freelinking-${MOD_PV}.tar.gz
		tar xfz freelinking-${PV}.tar.gz

		einfo "Unpacking front"
		wget http://www.drupal.org/files/projects/front-${MOD_PV}.tar.gz
		tar xfz front-${PV}.tar.gz

		einfo "Unpacking gallery"
		wget http://www.drupal.org/files/projects/gallery-${MOD_PV}.tar.gz
		tar xfz gallery-${PV}.tar.gz

		einfo "Unpacking glossary"
		wget http://www.drupal.org/files/projects/glossary-${MOD_PV}.tar.gz
		tar xfz glossary-${PV}.tar.gz

		einfo "Unpacking hof"
		wget http://www.drupal.org/files/projects/hof-${MOD_PV}.tar.gz
		tar xfz hof-${PV}.tar.gz

		einfo "Unpacking htmlcorrector"
		wget http://www.drupal.org/files/projects/htmlcorrector-${MOD_PV}.tar.gz
		tar xfz htmlcorrector-${PV}.tar.gz

		einfo "Unpacking htmlarea"
		wget http://www.drupal.org/files/projects/htmlarea-${MOD_PV}.tar.gz
		tar xfz htmlarea-${PV}.tar.gz

		einfo "Unpacking image"
		wget http://www.drupal.org/files/projects/image-${MOD_PV}.tar.gz
		tar xfz image-${PV}.tar.gz

		einfo "Unpacking img_assist"
		wget http://www.drupal.org/files/projects/img_assist-${MOD_PV}.tar.gz
		tar xfz img_assist-${PV}.tar.gz

		einfo "Unpacking livediscussions"
		wget http://www.drupal.org/files/projects/livediscussions-${MOD_PV}.tar.gz
		tar xfz livediscussions-${PV}.tar.gz

		einfo "Unpacking mailalias"
		wget http://www.drupal.org/files/projects/mailalias-${MOD_PV}.tar.gz
		tar xfz mailalias-${PV}.tar.gz

		einfo "Unpacking mailhandler"
		wget http://www.drupal.org/files/projects/mailhandler-${MOD_PV}.tar.gz
		tar xfz mailhandler-${PV}.tar.gz

		einfo "Unpacking marksmarty"
		wget http://www.drupal.org/files/projects/marksmarty-${MOD_PV}.tar.gz
		tar xfz marksmarty-${PV}.tar.gz

		einfo "Unpacking massmailer"
		wget http://www.drupal.org/files/projects/massmailer-${MOD_PV}.tar.gz
		tar xfz massmailer-${PV}.tar.gz

		einfo "Unpacking members"
		wget http://www.drupal.org/files/projects/members-${MOD_PV}.tar.gz
		tar xfz members-${PV}.tar.gz

		einfo "Unpacking menu_otf"
		wget http://www.drupal.org/files/projects/menu_otf-${MOD_PV}.tar.gz
		tar xfz menu_otf-${PV}.tar.gz

		einfo "Unpacking nodewords"
		wget http://www.drupal.org/files/projects/nodewords-${MOD_PV}.tar.gz
		tar xfz nodewords-${PV}.tar.gz

		einfo "Unpacking nmoderation"
		wget http://www.drupal.org/files/projects/nmoderation-${MOD_PV}.tar.gz
		tar xfz nmoderation-${PV}.tar.gz

		einfo "Unpacking node_import"
		wget http://www.drupal.org/files/projects/node_import-${MOD_PV}.tar.gz
		tar xfz node_import-${PV}.tar.gz

		einfo "Unpacking og"
		wget http://www.drupal.org/files/projects/og-${MOD_PV}.tar.gz
		tar xfz og-${PV}.tar.gz

		einfo "Unpacking pathauto"
		wget http://www.drupal.org/files/projects/pathauto-${MOD_PV}.tar.gz
		tar xfz pathauto-${PV}.tar.gz

		einfo "Unpacking paypal_framework"
		wget http://www.drupal.org/files/projects/paypal_framework-${MOD_PV}.tar.gz
		tar xfz paypal_framework-${PV}.tar.gz

		einfo "Unpacking paypal_subscription"
		wget http://www.drupal.org/files/projects/paypal_subscription-${MOD_PV}.tar.gz
		tar xfz paypal_subscription-${PV}.tar.gz

		einfo "Unpacking poormanscron"
		wget http://www.drupal.org/files/projects/poormanscron-${MOD_PV}.tar.gz
		tar xfz poormanscron-${PV}.tar.gz

		einfo "Unpacking quotes"
		wget http://www.drupal.org/files/projects/quotes-${MOD_PV}.tar.gz
		tar xfz quotes-${PV}.tar.gz

		einfo "Unpacking recipe"
		wget http://www.drupal.org/files/projects/recipe-${MOD_PV}.tar.gz
		tar xfz recipe-${PV}.tar.gz

		einfo "Unpacking rsvp"
		wget http://www.drupal.org/files/projects/rsvp-${MOD_PV}.tar.gz
		tar xfz rsvp-${PV}.tar.gz

		einfo "Unpacking series"
		wget http://www.drupal.org/files/projects/series-${MOD_PV}.tar.gz
		tar xfz series-${PV}.tar.gz

		einfo "Unpacking simpletest"
		wget http://www.drupal.org/files/projects/simpletest-${MOD_PV}.tar.gz
		tar xfz simpletest-${PV}.tar.gz

		einfo "Unpacking sitemenu"
		wget http://www.drupal.org/files/projects/sitemenu-${MOD_PV}.tar.gz
		tar xfz sitemenu-${PV}.tar.gz

		einfo "Unpacking smartypants"
		wget http://www.drupal.org/files/projects/smartypants-${MOD_PV}.tar.gz
		tar xfz smartypants-${PV}.tar.gz

		einfo "Unpacking spam"
		wget http://www.drupal.org/files/projects/spam-${MOD_PV}.tar.gz
		tar xfz spam-${PV}.tar.gz

		einfo "Unpacking statistics_filter"
		wget http://www.drupal.org/files/projects/statistics_filter-${MOD_PV}.tar.gz
		tar xfz statistics_filter-${PV}.tar.gz

		einfo "Unpacking stock"
		wget http://www.drupal.org/files/projects/stock-${MOD_PV}.tar.gz
		tar xfz stock-${PV}.tar.gz

		einfo "Unpacking summary"
		wget http://www.drupal.org/files/projects/summary-${MOD_PV}.tar.gz
		tar xfz summary-${PV}.tar.gz

		einfo "Unpacking survey"
		wget http://www.drupal.org/files/projects/survey-${MOD_PV}.tar.gz
		tar xfz survey-${PV}.tar.gz

		einfo "Unpacking sxip"
		wget http://www.drupal.org/files/projects/sxip-${MOD_PV}.tar.gz
		tar xfz sxip-${PV}.tar.gz

		einfo "Unpacking syndication"
		wget http://www.drupal.org/files/projects/syndication-${MOD_PV}.tar.gz
		tar xfz syndication-${PV}.tar.gz

		einfo "Unpacking taxonomy_block"
		wget http://www.drupal.org/files/projects/taxonomy_block-${MOD_PV}.tar.gz
		tar xfz taxonomy_block-${PV}.tar.gz

		einfo "Unpacking taxonomy_browser"
		wget http://www.drupal.org/files/projects/taxonomy_browser-${MOD_PV}.tar.gz
		tar xfz taxonomy_browser-${PV}.tar.gz

		einfo "Unpacking taxonomy_dhtml"
		wget http://www.drupal.org/files/projects/taxonomy_dhtml-${MOD_PV}.tar.gz
		tar xfz taxonomy_dhtml-${PV}.tar.gz

		einfo "Unpacking taxonomy_menu"
		wget http://www.drupal.org/files/projects/taxonomy_menu-${MOD_PV}.tar.gz
		tar xfz taxonomy_menu-${PV}.tar.gz

		einfo "Unpacking taxonomy_multi_edit"
		wget http://www.drupal.org/files/projects/taxonomy_multi_edit-${MOD_PV}.tar.gz
		tar xfz taxonomy_multi_edit-${PV}.tar.gz

		einfo "Unpacking textile"
		wget http://www.drupal.org/files/projects/textile-${MOD_PV}.tar.gz
		tar xfz textile-${PV}.tar.gz

		einfo "Unpacking theme_editor"
		wget http://www.drupal.org/files/projects/theme_editor-${MOD_PV}.tar.gz
		tar xfz theme_editor-${PV}.tar.gz

		einfo "Unpacking tinymce"
		wget http://www.drupal.org/files/projects/tinymce-${MOD_PV}.tar.gz
		tar xfz tinymce-${PV}.tar.gz

		einfo "Unpacking urlfilter"
		wget http://www.drupal.org/files/projects/urlfilter-${MOD_PV}.tar.gz
		tar xfz urlfilter-${PV}.tar.gz

		einfo "Unpacking variable"
		wget http://www.drupal.org/files/projects/variable-${MOD_PV}.tar.gz
		tar xfz variable-${PV}.tar.gz

		einfo "Unpacking webform"
		wget http://www.drupal.org/files/projects/webform-${MOD_PV}.tar.gz
		tar xfz webform-${PV}.tar.gz

		einfo "Unpacking webserver_auth"
		wget http://www.drupal.org/files/projects/webserver_auth-${MOD_PV}.tar.gz
		tar xfz webserver_auth-${PV}.tar.gz

		einfo "Unpacking week"
		wget http://www.drupal.org/files/projects/week-${MOD_PV}.tar.gz
		tar xfz week-${PV}.tar.gz

		cd ${S}/themes
		einfo "Unpacking blix"
		wget http://www.drupal.org/files/projects/blix-${MOD_PV}.tar.gz
		tar xfz blix-${PV}.tar.gz

		einfo "Unpacking bluemarine"
		wget http://www.drupal.org/files/projects/bluemarine-${MOD_PV}.tar.gz
		tar xfz bluemarine-${PV}.tar.gz

		einfo "Unpacking democratica"
		wget http://www.drupal.org/files/projects/democratica-${MOD_PV}.tar.gz
		tar xfz democratica-${PV}.tar.gz

		einfo "Unpacking friendselectric"
		wget http://www.drupal.org/files/projects/friendselectric-${MOD_PV}.tar.gz
		tar xfz friendselectric-${PV}.tar.gz

		einfo "Unpacking gespaa"
		wget http://www.drupal.org/files/projects/gespaa-${MOD_PV}.tar.gz
		tar xfz gespaa-${PV}.tar.gz

		einfo "Unpacking greenmarinee"
		wget http://www.drupal.org/files/projects/greenmarinee-${MOD_PV}.tar.gz
		tar xfz greenmarinee-${PV}.tar.gz

		einfo "Unpacking leaf"
		wget http://www.drupal.org/files/projects/leaf-${MOD_PV}.tar.gz
		tar xfz leaf-${PV}.tar.gz

		einfo "Unpacking lincolns_revenge"
		wget http://www.drupal.org/files/projects/lincolns_revenge-${MOD_PV}.tar.gz
		tar xfz lincolns_revenge-${PV}.tar.gz

		einfo "Unpacking rdc"
		wget http://www.drupal.org/files/projects/rdc-${MOD_PV}.tar.gz
		tar xfz rdc-${PV}.tar.gz

		einfo "Unpacking spreadfirefox"
		wget http://www.drupal.org/files/projects/spreadfirefox-${MOD_PV}.tar.gz
		tar xfz spreadfirefox-${PV}.tar.gz

		cd ${S}
		einfo "Unpacking hu"
		wget http://www.drupal.org/files/projects/hu-${MOD_PV}.tar.gz
		tar xfz hu-${PV}.tar.gz

		einfo "Unpacking ja"
		wget http://www.drupal.org/files/projects/ja-${MOD_PV}.tar.gz
		tar xfz ja-${PV}.tar.gz

		einfo "Unpacking drupal-pot"
		wget http://www.drupal.org/files/projects/drupal-pot-${MOD_PV}.tar.gz
		tar xfz drupal-pot-${PV}.tar.gz

		cd ${S}/themes/engines
		einfo "Unpacking phptemplate"
		wget http://www.drupal.org/files/projects/phptemplate-${MOD_PV}.tar.gz
		tar xfz phptemplate-${PV}.tar.gz

		find ${S} -name "*.tar.gz" -exec rm -rf {} \;
		find ${S} -type f -exec chmod 644 {} \;
		find ${S} -type d -exec chmod 755 {} \;
	fi
}

src_compile() {
	#Default compile hangs!            
	echo "Nothing to compile"
}

src_install() {

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt"

	webapp_src_preinst

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	einfo "Installing docs"
	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	einfo "Copying main files"
	cp -r . ${D}/${MY_HTDOCSDIR}

	# we install the .htaccess file to enable support for clean URLs
	cp .htaccess ${D}/${MY_HTDOCSDIR}

	# create the files upload directory
	mkdir ${D}/${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/files

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for drupal, we *assume* that all .php files need to have CGI/BIN
	# support added

	for x in `find . -name '*.php' -print ` ; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	done

	#All files must be owned by server
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_configfile ${MY_HTDOCSDIR}/sites/default/settings.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
