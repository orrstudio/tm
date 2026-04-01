#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LESSONS_DIR="$PROJECT_ROOT/lessons"
INDEX_FILE="$PROJECT_ROOT/index.html"

write_full_index() {
  local output_file="$1"
  local toc_file="$2"
  local lessons_file="$3"

  cat > "$output_file" <<'HTML'
<!DOCTYPE html>
<html lang="az">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>TƏSƏVVÜF MƏKTƏBİ</title>
  <meta name="description" content="Markdown fayllarından yaradılan adaptiv dərs saytı.">
  <link rel="stylesheet" href="style.css">
</head>
<body class="dark-theme">
  <section class="auth-screen" id="authScreen" aria-labelledby="authTitle">
    <div class="auth-card">
      <img class="auth-logo" src="assets/tm.png" alt="Təsəvvüf Məktəbi loqosu">
      <h1 id="authTitle" class="auth-title">Təsəvvüf məktəbinin kitabxanasına GİRİŞ</h1>
      <div class="auth-form" id="authForm">
        <input class="auth-input" id="passwordInput" name="password" type="password" autocomplete="current-password" placeholder="Şifrəni yaz" required>
        <button class="auth-submit" id="authSubmit" type="button">Daxil ol</button>
        <p class="auth-message" id="authMessage" aria-live="polite"></p>
      </div>
    </div>
  </section>

  <div class="site-shell">
    <header class="site-header">
      <div class="site-header__copy">
        <div class="site-brand">
          <img class="site-brand__logo" src="assets/tm.png" alt="Təsəvvüf Məktəbi loqosu">
          <h1 class="site-title">TƏSƏVVÜF MƏKTƏBİ</h1>
        </div>
        <p class="site-subtitle">DƏRS KİTABXANASI</p>
      </div>
      <div class="site-header__actions">
        <button class="menu-toggle" id="menuToggle" type="button" aria-expanded="false" aria-controls="lessonNavigation" aria-label="Dərs menyusunu aç">
          <span class="menu-toggle__line"></span>
          <span class="menu-toggle__line"></span>
          <span class="menu-toggle__line"></span>
        </button>
        <button class="theme-toggle" id="themeToggle" type="button" aria-label="Tünd və açıq tema arasında keçid et">
          <svg class="theme-toggle__icon theme-toggle__icon--sun" viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="12" r="4.2" fill="currentColor"></circle>
            <path d="M12 1.8v3.1M12 19.1v3.1M4.1 4.1l2.2 2.2M17.7 17.7l2.2 2.2M1.8 12h3.1M19.1 12h3.1M4.1 19.9l2.2-2.2M17.7 6.3l2.2-2.2" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"></path>
          </svg>
          <svg class="theme-toggle__icon theme-toggle__icon--moon" viewBox="0 0 24 24" aria-hidden="true">
            <path d="M14.8 2.6a8.9 8.9 0 1 0 6.6 14.8 9.7 9.7 0 1 1-6.6-14.8Z" fill="currentColor"></path>
          </svg>
        </button>
        <button class="logout-button" id="logoutButton" type="button" aria-label="Çıxış et">
          <svg class="logout-button__icon" viewBox="0 0 24 24" aria-hidden="true">
            <path d="M4 3.5h8v17H4z" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linejoin="round"></path>
            <path d="M10 12h9" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"></path>
            <path d="M15.5 8.5 19 12l-3.5 3.5" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"></path>
            <circle cx="9.2" cy="12" r="0.9" fill="currentColor"></circle>
          </svg>
        </button>
      </div>
    </header>

    <div class="mobile-backdrop" id="mobileBackdrop" hidden></div>

    <div class="layout">
      <aside class="toc-panel" id="lessonNavigation" aria-label="Mündəricat">
        <div class="toc-panel__header">

        </div>
        <div class="toc" id="lessonToc">
          <button class="panel-button toc-button is-active" type="button" data-panel-target="homePanel" aria-selected="true">
            <span class="toc-button__eyebrow">XOŞ GƏLMİSİNİZ</span>
          </button>
HTML

  cat "$toc_file" >> "$output_file"

  cat >> "$output_file" <<'HTML'
        </div>
      </aside>

      <main class="lesson-stage">
        <section class="content-panel home-panel is-visible" id="homePanel" aria-labelledby="homePanelTitle">
          <div class="home-hero">
            <p class="eyebrow">Buradan başlayın</p>
            <h2 id="homePanelTitle">Kitablar və dərslər bir yerdə toplanıb.</h2>
            <p class="home-hero__lead">Menyudan kitab adını seçin.</p>
          </div>

          <div class="home-grid">
            <article class="home-card">
              <h3>Əvvəl kitablar</h3>
              <p>Menyu dərsləri kitab başlıqları altında toplanır.</p>
            </article>
            <article class="home-card">
              <h3>Qovluq quruluşu</h3>
              <p>Hər kitab üçün ayrıca qovluq var.</p>
            </article>
            <article class="home-card">
              <h3>Tək səhifədə oxu</h3>
              <p>Seçilmiş dərs görünür əvvəlki dərs isə gizlənir.</p>
            </article>
          </div>
        </section>
HTML

  cat "$lessons_file" >> "$output_file"

  cat >> "$output_file" <<'HTML'
      </main>
    </div>
  </div>

  <script>
    (function () {
      const storageKey = "school-lessons-theme";
      const authKey = "school-lessons-auth";
      const passwordValue = "okul";
      const body = document.body;
      const passwordInput = document.getElementById("passwordInput");
      const authSubmit = document.getElementById("authSubmit");
      const authMessage = document.getElementById("authMessage");
      const logoutButton = document.getElementById("logoutButton");
      const themeButtons = Array.from(document.querySelectorAll(".theme-toggle"));
      const menuToggle = document.getElementById("menuToggle");
      const navigation = document.getElementById("lessonNavigation");
      const mobileBackdrop = document.getElementById("mobileBackdrop");
      const panelButtons = Array.from(document.querySelectorAll(".panel-button"));
      const bookButtons = Array.from(document.querySelectorAll(".book-toggle"));
      const panels = Array.from(document.querySelectorAll(".content-panel"));

      function safeStorageGet(key) {
        try {
          return localStorage.getItem(key);
        } catch (error) {
          return null;
        }
      }

      function safeStorageSet(key, value) {
        try {
          localStorage.setItem(key, value);
        } catch (error) {
          return;
        }
      }

      function applyTheme(theme) {
        const nextTheme = theme === "light-theme" ? "light-theme" : "dark-theme";
        body.classList.remove("dark-theme", "light-theme");
        body.classList.add(nextTheme);
        themeButtons.forEach(function (button) {
          button.setAttribute(
            "aria-label",
            nextTheme === "dark-theme"
              ? "Açıq temaya keç"
              : "Tünd temaya keç"
          );
        });
        safeStorageSet(storageKey, nextTheme);
      }

      function setMenuState(isOpen) {
        if (!menuToggle || !navigation || !mobileBackdrop) {
          return;
        }
        navigation.classList.toggle("is-open", isOpen);
        menuToggle.setAttribute("aria-expanded", String(isOpen));
        mobileBackdrop.hidden = !isOpen;
      }

      function setAuthorized(isAuthorized) {
        body.classList.toggle("is-authorized", isAuthorized);
      }

      function closeAllBooks() {
        bookButtons.forEach(function (button) {
          const group = button.closest(".book-group");
          button.setAttribute("aria-expanded", "false");
          button.classList.remove("is-open");
          if (group) {
            group.classList.remove("is-open");
          }
        });
      }

      function setBookOpen(bookId, shouldOpen) {
        closeAllBooks();
        if (!shouldOpen) {
          return;
        }
        bookButtons.forEach(function (button) {
          if (button.dataset.bookTarget !== bookId) {
            return;
          }
          const group = button.closest(".book-group");
          button.setAttribute("aria-expanded", "true");
          button.classList.add("is-open");
          if (group) {
            group.classList.add("is-open");
          }
        });
      }

      function showPanel(panelId) {
        panels.forEach(function (panel) {
          const isActive = panel.id === panelId;
          panel.hidden = !isActive;
          panel.classList.toggle("is-visible", isActive);
        });

        panelButtons.forEach(function (button) {
          const isActive = button.dataset.panelTarget === panelId;
          button.classList.toggle("is-active", isActive);
          button.setAttribute("aria-selected", String(isActive));
        });

        window.scrollTo({ top: 0, behavior: "auto" });
        setMenuState(false);
      }

      function tryLogin() {
        if (!passwordInput) {
          return;
        }
        if (passwordInput.value.trim() === passwordValue) {
          safeStorageSet(authKey, "ok");
          if (authMessage) {
            authMessage.textContent = "";
          }
          passwordInput.value = "";
          setAuthorized(true);
          showPanel("homePanel");
        } else if (authMessage) {
          authMessage.textContent = "Parol yanlışdır. Yenidən cəhd edin.";
        }
      }

      applyTheme(safeStorageGet(storageKey) || "dark-theme");

      themeButtons.forEach(function (button) {
        button.addEventListener("click", function () {
          const nextTheme = body.classList.contains("dark-theme") ? "light-theme" : "dark-theme";
          applyTheme(nextTheme);
        });
      });

      panelButtons.forEach(function (button) {
        button.addEventListener("click", function () {
          showPanel(button.dataset.panelTarget);
        });
      });

      bookButtons.forEach(function (button) {
        button.addEventListener("click", function () {
          const shouldOpen = button.getAttribute("aria-expanded") !== "true";
          setBookOpen(button.dataset.bookTarget, shouldOpen);
          showPanel(button.dataset.panelTarget);
        });
      });

      if (menuToggle) {
        menuToggle.addEventListener("click", function () {
          setMenuState(!navigation.classList.contains("is-open"));
        });
      }

      if (mobileBackdrop) {
        mobileBackdrop.addEventListener("click", function () {
          setMenuState(false);
        });
      }

      if (authSubmit) {
        authSubmit.addEventListener("click", tryLogin);
      }

      if (passwordInput) {
        passwordInput.addEventListener("keydown", function (event) {
          if (event.key === "Enter") {
            event.preventDefault();
            tryLogin();
          }
        });
      }

      if (logoutButton) {
        logoutButton.addEventListener("click", function () {
          safeStorageSet(authKey, "");
          setMenuState(false);
          showPanel("homePanel");
          setAuthorized(false);
          if (passwordInput) {
            passwordInput.focus();
          }
        });
      }

      setAuthorized(safeStorageGet(authKey) === "ok");
      showPanel("homePanel");
      if (!body.classList.contains("is-authorized") && passwordInput) {
        passwordInput.focus();
      }
    }());
  </script>
</body>
</html>
HTML
}

escape_html() {
  local text="$1"
  text=${text//&/&amp;}
  text=${text//</&lt;}
  text=${text//>/&gt;}
  text=${text//\"/&quot;}
  text=${text//\'/&#39;}
  printf '%s' "$text"
}

slugify() {
  local text="$1"
  text="${text,,}"
  text="${text// /-}"
  text="$(printf '%s' "$text" | tr -cs 'a-z0-9_-' '-')"
  text="${text##-}"
  text="${text%%-}"
  printf '%s' "${text:-item}"
}

title_from_markdown() {
  local file="$1"
  local line
  line="$(grep -m 1 -E '^[[:space:]]*# ' "$file" || true)"
  if [[ -n "$line" ]]; then
    line="${line#\# }"
    line="${line#"${line%%[![:space:]]*}"}"
    printf '%s' "$line"
  fi
}

pretty_name() {
  local text="$1"
  text="${text//_/ }"
  text="${text//-/ }"
  printf '%s' "$text"
}

lesson_title_from_file() {
  local file="$1"
  local title basename lesson_num
  title="$(title_from_markdown "$file")"
  if [[ -n "$title" ]]; then
    printf '%s' "$title"
    return
  fi
  basename="$(basename "$file" .md)"
  if [[ "$basename" =~ ([0-9]+)$ ]]; then
    lesson_num="${BASH_REMATCH[1]}"
    printf 'Lesson %s' "$lesson_num"
  else
    pretty_name "$basename"
  fi
}

book_title_from_dir() {
  local dir_name="$1"
  local title_file
  local title

  for title_file in \
    "$LESSONS_DIR/$dir_name/book-name.md" \
    "$LESSONS_DIR/$dir_name/_book.md"; do
    if [[ -f "$title_file" ]]; then
      title="$(title_from_markdown "$title_file")"
      if [[ -n "$title" ]]; then
        printf '%s' "$title"
        return
      fi
    fi
  done

  pretty_name "$dir_name"
}

rewrite_relative_paths() {
  local html_file="$1"
  perl -0pi -e '
    my $prefix = $ENV{"LESSON_PREFIX"};
    $prefix =~ s{/\z}{};
    s{\b(src|href)="/assets/([^"]+)"}{$1 . "=\"assets/$2\""}ge;
    s{\b(src|href)="(?![a-z]+:|/|#|mailto:|tel:|data:|assets/)([^"]+)"}{$1 . "=\"" . ($prefix eq "." ? $2 : "$prefix/$2") . "\""}ge;
  ' "$html_file"
}

main() {
  if ! command -v pandoc >/dev/null 2>&1; then
    echo "Error: pandoc is not installed or not in PATH." >&2
    echo "Ошибка: pandoc не установлен или отсутствует в PATH." >&2
    exit 1
  fi

  if [[ ! -d "$LESSONS_DIR" ]]; then
    echo "Error: lessons/ directory not found at $LESSONS_DIR" >&2
    exit 1
  fi

  local toc_tmp lessons_tmp output_tmp fragment_tmp
  toc_tmp="$(mktemp)"
  lessons_tmp="$(mktemp)"
  output_tmp="$(mktemp)"
  fragment_tmp="$(mktemp)"
  trap 'rm -f "${toc_tmp:-}" "${lessons_tmp:-}" "${output_tmp:-}" "${fragment_tmp:-}"' EXIT

  : > "$toc_tmp"
  : > "$lessons_tmp"

  mapfile -t book_dirs < <(find "$LESSONS_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

  local book_dir book_key book_slug book_title
  local lesson_file lesson_id lesson_title relative_dir
  local book_name_file book_panel_relative_dir

  for book_dir in "${book_dirs[@]}"; do
    book_key="$(basename "$book_dir")"
    book_slug="book-$(slugify "$book_key")"
    book_title="$(book_title_from_dir "$book_key")"

    mapfile -t lesson_files < <(find "$book_dir" -maxdepth 1 -type f -name '*.md' ! -name '_book.md' ! -name 'book-name.md' | sort)
    if [[ ${#lesson_files[@]} -eq 0 ]]; then
      continue
    fi

    cat >> "$toc_tmp" <<EOF
          <section class="book-group">
            <button class="panel-button book-toggle" type="button" data-panel-target="${book_slug}-panel" data-book-target="$book_slug" aria-expanded="false" aria-selected="false">
              <span class="book-toggle__title">$(escape_html "$book_title")</span>
              <span class="book-toggle__icon" aria-hidden="true"></span>
            </button>
            <div class="book-lessons" id="${book_slug}-lessons">
EOF

    for book_name_file in "$book_dir/book-name.md" "$book_dir/_book.md"; do
      if [[ -f "$book_name_file" ]]; then
        book_panel_relative_dir="$(dirname "${book_name_file#$PROJECT_ROOT/}")"
        pandoc --from=gfm --to=html5 "$book_name_file" -o "$fragment_tmp"
        LESSON_PREFIX="$book_panel_relative_dir" rewrite_relative_paths "$fragment_tmp"

        cat >> "$lessons_tmp" <<EOF
        <article class="content-panel lesson" id="${book_slug}-panel" hidden aria-labelledby="${book_slug}-title">
          <div class="lesson-card">
            <div class="lesson-content">
$(sed 's/^/              /' "$fragment_tmp")
            </div>
          </div>
        </article>
EOF
        break
      fi
    done

    for lesson_file in "${lesson_files[@]}"; do
      lesson_id="$(basename "$lesson_file" .md)"
      lesson_id="$(slugify "${book_key}-${lesson_id}")"
      lesson_title="$(lesson_title_from_file "$lesson_file")"
      relative_dir="$(dirname "${lesson_file#$PROJECT_ROOT/}")"

      pandoc --from=gfm --to=html5 "$lesson_file" -o "$fragment_tmp"
      LESSON_PREFIX="$relative_dir" rewrite_relative_paths "$fragment_tmp"

      cat >> "$toc_tmp" <<EOF
              <button class="panel-button lesson-link" type="button" data-panel-target="$lesson_id" data-book-parent="$book_slug" aria-selected="false">
                <span class="lesson-link__label">$(escape_html "$lesson_title")</span>
              </button>
EOF

      cat >> "$lessons_tmp" <<EOF
        <article class="content-panel lesson" id="$lesson_id" hidden aria-labelledby="${lesson_id}-title">
          <div class="lesson-card">
            <div class="lesson-content">
$(sed 's/^/              /' "$fragment_tmp")
            </div>
          </div>
        </article>
EOF
    done

    cat >> "$toc_tmp" <<'EOF'
            </div>
          </section>
EOF
  done

  write_full_index "$output_tmp" "$toc_tmp" "$lessons_tmp"

  if [[ -f "$INDEX_FILE" ]] && cmp -s "$output_tmp" "$INDEX_FILE"; then
    echo "No changes detected. index.html is already up to date."
    exit 0
  fi

  mv "$output_tmp" "$INDEX_FILE"
  echo "Updated $INDEX_FILE from lessons grouped by book folders."
}

main "$@"
