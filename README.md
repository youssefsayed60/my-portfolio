# Youssef Sayed • Creative Flutter Developer Portfolio

A responsive, cross-platform portfolio application engineered with Flutter & Dart for **Web, Android, iOS, and Desktop**. Features interactive animations, 3D perspective hover cards, Projects simulation, and glassmorphism UI.

---

## 🌟 Key Highlights & Creative Features

- 📱 **Multi-Platform & Responsive**: Adapts smoothly to Mobile (<768px), Tablet (768px-1100px), and Desktop (>1100px).
- 🎨 **Frosted Glass & Cyber Theme**: Deep obsidian background (`#0B0F19`) accented with neon cyan (`#00F2FE`), vibrant purple, and emerald glows.
- ✨ **Animated Particle Cosmos Canvas**: Custom painter rendering floating glowing particles and ambient radial gradients.
- 📸 **3D Tilt Profile Card**: Interactive perspective transform responding to cursor movement on desktop, with rotating gradient orbital rings and zoom lightbox.
- ⌨️ **Typewriter Text Banner**: Dynamic rotating titles with glowing cursor.
- 📊 **Stats & Experience Timeline**: Interactive career milestones showcasing achievements at **NTG Clarity** (Flutter Developer & Intern).
- 🧩 **Interactive Skills Matrix**: Filterable categories (Mobile & Flutter, Clean Architecture & Tools, Databases, Other Languages, Soft Skills) with animated mastery bars.
- 🚀 **Flagship Project Showcases**:
  - **SwapSkill**: Peer-to-peer skill exchange & gamified quiz platform.
  - **Hire Me**: Job marketplace & candidate tracking app.
  - Interactive "Explore Deep Architecture" modal breakdowns.
- 💻 **Interactive Projects Sandbox**: Simulated Dart IDE executing `YoussefSayed.dart` with a real-time reactive terminal.
- 📬 **Interactive Connect Section**: Contact form, one-click copy for email and phone, direct WhatsApp and LinkedIn launch.

---

## 🚀 Running the Project

### 🌐 Run on Web (Chrome / Edge)
```bash
flutter run -d chrome
```

### 📱 Run on Mobile (Android / iOS)
```bash
flutter run
```

### 📦 Build Production Web
```bash
flutter build web
```

---

## 📂 Project Structure

```
lib/
├── constants/
│   ├── app_colors.dart       # Design system palette, glows & gradients
│   └── cv_data.dart          # Extracted CV profile, experience & projects
├── models/
│   ├── experience_model.dart # Timeline models
│   ├── project_model.dart    # Project showcase schema
│   └── skill_model.dart      # Skills & categories
├── widgets/
│   ├── background_particles.dart # Ambient glowing particle canvas
│   ├── glass_container.dart      # Frosted glass card with hover physics
│   ├── responsive_builder.dart   # Breakpoint manager
│   ├── section_header.dart       # Stylized section titles
│   └── typewriter_text.dart      # Animated typing banner
├── sections/
│   ├── navbar.dart               # Floating glass navbar + mobile drawer
│   ├── hero_section.dart         # Hero header, 3D photo card, CTA
│   ├── stats_section.dart        # Metric counter badges
│   ├── experience_section.dart   # NTG Clarity career journey
│   ├── skills_section.dart       # Filterable skills matrix
│   ├── projects_section.dart     # Showcase cards & modal dialogs
│   ├── code_playground_section.dart # Live Dart execution terminal
│   ├── contact_section.dart      # Connect form & quick links
│   └── footer_section.dart       # Footer & back-to-top trigger
└── main.dart                     # App entry point & smooth scroll orchestration
```
