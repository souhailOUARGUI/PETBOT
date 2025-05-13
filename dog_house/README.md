# Smart DogHouse - PetBot 🏠🐕

A Flutter-based mobile application for monitoring and controlling a smart dog house environment. The app provides real-time monitoring of your pet's living conditions and allows remote control of various aspects of the dog house.

## 🚀 Features

- **Real-time Monitoring**: Track temperature, humidity, and other environmental factors
- **Smart Controls**: Remotely control lights, heating, and other smart devices
- **User Authentication**: Secure login and user management system
- **Notifications**: Get alerts about important events or changes in the dog house
- **Pet Profiles**: Manage multiple pets and their specific needs
- **Responsive UI**: Beautiful and intuitive interface built with Flutter

## 🛠️ Tech Stack

- **Frontend**: Flutter
- **Backend**: Firebase (Authentication, Firestore, Realtime Database)
- **State Management**: Provider
- **Push Notifications**: Firebase Cloud Messaging (FCM)
- **Local Notifications**: Awesome Notifications
- **Styling**: Custom fonts and Material Design

## 📱 Screens

1. **Authentication**
   - Login/Signup
   - User Profile Management

2. **Dashboard**
   - Environmental controls
   - Real-time sensor data
   - Quick access to features

3. **Pet Management**
   - Add/Edit pet profiles
   - Track pet activities
   - Set preferences

4. **Device Control**
   - Light control
   - Temperature regulation
   - Food and water monitoring

## 🔧 Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / Xcode for emulator
- Firebase account and configuration
- Google Services configuration file (for Android)
- GoogleService-Info.plist (for iOS)

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd petBot
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add Android/iOS apps to your Firebase project
   - Download the configuration files and place them in the appropriate directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔌 Firebase Setup

1. Enable the following Firebase services:
   - Authentication (Email/Password)
   - Firestore Database
   - Realtime Database
   - Cloud Messaging

2. Set up security rules for Firestore and Realtime Database

## 📱 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📧 Contact

For any queries or support, please contact the development team.

---

Built with ❤️ using Flutter
