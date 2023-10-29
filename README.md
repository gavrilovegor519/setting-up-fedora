# Пакеты для установки:

## Самое необходимое:

`sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

`sudo dnf groupupdate core`

`sudo dnf swap ffmpeg-free ffmpeg --allowerasing`

`sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin`

`sudo dnf groupupdate sound-and-video`

`sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld`

`sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld`

`sudo dnf install gnome-extensions-app gnome-tweaks google-chrome-stable unrar curl cabextract xorg-x11-font-utils fontconfig`

`sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm`

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator`.

## Менее необходимые программы:

### MoreWaita icon theme

`sudo dnf copr enable dusansimic/themes`

`sudo dnf install morewaita-icon-theme`

Потом необходимо эту тему включить в GNOME Tweaks.

### Создание видео:

`flatpak install flathub com.obsproject.Studio`

`flatpak install flathub org.pitivi.Pitivi` (или `flatpak install flathub org.kde.kdenlive`, если надо именно Kdenlive, а не Pitivi)

### Мессенджеры:

- Viber - официальный сайт (RPM).
- Telegram - `flatpak install flathub org.telegram.desktop`.
- Почта - `geary` в DNF.

### Загрузка файлов:

- Uget - `uget` в DNF.
- Transmission - `transmission` в DNF.

### Java (разработка):

Сначала ставим через DNF: `sudo dnf install java-17-openjdk-devel openjfx`

Если нужен Java 11 - `sudo dnf install java-11-openjdk-devel`

Если нужен Java 8 - `sudo dnf install java-1.8.0-openjdk-devel icedtea-web-devel openjfx8-devel java-1.8.0-openjdk-openjfx-devel`

Eclipse/Intellij IDEA/VS Code/NetBeans - официальный сайт разработчика.

Maven - официальный сайт, либо через DNF (`sudo dnf install maven`).

### PHP

Если вам нужен только CLI для очень простых скриптов: `php-cli` в DNF.

Если вам нужен LAMP, то присмотритесь лучше к решениям на базе Docker-контейнеров. Готовые скрипты для Docker Compose вы можете найти в Интернете.

Если вам нужен PHP для Laravel:

`sudo dnf install php php-common php-cli php-gd php-mysqlnd php-curl php-intl php-mbstring php-bcmath php-xml php-zip composer`

После чего вы можете генерировать проекты на "Ларе" через эту команду:

`composer create-project laravel/laravel <project_name>` (где `<project_name>` - имя проекта)

Запуск проекта на "Ларе":

`cd <project_name>`

`php artisan serve`

### Docker:

`sudo dnf -y install dnf-plugins-core`

`sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo`

После этого надо установить следующие пакеты через DNF:

`sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`

Потом:

`sudo systemctl start docker`

`sudo docker run hello-world`

`sudo usermod -aG docker $USER`

`sudo systemctl enable docker.service`

`sudo systemctl enable containerd.service`

### VirtualBox:

`sudo dnf config-manager --add-repo https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo`

После этого через DNF:

`sudo dnf install VirtualBox-7.0 @development-tools kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras`

Потом:

`sudo usermod -a -G vboxusers $USER`

