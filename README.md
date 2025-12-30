# Taskfiy

![Taskfiy Logo](https://via.placeholder.com/150)

**Taskfiy** is a smart and organized task management app that helps you organize your daily tasks, track your progress, and get reminders easily and efficiently.

---

## 📌 Key Features

- Create new tasks and set priorities
- Organize tasks into different projects
- Smart reminders with notifications
- Simple and user-friendly interface
- Multi-language support based on device language
- Compatible with modern Android devices

---

## 🛠️ Technologies Used

- **Flutter** for building the UI
- **Dart** as the main programming language
- **Easy Localization** for multi-language support
- **Provider / Riverpod / GetIt** for state management
- **Shared Preferences** for local data storage
- **Firebase** (optional) for syncing data across devices

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/taskfiy.git

2. Navigate to the project folder:
   ```bash
   cd taskfiy

3. Install dependencies:
   ```bash
   flutter pub get

4. Run the app:
   ```bash
    flutter run

##🗂️ Project Structure

lib/
├── main.dart          # Entry point
├── core/              # Constants, themes, and utils
├── features/          # Each feature in separate folder
│   ├── auth/          # Login and registration
│   ├── onboarding/    # Intro for new users
│   └── tasks/         # Task management
├── localization/      # Language files
└── shared/            # General widgets

##🌐 Language Support

  ###fallbackLocale: Locale('en')
    → If the device language is not available, English will be used as default.

  ###saveLocale: true
    → Saves the last used language and applies it automatically on app restart.

##🤝 Contributing

Contributions are welcome!
Feel free to open an Issue or Pull Request for improvements or new ideas.
