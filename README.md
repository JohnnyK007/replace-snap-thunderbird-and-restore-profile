# 📨 replace-snap-thunderbird-and-restore-profile.sh

Tento skript nahrádza predinštalovanú Snap verziu Thunderbirdu v Ubuntu Linux plnohodnotnou `.deb` verziou z MozillaTeam PPA repozitára a zároveň obnoví tvoje pôvodné e-mailové účty, nastavenia a uloženú poštu zo Snap profilu.

This script replaces the pre-installed Snap version of Thunderbird on Ubuntu Linux with the full `.deb` version from the MozillaTeam PPA repository, while also restoring your original email accounts, settings, and saved mail from the Snap profile.


---

## 🛠️ Čo skript robí

1. **Zálohuje pôvodný profil Thunderbirdu zo Snap** do `~/thunderbird_profile_backup`.
2. **Odstráni Snap verziu Thunderbirdu**, vrátane AppArmor profilov.
3. **Pridá MozillaTeam PPA** pre prístup k `.deb` verzii Thunderbirdu.
4. **Nastaví APT pinovanie**, aby Snap verzia už nebola preferovaná.
5. **Povolí automatické aktualizácie** z PPA.
6. **Nainštaluje `.deb` verziu Thunderbirdu** z PPA repozitára.
7. **Obnoví tvoj profil** do `~/.thunderbird`, takže neprídeš o žiadne dáta.
8. (Voliteľne) umožňuje obnoviť funkčný spúšťač na ploche.

---

## 📦 Požiadavky

- Ubuntu 22.04 LTS alebo 24.04 LTS
- Predinštalovaná Snap verzia Thunderbirdu
- Internetové pripojenie
- Prístup k `sudo`

---

## 🔧 Inštalácia

```bash
git clone https://github.com/tvoje-meno/thunderbird-replace-script.git

cd thunderbird-replace-script

chmod +x replace-snap-thunderbird-and-restore-profile.sh
./replace-snap-thunderbird-and-restore-profile.sh
```

## 🌍 Slovenský jazyk

Ak chceš používať Thunderbird v slovenčine, odkomentuj tento riadok vo vnútri skriptu:

`#sudo apt install thunderbird-locale-sk`

alebo spusti ručne po inštalácii:

`sudo apt install thunderbird-locale-sk`

## 🖥️ Oprava spúšťača na ploche

Ak máš na ploche starý .desktop súbor, ktorý odkazuje na Snap, môžeš ho odstrániť a nahradiť funkčným:

`rm ~/Plocha/thunderbird_thunderbird.desktop`    # alebo `~/Desktop/`

`cp /usr/share/applications/thunderbird.desktop ~/Plocha/`   # alebo `~/Desktop/`

## ✅ Overené na

   Ubuntu 24.04 LTS (Noble Numbat)

   Thunderbird Snap verzia 1:1snap*

   Thunderbird `.deb` verzia 128.x z MozillaTeam PPA

## ⚠️ Poznámky

   Thunderbird by sa mal spustiť automaticky s pôvodnými účtami a poštou. Ak nie, skontroluj, či sa správny profil nachádza v `~/.thunderbird`.

   Skript robí len nevyhnutné kroky. Pre pokročilé čistenie starých profilov použite manuálnu kontrolu.

## 📄 Licencia

MIT License – Používaj slobodne a vylepšuj podľa potrieb.

## 🤝 Podpora

Ak ti skript pomohol, daj ⭐️ na GitHub. Pripomienky a vylepšenia sú vítané cez issues alebo pull requesty.
