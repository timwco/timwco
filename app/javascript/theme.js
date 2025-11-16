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
      if (systemTheme === THEMES.DARK) {
        html.classList.remove('light');
        html.classList.add('dark');
      } else {
        html.classList.remove('dark');
        html.classList.add('light');
      }
    } else {
      if (theme === THEMES.DARK) {
        html.classList.remove('light');
        html.classList.add('dark');
      } else {
        html.classList.remove('dark');
        html.classList.add('light');
      }
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
        button.classList.add('bg-secondary-700');
        button.classList.add('text-white');
        button.classList.add('dark:bg-primary-700');
        button.classList.add('dark:text-white');
        // Remove Inactive Classes
        button.classList.remove('bg-gray-button');
        button.classList.remove('text-black');
      } else {
        button.classList.add('bg-gray-button');
        button.classList.add('text-black');
        // Remove Active Classes
        button.classList.remove('bg-secondary-700');
        button.classList.remove('text-white');
        button.classList.remove('dark:bg-primary-700');
        button.classList.remove('dark:text-white');
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
let themeManager = null;

function initializeThemeManager() {
  // Only create one instance
  if (!themeManager) {
    themeManager = new ThemeManager();
  } else {
    // Reinitialize on navigation
    themeManager.initTheme();
    themeManager.attachListeners();
  }
}

// Handle both initial load and Turbo navigation
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initializeThemeManager);
} else {
  initializeThemeManager();
}

// Reinitialize after Turbo navigation
document.addEventListener('turbo:load', initializeThemeManager);

// Also run immediately to prevent flash
(function() {
  const savedTheme = localStorage.getItem(THEME_KEY) || THEMES.SYSTEM;
  const html = document.documentElement;

  if (savedTheme === THEMES.SYSTEM) {
    const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
      ? THEMES.DARK
      : THEMES.LIGHT;
    if (systemTheme === THEMES.DARK) {
      html.classList.remove('light');
      html.classList.add('dark');
    } else {
      html.classList.remove('dark');
      html.classList.add('light');
    }
  } else {
    if (savedTheme === THEMES.DARK) {
      html.classList.remove('light');
      html.classList.add('dark');
    } else {
      html.classList.remove('dark');
      html.classList.add('light');
    }
  }
})();
