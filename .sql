/*
## 1. ADATBÁZIS LÉTREHOZÁSA

Hozz létre egy `music` nevű adatbázist! Az adatbázis létrehozása előtt töröld azt, ha már létezik. Az adatbázis karakterkódolása legyen UTF-8 (`utf8mb4`), a rendezése pedig `utf8mb4_hungarian_ci`. A létrehozás után válaszd ki használatra a `music` adatbázist.

---

## 2. TÁBLÁK LÉTREHOZÁSA

### 2.1. Segédtáblák (lookup tables)

Hozd létre az alábbi táblákat! Minden táblában szerepeljen egy `id` nevű elsődleges kulcs (PRIMARY KEY) AUTO_INCREMENT tulajdonsággal, legyen NOT NULL, UNSIGNED INT is. A mezők neveit angolul add meg a táblában, de minden mezőhöz írj magyar nyelvű COMMENT-et!

#### a) Országok tábla (`countries`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `name`: VARCHAR(50), NOT NULL, "Ország neve" kommenttel

Adj a táblának "Országok" COMMENT-et!

#### b) Műfajok tábla (`genres`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `name`: VARCHAR(50), NOT NULL, "Műfaj neve" kommenttel

Adj a táblának "Zenei műfajok" COMMENT-et!

#### c) Kiadók tábla (`record_labels`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `name`: VARCHAR(100), NOT NULL, "Kiadó neve" kommenttel
- `founded_year`: INT, "Alapítás éve" kommenttel

Adj a táblának "Lemezkiadók" COMMENT-et!

#### d) Formátumok tábla (`formats`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `name`: VARCHAR(30), NOT NULL, "Formátum neve" kommenttel

Adj a táblának "Album formátumok" COMMENT-et!

### 2.2. Főbb táblák

#### a) Előadók tábla (`artists`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `name`: VARCHAR(100), NOT NULL, "Előadó/zenekar neve" kommenttel
- `country_id`: INT UNSIGNED, NOT NULL, "Származási ország" kommenttel, idegen kulcs a `countries` tábla `id` mezőjére
- `genre_id`: INT UNSIGNED, NOT NULL, "Elsődleges műfaj" kommenttel, idegen kulcs a `genres` tábla `id` mezőjére
- `formed_year`: INT, "Alakulás/indulás éve" kommenttel
- `is_active`: BOOLEAN, DEFAULT TRUE, "Aktív-e" kommenttel
- `member_count`: TINYINT, "Tagok száma (NULL ha szólóelőadó)" kommenttel

Adj a táblának "Előadók és zenekarok" COMMENT-et!

#### b) Albumok tábla (`albums`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `title`: VARCHAR(150), NOT NULL, "Album címe" kommenttel
- `artist_id`: INT UNSIGNED, NOT NULL, "Előadó azonosító" kommenttel, idegen kulcs az `artists` tábla `id` mezőjére
- `label_id`: INT UNSIGNED, NOT NULL, "Kiadó azonosító" kommenttel, idegen kulcs a `record_labels` tábla `id` mezőjére
- `release_date`: DATE, NOT NULL, "Kiadás dátuma" kommenttel
- `format_id`: INT UNSIGNED, NOT NULL, "Formátum" kommenttel, idegen kulcs a `formats` tábla `id` mezőjére
- `price`: INT, "Ár (Ft)" kommenttel
- `copies_sold`: INT, DEFAULT 0, "Eladott példányszám" kommenttel
- `rating`: DECIMAL(3,2), "Értékelés (1.00-5.00)" kommenttel

Adj a táblának "Zenei albumok" COMMENT-et!

#### c) Dalok tábla (`songs`)
- `id`: INT UNSIGNED, elsődleges kulcs, AUTO_INCREMENT, NOT NULL
- `title`: VARCHAR(200), NOT NULL, "Dal címe" kommenttel
- `album_id`: INT UNSIGNED, NOT NULL, "Album azonosító" kommenttel, idegen kulcs az `albums` tábla `id` mezőjére
- `track_number`: TINYINT, NOT NULL, "Sorszám az albumon" kommenttel
- `duration`: INT, NOT NULL, "Hossz (másodperc)" kommenttel
- `genre_id`: INT UNSIGNED, NOT NULL, "Műfaj" kommenttel, idegen kulcs a `genres` tábla `id` mezőjére
- `plays`: INT, DEFAULT 0, "Lejátszások száma" kommenttel
- `is_single`: BOOLEAN, DEFAULT FALSE, "Megjelent-e kislemezként" kommenttel
- `writer`: VARCHAR(100), "Dalszerző neve" kommenttel

Adj a táblának "Dalok/számok" COMMENT-et!


*/
DROP DATABASE IF EXISTS music;
CREATE DATABASE IF NOT EXISTS music
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_hungarian_ci;

USE music;
CREATE TABLE countries(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT 'Ország neve',
    PRIMARY KEY (id)
) COMMENT 'Országok';

CREATE TABLE genres(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT 'Műfaj neve',
    PRIMARY KEY (id)
) COMMENT 'Zenei Műfajok';

CREATE TABLE record_labels(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL COMMENT 'Kiadó neve',
    founded_year INT COMMENT 'Alapítás éve',
    PRIMARY KEY (id)
) COMMENT 'Lemez Kiadók';

CREATE TABLE formats(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    name VARCHAR(30) NOT NULL COMMENT 'Formátum neve',
    PRIMARY KEY (id)
) COMMENT 'Album Formátumok';

CREATE TABLE artists(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL COMMENT 'Előadó/zenekar neve',
    country_id INT UNSIGNED NOT NULL COMMENT 'Származási ország',
    genre_id INT UNSIGNED NOT NULL COMMENT 'Elsődleges műfaj',
    formed_year INT COMMENT 'Alakulás/indulás éve',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Aktív-e',
    member_count TINYINT COMMENT 'Tagok száma (NULL ha szólóelőadó)',
    PRIMARY KEY (id),
    FOREIGN KEY (country_id) REFERENCES countries(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
) COMMENT 'Előadók és Zenekarok';

CREATE TABLE albums(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL COMMENT 'Album címe',
    artist_id INT UNSIGNED NOT NULL COMMENT 'Előadó azonosító',
    label_id INT UNSIGNED NOT NULL COMMENT 'Kiadó azonosító',
    release_date DATE NOT NULL COMMENT 'Kiadás dátuma',
    format_id INT UNSIGNED NOT NULL COMMENT 'Formátum',
    price INT COMMENT 'Ár (Ft)',
    copies_sold INT DEFAULT 0 COMMENT 'Eladott példányszám',
    rating DECIMAL(3,2) COMMENT 'Értékelés (1.00-5.00)',
    PRIMARY KEY (id),
    FOREIGN KEY (artist_id) REFERENCES artists(id),
    FOREIGN KEY (label_id) REFERENCES record_labels(id),
    FOREIGN KEY (format_id) REFERENCES formats(id)
) COMMENT 'Albumok';

CREATE TABLE songs(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    title VARCHAR(200) NOT NULL COMMENT 'Dal címe',
    album_id INT UNSIGNED NOT NULL COMMENT 'Album azonosító',
    track_number TINYINT NOT NULL COMMENT 'Sorszám az albumon',
    duration INT NOT NULL COMMENT 'Hossz (másodperc)',
    genre_id INT UNSIGNED NOT NULL COMMENT 'Műfaj',
    plays INT DEFAULT 0 COMMENT 'Lejátszások száma',
    is_single BOOLEAN DEFAULT FALSE COMMENT 'Megjelent-e kislemezként',
    writer VARCHAR(100) COMMENT 'Dalszerző neve',
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
) COMMENT 'Dalok/számok';