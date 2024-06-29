# Гайд по настройке Fedora

## Самое необходимое

### Лимитирование объёма журнала systemd-journald

```shell
sudo nano /etc/systemd/journald.conf
```

В файле `journald.conf` прописываем:

```text
[Journal]
SystemMaxUse=50M
```

А дальше перезагружаем systemd-journald:

```shell
sudo systemctl restart systemd-journald.service
```

### Ускорение DNF

```shell
sudo nano /etc/dnf/dnf.conf
```

В конце файла добавляем:

```text
max_parallel_downloads=10
minrate=500k
```

`minrate` можно увеличить до 1-2M, но в моём случае такой
скорости уже достаточно для того, чтобы быстро грузились пакеты.

Дальше осталось ввести эту команду:

```shell
sudo dnf upgrade --refresh
```

И готово!

### Нужные пакеты

```shell
# Настройка RPM Fusion:
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core

# Установка патентованных кодеков:
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf install mozilla-openh264

# Утилиты для кастомизации GNOME:
sudo dnf install gnome-tweaks gnome-extensions-app

# Зависимости для установки шрифтов от Microsoft:
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig

# Установка шрифтов от Microsoft
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

Также можно установить расширения для GNOME: `Blur my Shell`, `Appindicator` (<https://extensions.gnome.org/>).

### Настройка swapfile в BTRFS

```shell
sudo btrfs subvolume create /swap
cd /swap
# При >=8 гигах ОЗУ с включённым zram хватит
# и пару гигов (на случай, когда вообще наступит OOM даже с zram)
sudo btrfs filesystem mkswapfile --size 2G swapfile
sudo swapon swapfile
sudo nano /etc/fstab
```

Дальше в fstab **(в самый его конец!)**:

```text
/swap/swapfile none swap defaults 0 0
```

Потом делаем:

```shell
sudo systemctl daemon-reload
```

И ребутимся.

### Сброс MOK в UEFI

```shell
sudo mokutil --reset
```

### Удаление старых ядер

```shell
sudo dnf remove --oldinstallonly
```

## Менее необходимые программы

### Дополнительные настройки для Network Manager

```shell
sudo dnf install nm-connection-editor-desktop
```

### fastfetch

```shell
sudo dnf install fastfetch
```

### Snap

```shell
sudo dnf install snapd
sudo ln -s /var/lib/snapd/snap /snap

# Дальше мы перезагружаемся

# 2 раза вводим команду
sudo snap install hello-world

# Проверяем
hello-world
```

### Google Chrome

```shell
sudo dnf install google-chrome-stable
```

### VLC

```shell
sudo snap install vlc
fc-cache -r -v
```

### RAR

```shell
sudo dnf install unrar
```

### 7-Zip

```shell
sudo dnf install p7zip p7zip-plugins
```

### Создание видео

#### OBS Studio

```shell
flatpak install flathub com.obsproject.Studio
```

#### Kdenlive

<https://kdenlive.org/en/download/>

#### Audacity

<https://www.audacityteam.org/download/>

### Мессенджеры

#### Telegram

<https://desktop.telegram.org/>

#### Discord

<https://discord.com/download>

### Виртуализация

#### Docker

**Docker Hub разблокирован в России 3 июня 2024**

```shell
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Дальше мы выносим файлы Docker'а в отдельный subvolume BTRFS'а, чтобы было удобнее юзать снапшоты:

```shell
sudo btrfs subvolume create /docker-data
```

И настраиваем их в конфигах:

```shell
sudo nano /etc/docker/daemon.json
```

```text
{
  "data-root": "/docker-data/docker"
}
```

```shell
sudo nano /etc/containerd/config.toml
```

```text
root = "/docker-data/containerd"
```

И делаем завершающие шаги:

```shell
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

#### VirtualBox

```shell
sudo dnf install VirtualBox
sudo usermod -a -G vboxusers $USER

# Если включён Secure Boot:
sudo /usr/sbin/kmodgenca -a
sudo akmods --force --rebuild
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
```

### Разработка

#### Настройка Git

```shell
# здесь вписать ваше имя и фамилию
git config --global user.name "Egor Gavrilov"
# здесь вписать ваш E-Mail
git config --global user.email gavrilovegor519@gmail.com
```

#### Postman

```shell
sudo snap install postman
```

#### Intellij IDEA

<https://www.jetbrains.com/help/idea/installation-guide.html>

#### Java (разработка)

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

Eclipse/Intellij IDEA/VS Code/NetBeans - официальный сайт разработчика.

##### Maven

```shell
sudo dnf install maven
```

#### VS Code

<https://code.visualstudio.com/docs/setup/linux>

Лучше всего его ставить в формате RPM, а не в Snap.

#### PHP

Если вам нужен только CLI для очень простых скриптов: `php-cli` в DNF.

Если вам нужен LAMP, то присмотритесь лучше к решениям на базе Docker-контейнеров. Готовые скрипты для Docker Compose вы можете найти в Интернете.

Если вам нужен PHP для Laravel:

```shell
sudo dnf install php php-common php-cli php-gd php-mysqlnd php-curl php-intl php-mbstring php-bcmath php-xml php-zip composer
```

##### XAMPP (если вам не хочется Docker'а)

Ставим зависимости:

```shell
sudo dnf install libnsl libxcrypt-compat
```

Далее качаем XAMPP с официального сайта (<https://www.apachefriends.org/ru/index.html>),
и устанавливаем его:

```shell
chmod 755 xampp-linux-*-installer.run
sudo ./xampp-linux-*-installer.run
```

И запускаем:

```shell
sudo /opt/lampp/lampp start
```

Остановка:

```shell
sudo /opt/lampp/lampp stop
```

Для удобной работы с ним, делаем следующие команды:

```shell
cd /opt/lampp
sudo chown $USER:$USER htdocs
chmod 775 htdocs
cd
ln -s /opt/lampp/htdocs/ ~/htdocs
```

#### Node.js

<https://nodejs.org/en/download/package-manager>

#### MongoDB Compass

<https://www.mongodb.com/try/download/compass>

### Загрузка файлов

#### Uget

```shell
sudo dnf install uget
```

#### Transmission

<https://transmissionbt.com/download>

### Снапшоты в BTRFS

```shell
sudo dnf install btrfs-assistant
sudo semanage permissive -a snapperd_t
# Дальше его настраиваем, как хотим
```

### Flatseal

```shell
flatpak install flathub com.github.tchx84.Flatseal
```
