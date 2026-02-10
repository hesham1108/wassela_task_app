# User Management App

A robust Flutter application demonstrating **Clean Architecture**, **Cubit State Management**, and API integration with **Reqres.in** and **DummyJson**.

## � Features

### 🔐 Authentication
*   **Secure Login**: Email and password authentication using `reqres.in`.
*   **Form Validation**: Real-time validation for email (regex) and password.
*   **Security**: Secure token storage using `flutter_secure_storage`.
*   **User Experience**: Loading states, error handling, and password visibility toggle.

### 👥 User Listing
*   **Data Source**: Fetched from `dummyjson.com`.
*   **Infinite Scroll (Pagination)**: Efficiently loads users in chunks of 10.
*   **Pull-to-Refresh**: Updates the list with fresh data.
*   **Robust States**: Handles Loading, Success, Error, and "Loading More" states seamlessly.

### 👤 User Details
*   **Rich Profile**: Displays full user information (Name, Email, Job, etc.).
*   **Interactive UI**: Hero animations for smooth transitions.
*   **Edit Functionality**: Allows updating user details (Name, Last Name, Email).
*   **Optimistic UI**: Immediate UI updates upon successful modification.

### 🌍 Localization & Settings
*   **Multi-language**: Full support for **English** and **Arabic**.
*   **Preferences**: Persists language choice locally.
*   **Secure Logout**: Wipes session data and navigation history.

---

## 🏗 Architecture

This project strictly follows **Clean Architecture** principles, separating concerns into three layers per feature:

```
lib/features/
├── auth/
│   ├── data/           # Remote Datasource, Models, Repo Implementation
│   ├── domain/         # Repo Interface (Contract)
│   └── presentation/   # Cubit, Screens, Widgets
└── users/
    ├── data/
    ├── domain/
    └── presentation/
```

### State Management
*   **Cubit (`flutter_bloc`)**: For predictable and reactive state management.
*   **One Cubit per Feature**: `AuthCubit` for login logic, `UsersCubit` for list and details.
*   **Functional Error Handling**: Using `dartz` (Either) to handle Failures vs Success clean responses.

### Networking
*   **Dio**: Advanced HTTP client with interceptors.
*   **ApiService**: A generic wrapper for GET, POST, PUT, DELETE requests.
*   **Repository Pattern**: Abstracting data sources from the UI.
*   **Error Handling**: Centralized `ApiErrorHandler` mapping server errors to user-friendly messages.

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/             # Dependency Injection Setup (get_it)
│   ├── helpers/        # Constants, Extensions, UI Helpers
│   ├── networking/     # ApiService, Urls, Error Models
│   ├── routing/        # AppRouter and Routes
│   ├── theming/        # App Colors and TextStyles
│   └── widgets/        # Reusable global widgets
├── features/
│   ├── auth/           # Login & Authentication Logic
│   ├── users/          # Users List & Details Logic
│   └── settings/       # Settings & Localization Logic
└── main.dart           # Entry Point
```

---

## 🛠 Dependencies

| Package | Purpose |
| :--- | :--- |
| `flutter_bloc` | State Management (Cubit) |
| `get_it` | Dependency Injection (Service Locator) |
| `dio` | HTTP Client for API calls |
| `dartz` | Functional programming (Either type) |
| `responsive_sizer` | Responsive UI for all screens |
| `flutter_secure_storage` | Encrypted storage for Tokens |
| `easy_localization` | Internationalization (En/Ar) |
| `shared_preferences` | Local storage for simple settings |

---

## 🧪 Service Credentials

The app uses **ReqRes.in** for authentication. Use these credentials to log in:

| Field | Value |
| :--- | :--- |
| **Email** | `eve.holt@reqres.in` |
| **Password** | `cityslicka` |

> **Note**: The Users feature fetches data from `dummyjson.com/users`, which is a public API and does not require the ReqRes token. The app handles this distinction automatically.

---

## 🏁 Getting Started

### Prerequisites
*   Flutter SDK 3.10+
*   Dart SDK 3.0+

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/wassela_task_app.git
    ```

2.  **Navigate to project directory**:
    ```bash
    cd wassela_task_app
    ```

3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

4.  **Run the app**:
    ```bash
    flutter run
    ```
