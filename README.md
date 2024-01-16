# Пакеты для установки:

## Самое необходимое:

```shell
# Настройка RPM Fusion:
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core

# Установка патентованных кодеков:
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# Google Chrome:
sudo dnf install google-chrome-stable

# Утилиты для кастомизации GNOME:
sudo dnf install gnome-tweaks gnome-extensions-app

# Разархиватор для RAR:
sudo dnf install unrar

# Зависимости для установки шрифтов от Microsoft:
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig

# Установка шрифтов от Microsoft
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator`.

### Flatseal

```shell
flatpak install flathub com.github.tchx84.Flatseal
```

### Snap

```shell
sudo dnf install snapd
# Дальше мы перезагружаемся
sudo ln -s /var/lib/snapd/snap /snap
# 2 раза вводим команду
sudo snap install hello-world
# Проверяем
hello-world
```

### Тюнинг системы

Ускорение DNF: https://g-soft.info/linux/9514/kak-uvelichit-skorost-dnf-v-fedora-linux/

Лимитирование объёма журнала systemd-journald: https://andreaskaris.github.io/blog/linux/setting-journalctl-limits/

## Менее необходимые программы:

### ONLYOFFICE

```shell
flatpak install flathub org.onlyoffice.desktopeditors
```

### Создание видео:

```shell
flatpak install flathub com.obsproject.Studio org.kde.kdenlive
```

### Мессенджеры:

#### Telegram

```shell
flatpak install flathub org.telegram.desktop
```

#### Почта

```shell
flatpak install flathub org.gnome.Geary
```

### Загрузка файлов:

#### Uget

```shell
sudo dnf install uget aria2
```

#### Transmission

```shell
flatpak install flathub com.transmissionbt.Transmission
```

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

#### Maven

```shell
sudo dnf install maven
```

#### IDEA Community

```shell
sudo snap install intellij-idea-community --classic
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

### Node.js

```shell
sudo snap install node --classic
sudo dnf install gcc-c++ make
```

### VS Code

```shell
sudo snap install code --classic
```

### Postman

```shell
sudo snap install postman
```

### MongoDB Compass

https://www.mongodb.com/try/download/compass

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

# Если включён Secure Boot:
sudo /usr/sbin/kmodgenca
sudo akmods --force --rebuild
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
```
