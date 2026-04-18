# 🚀 Flutter Portfolio App

A **highly creative, interactive, and modern** Flutter developer portfolio app — fully cross-platform (Android, iOS, Web, Desktop).

---

## ✨ Features

- 🎨 **Dark / Light theme** with animated toggle
- 🌀 **Animated hero section** with typing-effect role cycler
- 📜 **Scroll-based reveal animations** throughout
- 🃏 **Hover effects** on all interactive cards (web/desktop)
- 🖥️ **Fully responsive** — mobile, tablet, desktop
- 🧠 **Single source of truth** — `lib/data/portfolio_data.dart`
- 🔗 **Dynamic section rendering** from config
- 📊 **Animated skill bars** with visibility detection
- 🗺️ **Experience timeline** with expandable cards
- 🗂️ **Project filtering** by category
- 📨 **Contact form** with validation + animated feedback
- 🌊 **Animated background blobs** in hero section
- ⬆️ **Scroll-to-top FAB**
- 🧩 **Clean Architecture** with Provider state management

---

## 🏗️ Folder Structure

```
lib/
├── main.dart                    # Entry point
├── portfolio_page.dart          # Main page (assembles all sections)
├── core/
│   └── constants/
│       └── image_constants.dart
├── data/
│   └── portfolio_data.dart      # 📌 SINGLE SOURCE OF TRUTH — edit here
├── sections/
│   ├── hero_section.dart
│   ├── about_section.dart
│   ├── skills_section.dart
│   ├── experience_section.dart
│   ├── projects_section.dart
│   ├── achievements_section.dart
│   └── contact_section.dart
├── widgets/
│   ├── navbar.dart
│   ├── footer.dart
│   ├── animated_bg.dart
│   ├── auto_flip_widged.dart
│   ├── gradient_text.dart
│   ├── hover_card.dart
│   ├── scroll_reveal.dart
│   ├── section_header.dart
│   ├── skill_bar.dart
│   └── tech_chip.dart
├── services/
│   ├── navigation_provider.dart
│   └── contact_service.dart
├── utils/
│   ├── utils.dart
└── theme/
    ├── app_theme.dart
    └── theme_provider.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK **≥ 3.19.0**
- Dart SDK **≥ 3.3.0**

### Installation

```bash
# 1. Clone / extract the project
cd flutter_portfolio

# 2. Install dependencies
flutter pub get

# 3. Run on your preferred platform
flutter run                        # Default device
flutter run -d chrome              # Web
flutter run -d macos               # macOS desktop
flutter run -d windows             # Windows desktop
```

---

## ✏️ Customization

### Updating Portfolio Content

All content lives in one file: **`lib/data/portfolio_data.dart`**

| Field | Description |
|-------|-------------|
| `name` | Your full name |
| `tagline` | Hero section tagline |
| `email`, `phone`, `location` | Contact info |
| `roles` | Typing animation roles in hero |
| `socialLinks` | GitHub, LinkedIn, Twitter, etc. |
| `skillCategories` | Skills with progress levels |
| `experiences` | Timeline entries |
| `projects` | Project cards with stats |
| `achievements` | Certifications and awards |
| `contactFormConfig` | Form labels and messages |
| `sections` | Toggle sections on/off |

### Adding / Removing Sections

1. Add/remove an entry in `PortfolioData.sections` in `portfolio_data.dart`
2. Add/remove the corresponding widget in `portfolio_page.dart`
3. Add the key to `NavigationProvider.sectionKeys` list

### Connecting the Contact Form

Replace the simulated API in `lib/services/contact_service.dart`:

```dart
static Future<bool> sendMessage({...}) async {
  final response = await http.post(
    Uri.parse('https://your-api.com/contact'),
    body: {'name': name, 'email': email, 'message': message},
  );
  return response.statusCode == 200;
}
```

### Replacing Placeholder Images

Drop real images into `assets/images/` matching the filenames referenced in `portfolio_data.dart`:
- `avatar.png` — your profile photo
- `project_*.png` — project screenshots

---

## 🎨 Theme Customization

Edit `lib/theme/app_theme.dart` to update:
- **Colors**: `AppColors` class
- **Typography**: `_buildTextTheme()` — uses Google Fonts
- **Dark/Light backgrounds**, card colors, borders

---

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `animate_do` | Fade/slide animations |
| `animated_text_kit` | Typing effect |
| `visibility_detector` | Scroll-triggered animations |
| `google_fonts` | Typography |
| `font_awesome_flutter` | Social icons |
| `url_launcher` | Opening links |
| `flutter_animate` | Micro-animations |

---

## 📱 Platform Support

| Platform | Status |
|----------|--------|
| Android | ✅ |
| iOS | ✅ |
| Web | ✅ |
| macOS | ✅ |
| Windows | ✅ |
| Linux | ✅ |

---

## 🤝 License

MIT — feel free to use, modify, and share.

---

*Built with 💜 using Flutter*
