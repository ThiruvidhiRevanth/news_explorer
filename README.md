# 📰 News Explorer App

A modern news app built with **Flutter**, featuring category-based news, dark/light mode, video news (like Reels), and Firebase authentication with Google Sign-In.

## 📌 Features
- 📰 **Category-based News Fetching** (General, Tech, Sports, etc.)
- 🎥 **Video News Feed** (TikTok-style vertical scrolling)
- 🌙 **Dark & Light Mode Toggle**
- 🔐 **Google Sign-In with Firebase**
- 📡 **Live News Fetching using NewsAPI**

## 🛠️ Setup & Installation

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/ThiruvidhiRevanth/news_explorer.git
cd news-explorer
```

### **2️⃣ Install Dependencies**
```sh
flutter pub get
```

### **3️⃣ Setup Firebase**
- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
- Enable **Authentication** → **Google Sign-In**
- Download the **google-services.json** file (for Android) and place it inside `android/app/`
- For iOS, follow Firebase setup for iOS and add **GoogleService-Info.plist** in `ios/Runner/`

### **4️⃣ Setup API Key for News Fetching**
- Register at [NewsAPI](https://newsapi.org/)
- Copy your API key
- Replace `YOUR_API_KEY` in `api_service.dart`
```dart
final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?category=$category&apiKey=YOUR_API_KEY'));
```

### **5️⃣ Run the App**
```sh
flutter run
```

---

## 📂 Project Structure
```
news-explorer/
│── lib/
│   ├── main.dart           # Entry point of the app
│   ├── api_service.dart    # Handles API requests
│   ├── blocs/             # State management (BLoC)
│   │   ├── news_bloc.dart 
│   │   ├── news_event.dart 
│   │   ├── news_state.dart 
│   ├── models/            # Data models
│   ├── screens/           # UI Screens
│   │   ├── home_screen.dart
│   │   ├── category_screen.dart
│   │   ├── video_news_screen.dart
│   │   ├── profile_screen.dart
│   ├── Theme/             # Dark/Light Theme Management
│── android/               # Android specific config
│── ios/                   # iOS specific config
│── assets/                # Images, icons, etc.
│── pubspec.yaml           # Dependencies
│── README.md              # Project documentation
```

---

