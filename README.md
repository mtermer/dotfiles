# Unix Admin Dotfiles

Minimalistické a vysoce přenosné konfigurace pro každodenní administrátorskou práci. Optimalizováno pro macOS -> PuTTY -> Linux.

## Rychlá instalace

```bash
cd ~
git clone <url-vaseho-repozitare> .dotfiles
cd .dotfiles
# Vytvoření symlinků
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/screenrc ~/.screenrc

```

> **Doporučení:** Pro plnou efektivitu namapujte v OS klávesu **Caps Lock na Control**.

---

## Vim (Editor)

Konfigurace bez pluginů, s podporou Pythonu, YAML a automatickým spouštěním skriptů.

### Základní ovládání

| Zkratka | Akce |
| --- | --- |
| `Ctrl + s` | **Uložit** soubor (v insert i normal módu) |
| `,p` | **Paste mód** (pro bezpečné vkládání myší z Windows/macOS) |
| `,r` | **Spustit skript** (Python/Bash) a zobrazit výstup v novém okně |
| `,c` | **Zavřít** aktuální soubor (buffer) |
| `,n` / `,b` | Další / Předchozí otevřený soubor |

### Okna a Diff

| Zkratka | Akce |
| --- | --- |
| `,v` / `,h` | Rozdělit okno **V**ertikálně / **H**orizontálně |
| `Ctrl + h/j/k/l` | Pohyb mezi rozdělenými okny (přes Caps Lock) |
| `,df` | Spustit **Diff** (srovnání) v aktuálních oknech |
| `,dq` | Ukončit Diff režim |

---

## GNU Screen (Terminálový multiplexor)

*Pokud přidáte soubor `.screenrc`, zde jsou doporučené zkratky:*

* `Ctrl + a` je výchozí escape sekvence.
* `Ctrl + a`, `c` -> Nové okno (Create)
* `Ctrl + a`, `n` / `p` -> Další / Předchozí okno
* `Ctrl + a`, `"` -> Seznam oken
* `Ctrl + a`, `d` -> Odpojit se (Detach)

---

## Údržba

* **Při uložení ve Vimu:** Automaticky se odstraňují prázdné znaky na koncích řádků.
* **Statusline:** Zobrazuje formát souboru (`unix/dos`), kódování a pozici kurzoru.
* **Smart Cursor:** Vim si pamatuje, kde jste v souboru naposledy skončili.


