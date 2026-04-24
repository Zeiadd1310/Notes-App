# 📝 Notes App

A simple Flutter notes app built with Firebase Firestore and BLoC/Cubit state management.

## ✨ Features

- Add notes with title and description
- Real-time updates via Firestore streams
- Delete notes

## 🛠️ Tech Stack

- Flutter / Dart
- Firebase Firestore
- BLoC / Cubit
- Clean Architecture (Repository Pattern)

## 🏗️ Architecture Overview

The app follows a clean layered architecture: the UI layer communicates only with the Cubit, the Cubit handles state and delegates data operations to the Repository, and the Repository is the only layer that talks to Firestore.

## 🚀 Setup

1. Clone the repo
2. Run `flutter pub get`
3. Run `flutterfire configure`
4. Run `flutter run`

> Make sure you have a Firebase project set up with Firestore enabled.