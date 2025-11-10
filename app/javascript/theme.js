// Theme switching functionality
const THEME_KEY = 'theme-preference';
const THEMES = {
  LIGHT: 'light',
  DARK: 'dark',
  SYSTEM: 'system'
};

class ThemeManager {
  constructor() {
    this.initTheme();
    this.attachListeners();
    this.watchSystemTheme();
  }

  initTheme() {
    const savedTheme = localStorage.getItem(THEME_KEY) || THEMES.SYSTEM;
    this.applyTheme(savedTheme);
    this.updateButtonStates(savedTheme);
  }

  applyTheme(theme) {
    const html = document.documentElement;

    if (theme === THEMES.SYSTEM) {
      const systemTheme = this.getSystemTheme();
      html.classList.toggle('dark', systemTheme === THEMES.DARK);
    } else {
      html.classList.toggle('dark', theme === THEMES.DARK);
    }

    localStorage.setItem(THEME_KEY, theme);
  }

  getSystemTheme() {
    return window.matchMedia('(prefers-color-scheme: dark)').matches
      ? THEMES.DARK
      : THEMES.LIGHT;
  }

  updateButtonStates(activeTheme) {
    const buttons = {
      [THEMES.LIGHT]: document.getElementById('theme-light'),
      [THEMES.DARK]: document.getElementById('theme-dark'),
      [THEMES.SYSTEM]: document.getElementById('theme-system')
    };

    Object.entries(buttons).forEach(([theme, button]) => {
      if (!button) return;

      const isActive = theme === activeTheme;

      if (isActive) {
        button.style.backgroundColor = 'var(--color-primary-700)';
        button.style.color = 'var(--color-white)';
      } else {
        button.style.backgroundColor = 'var(--base-bg-base)';
        button.style.color = 'var(--base-text-secondary)';
      }
    });
  }

  attachListeners() {
    document.getElementById('theme-light')?.addEventListener('click', () => {
      this.applyTheme(THEMES.LIGHT);
      this.updateButtonStates(THEMES.LIGHT);
    });

    document.getElementById('theme-dark')?.addEventListener('click', () => {
      this.applyTheme(THEMES.DARK);
      this.updateButtonStates(THEMES.DARK);
    });

    document.getElementById('theme-system')?.addEventListener('click', () => {
      this.applyTheme(THEMES.SYSTEM);
      this.updateButtonStates(THEMES.SYSTEM);
    });
  }

  watchSystemTheme() {
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');

    mediaQuery.addEventListener('change', (e) => {
      const currentTheme = localStorage.getItem(THEME_KEY);
      if (currentTheme === THEMES.SYSTEM) {
        this.applyTheme(THEMES.SYSTEM);
      }
    });
  }
}

// Initialize theme manager when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => new ThemeManager());
} else {
  new ThemeManager();
}

// Also run immediately to prevent flash
(function() {
  const savedTheme = localStorage.getItem(THEME_KEY) || THEMES.SYSTEM;
  const html = document.documentElement;

  if (savedTheme === THEMES.SYSTEM) {
    const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
      ? THEMES.DARK
      : THEMES.LIGHT;
    html.classList.toggle('dark', systemTheme === THEMES.DARK);
  } else {
    html.classList.toggle('dark', savedTheme === THEMES.DARK);
  }
})();
