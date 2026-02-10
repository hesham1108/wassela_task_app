# User Management Mobile Application (Wassela Task)

A robust, scalable Flutter application built for the Wassela technical assessment. This project demonstrates a clean architecture approach, efficient state management, and modern UI practices.

## 📱 Features

### 1. Authentication
*   **Secure Login**: Email and password authentication using `reqres.in`.
*   **Validation**: Robust form validation with regex for email format.
*   **Error Handling**: User-friendly error messages for network failures or invalid credentials.

### 2. User Management
*   **All Users Listing**:
    *   Fetched from `dummyjson.com`.
    *   **infinite Scroll (Pagination)**: Efficiently loads users in chunks.
    *   **Pull-to-Refresh**: Updates the list with fresh data.
    *   **Loading & Error States**: smooth UX during data fetching or failures.
*   **User Details**:
    *   Rich UI displaying user profile, contact info, and employment details.
    *   **Hero Animations**: Smooth transitions between list and detail views.
*   **Update User**:
    *   Edit mode to modify user details (First User Name, Last User Name, Email).
    *   Simulates API updates with optimistic UI updates.

### 3. Settings & Localization
*   **Language Support**: Fully localized in **English** and **Arabic**.
*   **Persistence**: Saves language preference locally.
*   **Logout**: Secure logout with confirmation dialog.

---

## 🛠 Technical Architecture

This project follows **Clean Architecture** principles to ensure separation of concerns, testability, and scalability.

### Structure
```
lib/
├── core/                   # Core functionality (Networking, DI, Theming, Helpers)
├── features/               # Feature-based folders (Auth, Users, Splash, Settings)
│   ├── data/               # Data Layer (Models, Datasources, Repositories)
│   ├── domain/             # Domain Layer (Entities, Abstract Repositories)
│   └── presentation/       # Presentation Layer (UI, Cubits, Widgets)
└── main.dart               # App Entry Point
```

### Key Technologies
*   **State Management**: `flutter_bloc` (Cubit) for predictable state management.
*   **Networking**: `dio` with interceptors for robust API communication.
*   **Dependency Injection**: `get_it` for decoupling dependencies.
*   **Routing**: Named routes logic for scalable navigation.
*   **Localization**: `easy_localization` for handling multi-language support.
*   **Responsive UI**: `responsive_sizer` for adaptive layouts on any screen size.
*   **Functional Programming**: `dartz` (Either) for clean error handling.

---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (3.27.0 or higher recommended)
*   Dart SDK

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/wassela_task_app.git
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the application**:
    ```bash
    flutter run
    ```

---

## 🧪 Testing Credentials (ReqRes)

To test the login functionality, use the following credentials provided by ReqRes:

*   **Email**: `eve.holt@reqres.in`
*   **Password**: `cityslicka` (or any password)

---

## 📸 Screenshots

| Login Screen | Users List | User Details |
|:---:|:---:|:---:|
| *(Add Login Screenshot)* | *(Add List Screenshot)* | *(Add Details Screenshot)* |

---

## 👨‍💻 Author

**Hesham** - Flutter Developer
Built with ❤️ and Dart.
