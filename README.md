# Пакеты для установки:

## Самое необходимое:

```shell
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf install google-chrome-stable gnome-tweaks gnome-extensions-app unrar curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator`.

### Тюнинг системы

Ускорение DNF: https://g-soft.info/linux/9514/kak-uvelichit-skorost-dnf-v-fedora-linux/

Отключение Wi-Fi Powersave для стабилизации Wi-Fi-соединения: https://discussion.fedoraproject.org/t/tip-lower-wifi-latency-by-disabling-wifi-power-management/74534

Лимитирование объёма журнала systemd-journald: https://andreaskaris.github.io/blog/linux/setting-journalctl-limits/

## Менее необходимые программы:

### ONLYOFFICE

```shell
flatpak install flathub org.onlyoffice.desktopeditors
```

### Создание видео:

```shell
flatpak install flathub com.obsproject.Studio org.pitivi.Pitivi
```

(или `org.kde.kdenlive`, если надо именно Kdenlive, а не Pitivi)

### Мессенджеры:

- Telegram - `flatpak install flathub org.telegram.desktop`.
- Почта - `flatpak install flathub org.gnome.Geary`.

### Загрузка файлов:

- Uget - `uget` в DNF.
- Transmission - `flatpak install flathub com.transmissionbt.Transmission`.

### Java (разработка):

Сначала ставим через DNF:

```shell
sudo dnf install java-17-openjdk-devel
```

Если нужен Java 11:

```shell
sudo dnf install java-11-openjdk-devel
```

Если нужен Java 8:

```shell
sudo dnf install java-1.8.0-openjdk-devel
```

Eclipse/Intellij IDEA/VS Code/NetBeans - официальный сайт разработчика, либо Snap (если есть официальный пакет).

Maven:

```shell
sudo dnf install maven
```

### PHP

VS Code/PHPstorm - оф. сайт, либо Snap.

Если вам нужен только CLI для очень простых скриптов: `php-cli` в DNF.

Если вам нужен LAMP, то присмотритесь лучше к решениям на базе Docker-контейнеров. Готовые скрипты для Docker Compose вы можете найти в Интернете.

Если вам нужен PHP для Laravel:

```shell
sudo dnf install php php-common php-cli php-gd php-mysqlnd php-curl php-intl php-mbstring php-bcmath php-xml php-zip composer
```

После чего вы можете генерировать проекты на "Ларе" через эту команду:

```shell
composer create-project laravel/laravel <project_name>
```

(где `<project_name>` - имя проекта)

Запуск проекта на "Ларе":

```shell
cd <project_name>
php artisan serve
```

### Docker:

```shell
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo docker system prune -a --volumes
```

### VirtualBox:

```shell
sudo dnf install VirtualBox
sudo usermod -a -G vboxusers $USER
```
