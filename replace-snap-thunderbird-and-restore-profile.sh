#!/bin/bash
set -e

echo "===> 1. Zálohovanie Snap profilu Thunderbirdu..."

SNAP_PROFILE_ROOT="$HOME/snap/thunderbird/common/.thunderbird"
BACKUP_DIR="$HOME/thunderbird_profile_backup"
MOZILLA_PROFILE_DIR="$HOME/.thunderbird"

if [ -d "$SNAP_PROFILE_ROOT" ]; then
    mkdir -p "$BACKUP_DIR"
    cp -r "$SNAP_PROFILE_ROOT"/* "$BACKUP_DIR/"
    echo "✅ Profil zálohovaný do: $BACKUP_DIR"
else
    echo "⚠️  Snap profil nebol nájdený v: $SNAP_PROFILE_ROOT"
    exit 1
fi

echo "===> 2. Odstraňovanie Snap verzie Thunderbirdu..."
sudo snap disable thunderbird || true
sudo snap remove --purge thunderbird || true

echo "===> 3. Odstraňovanie AppArmor profilov pre Snap Thunderbird..."
sudo rm -f /etc/apparmor.d/usr.bin.thunderbird
sudo rm -f /etc/apparmor.d/local/usr.bin.thunderbird

echo "===> 4. Pridanie Mozilla PPA..."
sudo add-apt-repository -y ppa:mozillateam/ppa

echo "===> 5. Nastavenie APT pinovania proti Snap verzii..."
sudo tee /etc/apt/preferences.d/mozilla-thunderbird <<EOF
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: thunderbird*
Pin: release o=Ubuntu
Pin-Priority: -1

Package: thunderbird
Pin: version 1:1snap*
Pin-Priority: -1
EOF

echo "===> 6. Povolenie automatických aktualizácií z PPA..."
sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-thunderbird <<EOF
Unattended-Upgrade::Allowed-Origins:: \"LP-PPA-mozillateam:\${distro_codename}\";
EOF

echo "===> 7. Aktualizácia a inštalácia Thunderbirdu z APT..."
sudo apt update
#sudo apt install -y thunderbird
sudo apt install -y thunderbird --allow-downgrades
# Odblokuj nasledovný riadok ak chces nainštalovať Slovečinu
#sudo apt install thunderbird-locale-sk
# Oprava spúšťača na ploche:
# rm ~/Plocha/thunderbird_thunderbird.desktop
# alebo
# rm ~/Desktop/thunderbird_thunderbird.desktop
#cp /usr/share/applications/thunderbird.desktop ~/Plocha/
# alebo
# cp /usr/share/applications/thunderbird.desktop ~/Desktop/

echo "===> 8. Obnovenie profilu zo zálohy..."
mkdir -p "$MOZILLA_PROFILE_DIR"
cp -rn "$BACKUP_DIR"/* "$MOZILLA_PROFILE_DIR/"
echo "✅ Profil obnovený do: $MOZILLA_PROFILE_DIR"

echo "🎉 HOTOVO! Thunderbird bol nainštalovaný ako .deb a tvoj profil bol úspešne presunutý zo Snap verzie."
