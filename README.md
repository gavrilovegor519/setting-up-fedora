# Пакеты для установки:

## Fedora:

### Самое необходимое:

`sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

`sudo dnf groupupdate core`

`sudo dnf swap ffmpeg-free ffmpeg --allowerasing`

`sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin`

`sudo dnf groupupdate sound-and-video`

`sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld`

`sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld`

`sudo dnf install gnome-extensions-app gnome-tweaks google-chrome-stable curl cabextract xorg-x11-font-utils fontconfig`

`sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm`

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator`.

### Менее необходимые программы:

#### Создание видео:

`flatpak install flathub com.obsproject.Studio`

`flatpak install flathub org.pitivi.Pitivi` (или `flatpak install flathub org.kde.kdenlive`)

#### Мессенджеры:

- Viber - официальный сайт (RPM).
- Telegram - `flatpak install flathub org.telegram.desktop`.
- Почта - `geary` в DNF.

#### Загрузка файлов:

- Uget - `uget` в DNF.
- Transmission - `transmission` в DNF.

#### Среды разработки:

Сначала ставим через DNF: `java-17-openjdk-devel java-11-openjdk-devel` (если вам нужен Java 8, либо поддержка Java Web Start - `java-1.8.0-openjdk-devel icedtea-web`)

Eclipse/Intellij IDEA/VS Code/NetBeans - официальный сайт разработчика.

#### Docker:

`sudo dnf -y install dnf-plugins-core`

`sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo`

После этого надо установить следующие пакеты через DNF:

`docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`

Потом:

`sudo systemctl start docker`

`sudo docker run hello-world`

`sudo usermod -aG docker $USER`

`sudo systemctl enable docker.service`

`sudo systemctl enable containerd.service`

#### VirtualBox:

`sudo dnf config-manager --add-repo https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo`

После этого через DNF:

`VirtualBox-7.0 @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras`

Потом:

`sudo usermod -a -G vboxusers $USER`

