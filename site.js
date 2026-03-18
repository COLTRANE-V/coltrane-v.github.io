const translations = window.COLTRANE_TRANSLATIONS;

const defaultLanguage = 'en';
const storageKey = 'coltrane-language';
const languageToggle = document.getElementById('languageToggle');
const hamburger = document.getElementById('hamburger');
const navMenu = document.getElementById('navMenu');
const navLinks = document.querySelectorAll('.nav-link');

function applyTranslations(language) {
    const dictionary = translations[language] || translations[defaultLanguage];

    document.documentElement.lang = language;
    document.title = dictionary.pageTitle;

    document.querySelectorAll('[data-i18n]').forEach((element) => {
        const key = element.dataset.i18n;
        if (dictionary[key]) {
            element.textContent = dictionary[key];
        }
    });

    document.querySelectorAll('[data-i18n-html]').forEach((element) => {
        const key = element.dataset.i18nHtml;
        if (dictionary[key]) {
            element.innerHTML = dictionary[key];
        }
    });

    document.querySelectorAll('[data-i18n-alt]').forEach((element) => {
        const key = element.dataset.i18nAlt;
        if (dictionary[key]) {
            element.setAttribute('alt', dictionary[key]);
        }
    });

    const nextLanguage = language === 'en' ? 'it' : 'en';
    languageToggle.textContent = nextLanguage.toUpperCase();
    languageToggle.setAttribute('aria-label', dictionary.languageToggleLabel);
    hamburger.setAttribute('aria-label', dictionary.hamburgerLabel);
}

function setLanguage(language) {
    applyTranslations(language);
    localStorage.setItem(storageKey, language);
}

languageToggle.addEventListener('click', () => {
    const currentLanguage = localStorage.getItem(storageKey) || defaultLanguage;
    const nextLanguage = currentLanguage === 'en' ? 'it' : 'en';
    setLanguage(nextLanguage);
});

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
});

navLinks.forEach((link) => {
    link.addEventListener('click', () => {
        hamburger.classList.remove('active');
        navMenu.classList.remove('active');
    });
});

document.addEventListener('click', (event) => {
    if (!hamburger.contains(event.target) && !navMenu.contains(event.target)) {
        hamburger.classList.remove('active');
        navMenu.classList.remove('active');
    }
});

setLanguage(localStorage.getItem(storageKey) || defaultLanguage);