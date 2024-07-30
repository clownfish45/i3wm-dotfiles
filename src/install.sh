#!/bin/bash
clear

export DIRMAIN=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" && pwd )
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}"
cat <<"EOF"
+-------------------------------------------------------+
|   ____      _                              _          |
|  / ___|__ _| |_ _ __  _ __  _   _  ___ ___(_)_ __     |
| | |   / _` | __| '_ \| '_ \| | | |/ __/ __| | '_ \    |
| | |__| (_| | |_| |_) | |_) | |_| | (_| (__| | | | |   |
|  \____\__,_|\__| .__/| .__/ \__,_|\___\___|_|_| |_|   |
|  ____        _ |_|__ |_|                              |
| |  _ \  ___ | |_ / _(_) | ___  ___                    |
| | | | |/ _ \| __| |_| | |/ _ \/ __|                   |
| | |_| | (_) | |_|  _| | |  __/\__ \                   |
| |____/ \___/ \__|_| |_|_|\___||___/                   |
|                                                       |
+-------------------------------------------------------+
EOF
echo -e "${BLUE}|${ENDCOLOR}                                                       ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR} Version: 1.1                                          ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR} By clownfish45                                          ${BLUE}|"
echo -e "${BLUE}|${ENDCOLOR}                                                       ${BLUE}|"
echo -e "${BLUE}+-------------------------------------------------------+"
echo -e "${ENDCOLOR}"

while true; do
    read -p "Continue installation? [Y/n] " yn
    case $yn in
        [Yy]* ) echo installing...; break;;
        [Nn]* ) exit;;
        * ) echo installing...; break;;
    esac
done


sudo systemctl enable iwd

sudo echo  -e "[General]\nEnableNetworkConfiguration=true" > /etc/iwd/main.conf

sudo systemctl restart iwd

sudo echo "nameserver 9.9.9.9" > /etc/resolv.conf

sudo echo -e "[Time]\nNTP=0.uk.pool.ntp.org 1.uk.pool.ntp.org 2.uk.pool.ntp.org 3.uk.pool.ntp.org\nFallbackNTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org" > /etc/systemd/timesyncd.conf

sudo systemctl enable systemd-timesyncd

sudo systemctl start systemd-timesyncd

sudo timedatectl set-ntp true

sudo hwclock --systohc

sleep 5

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Updating System"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -Syyu

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing Packages"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo pacman -Syy alacritty bash-completion cmake code curl debugedit fakeroot fastfetch ffmpeg flameshot fuse gcc git gnome-color-manager gnome-disk-utility gnu-free-fonts gst-libav gst-plugin-pipewire gst-plugins-ugly gvfs gvfs-smb htop i3-wm jdk-openjdk loupe lxappearance-gtk3 make nitrogen ntfs-3g nvtop pacman-contrib papirus-icon-theme polybar qt5-graphicaleffects qt5-quickcontrols2 qt5-svg rofi rtkit sddm sudo tar totem ttf-jetbrains-mono ttf-jetbrains-mono-nerd unzip wget which wireplumber xf86-input-evdev xf86-input-synaptics xf86-video-amdgpu xf86-video-fbdev xz yt-dlp zip

sudo usermod -a -G rtkit $USER
sudo usermod -a -G git $USER
sudo usermod -a -G wheel $USER

wget https://github.com/catppuccin/gtk/releases/download/v0.7.5/Catppuccin-Mocha-Standard-Mauve-Dark.zip -P $DIRMAIN/assets

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing yay"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing AUR Packages"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

yay -S bibata-cursor-theme-bin
#yay -S vesktop-bin --noconfirm
#yay -S prismlauncher-qt5-bin --noconfirm

echo -e "[Icon Theme]\nInherits=Bibata-Modern-Classic" | sudo tee /usr/share/icons/default/index.theme

mkdir ~/PrismLauncher
cd ~/PrismLauncher
wget https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/v8.4.1/PrismLauncher-Linux-Qt5-Portable-v8.4.1.tar.gz

tar -xvf PrismLauncher-Linux-Qt5-Portable-v8.4.1.tar.gz
rm PrismLauncher-Linux-Qt5-Portable-v8.4.1.tar.gz
cd ~/ 

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Installing Android SDK and Flutter"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

sudo mkdir /usr/bin/android-sdk

sudo chmod -R 777 /usr/bin/android-sdk

cd /usr/bin/android-sdk

wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip

unzip commandlinetools-linux-11076708_latest.zip

rm commandlinetools-linux-11076708_latest.zip

echo -e "\nexport ANDROID_HOME=/usr/bin/android-sdk" >> ~/.bashrc
export ANDROID_HOME=/usr/bin/android-sdk

cd cmdline-tools

mkdir latest

mv NOTICE.txt bin lib source.properties latest/

echo -e "\nexport PATH='$PATH:$ANDROID_HOME/cmdline-tools/latest/bin'" >> ~/.bashrc
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

echo -e "\nexport JAVA_HOME=/usr/lib/jvm/default/" >> ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/default/

sdkmanager --update
sdkmanager --install "platform-tools"
sdkmanager --install "emulator"
sdkmanager --install "build-tools;34.0.0"
sdkmanager --install "platforms;android-34"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
echo -e "\nexport PATH='$PATH:$ANDROID_HOME/platform-tools'" >> ~/.bashrc
cd /usr/bin/
sudo wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.3-stable.tar.xz
sudo tar -xvf flutter_linux_3.22.3-stable.tar.xz
sudo chmod -R 777 /usr/bin/flutter
sudo rm flutter_linux_3.22.3-stable.tar.xz
export PATH="$PATH:/usr/bin/flutter/bin"
echo -e "\nexport PATH='$PATH:/usr/bin/flutter/bin'" >> ~/.bashrc
flutter config --no-analytics
flutter --disable-analytics
flutter doctor --android-licenses
cd $ANDROID_HOME
mkdir -p system-images/android-34/google_apis/x86_64
cd system-images/android-34/google_apis/x86_64
wget https://android.googlesource.com/platform/prebuilts/android-emulator-build/system-images/+archive/refs/heads/main/generic/system-images/android-34/google_apis/x86_64.tar.gz 
tar -xvf x86_64.tar.gz
rm x86_64.tar.gz
gunzip system.img.gz
gunzip vendor.img.gz
cd ~/i3wm-dotfiles

avdmanager --verbose create avd --force --name "pixel_6_34" --package "system-images;android-34;google_apis;x86_64" --tag "google_apis" --abi "x86_64" --device "pixel_6"

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing experience"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

while true; do
    read -p "Add a Wifi Menu to the top bar? (Recommended for Laptops) [y/N] " yn
    case $yn in
        [Yy]* ) echo Adding Wifi Menu...; sudo pacman -S network-manager-applet --noconfirm; break;;
        [Nn]* ) echo Skipping...; break;;
        * ) echo Skipping...; break;;
    esac
done

while true; do
    read -p "Add Bluetooth support? [y/N] " yn
    case $yn in
        [Yy]* ) echo Adding Bluetooth Menu...; sudo pacman -S bluez bluez-utils blueman --noconfirm; sudo systemctl enable bluetooth.service; break;;
        [Nn]* ) echo Skipping...; break;;
        * ) echo Skipping...; break;;
    esac
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing a Filemanager"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

PS3='Type in the NUMBER of your Filemanager: '
filemanagers=("Nemo" "Pcmanfm-gtk3" "Nautilus" "Skip")
select fav1 in "${filemanagers[@]}"; do
    case $fav1 in
        "Nemo")
            sudo pacman -S nemo nemo-audio-tab nemo-fileroller nemo-image-converter nemo-share --noconfirm
	    break
            ;;
        "Pcmanfm-gtk3")
            sudo pacman -S pcmanfm-gtk3 xarchiver --noconfirm
	    break
            ;;
        "Nautilus")
            sudo pacman -S nautilus nautilus-image-converter nautilus-share --noconfirm
	    break
            ;;
	"Skip")
	    echo "Skipping..."
	    break
	    ;;
        *) echo "invalid option $REPLY";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Choosing a Browser"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

PS3='Type in the NUMBER of your browser: '
browsers=("Brave" "Chromium" "Firefox" "Skip")
select fav2 in "${browsers[@]}"; do
    case $fav2 in
        "Brave")
            yay -S brave-bin --noconfirm
	    break
            ;;
        "Chromium")
            sudo pacman -S chromium --noconfirm
	    break
            ;;
        "Firefox")
            sudo pacman -S firefox --noconfirm
	    break
            ;;
	"Skip")
	    echo "Skipping..."
	    break
	    ;;
        *) echo "invalid option $REPLY";;
    esac
  break
done

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Copying files"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

mkdir -p ~/.config ~/.local/share/themes
unzip $DIRMAIN/assets/Catppuccin-Mocha-Standard-Mauve-Dark.zip -d ~/.local/share/themes/

echo -e "[xin_-1]\nfile=/home/$USER/.config/wallpapers/scenery.png\nmode=5\nbgcolor=#000000" > $DIRMAIN/config/nitrogen/bg-saved.cfg
echo -e "[geometry]\n\n[nitrogen]\nview=list\nrecurse=true\nsort=alpha\nicon_caps=false\ndirs=/home/$USER/.config/wallpapers;" > $DIRMAIN/config/nitrogen/nitrogen.cfg

chmod +x $DIRMAIN/config/polybar/launch.sh
cp -r $DIRMAIN/config/* ~/.config/

sudo cp -r $DIRMAIN/assets/sddm/catppuccin-mocha /usr/share/sddm/themes/
sudo cp -r $DIRMAIN/assets/sddm.conf /etc/

sudo mv /usr/share/X11/xorg.conf.d/40-libinput.conf ~/.config/
sudo cp -r $DIRMAIN/assets/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Enabling services"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

#systemctl --user enable pipewire pipewire-pulse

sudo systemctl disable iwd
sudo systemctl enable NetworkManager
sudo systemctl disable gdm
sudo systemctl disable lightdm
sudo systemctl enable sddm

echo -e ""
echo -e "${GREEN}--------------------"
echo -e "Finished! Rebooting"
echo -e "--------------------${ENDCOLOR}"
echo -e ""

reboot
