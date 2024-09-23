# Гайд по настройке Fedora

## Самое необходимое

### Лимитирование объёма журнала systemd-journald

Используйте скрипт `journald-limit.sh` в папке `scripts`.

### Ускорение DNF

Используйте скрипт `dnf-boost.sh` в папке `scripts`.

### Нужные пакеты

Используйте скрипт `install-base-packages.sh` в папке `scripts`.

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

**Не работает с DNF5!**

```shell
sudo dnf remove --oldinstallonly
```

## Менее необходимые программы

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

### VLC

```shell
sudo snap install vlc
fc-cache -r -v
```

### Создание видео

#### OBS Studio

```shell
flatpak install flathub com.obsproject.Studio
```

#### Kdenlive

```shell
flatpak install flathub org.kde.kdenlive
```

#### Audacity

```shell
flatpak install flathub org.audacityteam.Audacity
```

### KeepassXC

```shell
flatpak install flathub org.keepassxc.KeePassXC
```

### Мессенджеры

#### Telegram

```shell
flatpak install flathub org.telegram.desktop
```

#### Discord

```shell
flatpak install flathub com.discordapp.Discord
```

### Виртуализация

#### Docker

```shell
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Для DNF5:

```shell
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
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
sudo dnf install dkms
```

Потом (если включён Secure Boot):

```shell
sudo mkdir -p /var/lib/shim-signed/mok
sudo openssl req -nodes -new -x509 -newkey rsa:2048 -outform DER -addext "extendedKeyUsage=codeSigning" -keyout /var/lib/shim-signed/mok/MOK.priv -out /var/lib/shim-signed/mok/MOK.der
sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
```

Дальше читаем это: <https://github.com/dell/dkms?tab=readme-ov-file#module-signing>

Дальше ребутимся.

Потом ставим VBox по данному гайду: <https://www.virtualbox.org/wiki/Linux_Downloads>

И после установки вызываем эту команду:

```shell
sudo usermod -aG vboxusers $USER
```

И ребутимся опять.

### Разработка

#### Настройка Git

```shell
# здесь вписать ваше имя и фамилию
git config --global user.name "Egor Gavrilov"
# здесь вписать ваш E-Mail
git config --global user.email gavrilovegor519@gmail.com
```

#### DBeaver

```shell
flatpak install flathub io.dbeaver.DBeaverCommunity
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
sudo dnf install java-21-openjdk-devel
```

Если нужен Java 17:

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
flatpak install flathub com.ugetdm.uGet
```

#### Transmission

```shell
flatpak install flathub com.transmissionbt.Transmission
```

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
