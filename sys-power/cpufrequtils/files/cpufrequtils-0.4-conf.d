# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufrequtils/files/cpufrequtils-0.4-conf.d,v 1.1 2005/12/18 17:07:17 brix Exp $

# Which governor to use. Must be one of the governors listed in:
#   cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
#
GOVERNOR="ondemand"
