# Tourix

## 📖 Project Overview

Tourix is an AI-powered tourism mobile application designed to enhance the travel experience in Egypt. The application helps users discover hidden attractions, generate personalized travel plans, complete gamified missions, and explore destinations through an interactive and engaging experience..

---

# 🛠 Tech Stack

### Frontend

- Flutter
- Dart

### APIs & Services

- Google Maps API
- Geolocation
- AI Recommendation API


---

# 📂 Project Structure

```text
lib/
│
├── core/
│   ├── theme/
│   ├── constants/
│   ├── services/
│   ├── widgets/
│   └── utils/
│
├── features/
│   ├── splash/
│   ├── welcome/
│   ├── auth/
│   ├── home/
│   ├── ai_trip_planner/
│   ├── discover/
│   ├── map/
│   ├── quests/
│   ├── mission/
│   ├── profile/
│   └── place_details/
│
└── main.dart
```

---

# 🏗 Architecture

The project follows a **Feature-First Architecture**.

Each feature is organized in its own folder to improve:

- Scalability
- Maintainability
- Team Collaboration
- Code Organization

Shared components, themes, constants, and services are placed inside the `core` folder.

---

# 📦 Packages

The project currently uses the following packages:

- go_router
- flutter_bloc
- equatable
- dio
- flutter_svg
- google_fonts
- google_maps_flutter
- geolocator
- mobile_scanner
- shared_preferences
- cached_network_image

---

# ⚙ Environment Setup

## Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git

---

## Installation

```bash
git clone <repository_url>

cd tourix

flutter pub get

flutter run
```

---

# 🚀 Planned Features

- Authentication
- AI Trip Planner
- Discover Hidden Places
- Google Maps Integration
- QR Mission Verification
- Gamification
- User Profile
- Daily Challenges
- Personalized Recommendations

---

# 👥 Team

Developed by Team Tourix for RedDev.
