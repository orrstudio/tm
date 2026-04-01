# TƏSƏVVÜF MƏKTƏBİ

Bu layihə kitablar və dərslər üçün hazırlanmış tək səhifəlik dərs saytıdır. Bütün məzmun `Markdown` fayllarından götürülür və `index.html` faylına yerləşdirilir. Brauzerdə ayrıca dərs səhifələri açılmır, hər şey bir səhifə daxilində göstərilir.

## Layihə haqqında

- Layihənin yaradılma tarixi: `2026-04-01`
- Layihə süni intellekt köməyi ilə hazırlanıb
- Layihənin hazırlanması zamanı OpenAI əsaslı kod köməkçisi istifadə olunub
- Bu köməkçi layihə strukturunun qurulması, `HTML`, `CSS`, `bash` skriptinin yazılması və texniki düzəlişlər üçün istifadə edilib

## Layihə quruluşu

- `index.html` — əsas səhifə
- `style.css` — dizayn və tema stilləri
- `build_lessons.sh` — dərsləri yığan skript
- `lessons/` — kitab və dərs `Markdown` faylları
- `assets/` — şəkillər və digər fayllar

## Dərs quruluşu

Hər kitab `lessons/` daxilində ayrıca qovluqda saxlanılır.

Nümunə:

```text
lessons/
  book-01/
    book-name.md
    lesson_01.md
    lesson_02.md
  book-02/
    book-name.md
    lesson_01.md
```

- `book-name.md` — kitabın başlığı və kitab səhifəsinin məzmunu
- `lesson_01.md`, `lesson_02.md` və s. — dərslər

## Skript nə edir

`build_lessons.sh` bu işləri görür:

- `pandoc` proqramının olub-olmadığını yoxlayır
- `lessons/` qovluğunu oxuyur
- `book-name.md` faylından kitab səhifəsini yaradır
- hər `lesson_XX.md` faylını HTML-ə çevirir
- kitab və dərs siyahısını yenidən qurur
- bütün `index.html` faylını sıfırdan yenidən yaradır
- şəkil yollarını layihə quruluşuna uyğunlaşdırır

## Skripti necə işə salmaq olar

Terminalda belə işlədin:

```bash
cd /home/user/GiHub/tm
bash build_lessons.sh
```

Əgər fayl icra hüququna malikdirsə, belə də işlədə bilərsiniz:

```bash
cd /home/user/GiHub/tm
./build_lessons.sh
```

## Vacib qeyd

Bu skriptin işləməsi üçün `pandoc` quraşdırılmış olmalıdır. Əgər `pandoc` yoxdursa, skript xəbərdarlıq verəcək və dayanacaq.

## Tema və giriş

- sayt qaranlıq və açıq tema arasında keçid edir
- seçilmiş tema yadda saxlanılır
- giriş parolu brauzerdə yadda saxlanılır
- `Logout` düyməsi yadda saxlanmış girişi silir

## Şəkillər haqqında

Şəkillər əsasən `assets/pictures/` qovluğunda saxlanılır. `Markdown` daxilində şəkil yolları istifadə oluna bilər və skript onları `index.html` üçün uyğun formaya gətirir.

## GitHub Pages

Layihə statik sayt kimi GitHub Pages üzərində işləyə bilər. Ancaq parol qorunması yalnız front-end səviyyəsindədir və tam təhlükəsizlik hesab olunmur.

## AI köməyi

Bu layihənin texniki hissəsi süni intellekt dəstəyi ilə hazırlanıb. Kodun yazılması, fayl strukturunun qurulması, dərs generatorunun yaradılması və dizaynın formalaşdırılması zamanı OpenAI Codex tipli AI köməkçisindən istifadə olunub.

## Lisenziya

Bu layihə `MIT License` ilə yayımlanır. Ətraflı məlumat üçün [LICENSE](/home/user/GiHub/tm/LICENSE) faylına baxın.
