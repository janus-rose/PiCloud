#!/bin/sh
#
#
# This script adds Mark Lopez's BitTorrent Sync packaging
# repositories to a machine and also adds the signer key.
#
# https://github.com/Silvenga/btsync-deb
#
# Adapted from Leo Moll's BTsync Packaging Project:
#
# http://www.yeasoft.com/downloads/btsync-deb/

show_error() {
	echo "error: $*" >&2
}

ask_yesno() {
	ANSWER=
	while [ "$ANSWER" != "yes" -a "$ANSWER" != "no" ]; do
		echo -n "${1} [yes/no] "
		read ANSWER
	done
	if [ "$ANSWER" != "yes" ]; then
		exit ${2:-255}
	fi
}

test_program() {
	if ! which $1 2> /dev/null > /dev/null; then
		show_error $2
		exit 2
	fi
	if [ ! -x `which $1` ]; then
		show_error $2
		exit 2
	fi
}

test_program dpkg "this script can not run on non debian derived distributions."

echo "This script will install the BitTorrent Sync on your machine."
echo "Since the BitTorrent Sync packages are all signed with a key"
echo "in order to guarantee their authenticity, an additional"
echo "package signer key will also be installed to your"
echo "machine."
echo

ask_yesno "Do you want to continue with the installation?"

echo
echo "Checking prerequisites..."

SUDO=
if [ $(id -u) -ne 0 ]; then
	SUDO=`which sudo 2> /dev/null`
	if [ -z ${SUDO} ]; then
		show_error "No 'sudo' found on your machine. Since the installation requires"
		show_error "administrative privileges, some operations must be run as root."
		show_error "You can instead try running the script directly as root."
		exit 5
	fi
fi

test_program apt-key "the required tool 'apt-key' cannot be found on your system"

if [ ! -d /etc/apt/sources.list.d ]; then
	show_error "Missing required directory /etc/apt/sources.list.d"
	exit 2
fi

echo "All prerequisites satisfied. Proceeding with installation."
echo

if [ ! -z ${SUDO} ]; then
	echo "During the next steps you may be asked to enter your password"
	echo "in order to confirm some tools to run with administrative"
	echo "privileges."
	echo
fi

echo "Installing package signing key..."
if ! $SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 37F1A037FEF78709; then
	curl -s http://debian.yeasoft.net/btsync.key | apt-key add --
	ERR=$?
	if [ ! ${ERR} ]; then
		show_error "Package signing key installation failed."
		exit ${ERR}
	fi
fi
echo

echo "Determining distribution code name..."
if which lsb_release 2> /dev/null > /dev/null; then
	CODENAME=`lsb_release -cs`
	case "${CODENAME}" in
	# detected ubuntu versions
	lucid)		;;
	precise)	;;
	quantal)	;;
	raring)		;;
	saucy)		;;
	trusty)		;;
	utopic)		;;
	vivid)		;;
	wily)		;;
	xenial)		;;
	# detected debian versions
	squeeze)	;;
	wheezy)		;;
	jessie)		;;
	sid)		;;
	# fallback
	*)		CODENAME=unstable;;
	esac
else
	CODENAME=unstable
fi

echo "Installing repository info..."

$SUDO add-apt-repository "deb http://deb.silvenga.com/btsync any main"

$SUDO apt-get update

echo
echo "Installing Bittorrent Sync"
echo

$SUDO apt-get install btsync

echo ""
echo "*Bittorrent Sync is now installed and running on your Pi*"
echo ""
echo "Access the interface on your local network by typing "
echo "http://Your.Pi's.IP.Address:8384 into your web browser's"
echo "address bar."
echo ""
