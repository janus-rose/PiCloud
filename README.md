#PiCloud

PiCloud is a personal anti-cloud project aiming to encourage the adoption of cloud storage alternatives by easing the process of installing and configuring P2P file sync applications.

The scripts and resources in this repo are intended for use with a Raspberry Pi running Raspbian Wheezy. For information on how to flash Raspbian onto your Pi's SD card, see: https://www.raspberrypi.org/documentation/installation/installing-images/

##Set up your Pi

###a. Plug in your Pi (power + ethernet) and find its assigned IP address

It should look like this: 

192.168.X.XX

-or-

10.0.X.X 

On your home network, an easy way of finding your Pi's IP is by logging into your wireless router (usually by typing 192.168.1.1 in the browser – see manufacturer's instructions) and looking for it in the list of devices connected to the network. Write down this address – you'll need it.

*NOTE: This address will change if you connect your Pi to a different port, router or network*

###b. Connect to your Pi

####Windows: 

download Putty – www.putty.org
 
Enter your Pi's IP and your username / password (Default: pi / raspberry), then hit 'Connect' 

####Mac and Linux:

open Terminal and type:

```ssh pi@192.168.X.XX```	## replace “192.168.X.XX” with your Pi's IP

Enter your Pi's default password (raspberry), then type “yes” at the security prompt

You're in! Now enter this command:

```sudo raspi-config```		## sudo gives you “super user” status, and will ask for your password

We're now in the Pi's setup menu. Use the arrow keys to toggle the following options:

- expand filesystem		## tells the Pi to use all the space on the SD card 
- change user password		## make it strong, memorize it, love it
- set hostname			## name your Pi! go to Advanced >> Hostname
- update software		## Advanced >> Update 
- Select <finish> 
- Select <yes> to reboot

If the Pi doesn't ask to reboot or you accidentally select <no>, type the command sudo reboot

## Option 1: Set up BitTorrent Sync (easy)

### a. Install BitTorrent Sync on your laptop, phone, tablet etc.

####Windows/Mac/Linux:

getsync.com

####iOS/Android:

Search for “btsync” in the appropriate App store

###b. Install BitTorrent Sync on Pi

Once your Pi has rebooted, ssh and log in to your Pi again, then type these commands:

```
sh -c "$(curl -fsSL http://debian.yeasoft.net/add-btsync-repository.sh)"
sudo apt-get update
sudo apt-get install btsync
```

We're now in BTsync's setup wizard. Keep hitting Enter to select all the defaults.

Once you complete the wizard BitTorrent Sync will be running on your Pi. 

### c. Connect your devices with BitTorrent Sync

Access the interface by opening your web browser and typing into the address bar 192.168.X.XX:8888 (substitute your Pi's IP address in place of “192.168.X.XX”)

Click “Add device” to introduce devices to the Pi. The tabs in the pop-up menu allow you do this either by scanning the QR code or copying the device's link or key.

If adding devices is not available, you can sync individual folders by hitting the “Share” button and scanning/copying the QR code, link or key

The shared folders should appear on your other devices. Click approve to activate them, then choose the directory where the files will be stored on each device. Your files will begin syncing! 

*NOTE: BitTorrent Sync is freemium software – some features may not be available*

##Option 2. Set up SyncThing (recommended)

###a. Install Syncthing on your laptop / phone / tablet

####Windows/Mac/Linux:

syncthing.net

####Android:

Search for “syncthing” in the Play store or F-droid

*NOTE: The Android client is 3rd party and not officially supported; iOS is not available at this time*

###b. Install SyncThing on your Pi

Log into your Pi with Terminal or Putty, then enter this in the command line:

```
sudo sh -c “$(curl -fsSL https://github.com/lawfulintercept/PiCloud/blob/master/syncthing-setup.sh)"
```

SyncThing is now fully configured and running on your Pi.

Access your Pi's SyncThing interface by typing 192.168.X.XX:8384 into your web browser's address bar (substitute your Pi's IP address instead of “192.168.X.XX”)

### c. Connect your devices with SyncThing

SyncThing tracks two objects: Devices and Folders. We need to add both for each device in the cluster.

Introduce a device to another device by clicking “Add Device” and copying and pasting its ID code (or scanning QR codes on the Android app). ID codes contain letters and numbers, and look like this:

ABCD123-ABCD123-ABCD123-ABCD123-ABCD123-ABCD123-ABCD123-ABCD123

To display a device's ID, click “Actions” >> “Show ID” in the upper-right hand corner of the SyncThing interface. (On Android, swipe into the left pull-out menu and tap “Share Device ID”, then send the ID via email, etc)

Now add each folder you want to sync. Click “Add Folder” – In the folder creation menu, specify the folder's path on your local hard drive, then tick the boxes at the bottom to select which devices the folder will be shared with.

A message should pop up in the Syncthing GUI of the device you shared with. Click “Approve.”

Your files will begin syncing!

*NOTE: SyncThing is currently in beta and may contain bugs – Use at your own risk*

**Remember to keep your software updated by frequently logging into your Pi and typing:**
```
sudo apt-get update
sudo apt-get upgrade
```
