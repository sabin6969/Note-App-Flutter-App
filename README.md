---

# Note App

A feature-rich note-taking application built with Flutter. The backend is developed using Node.js, Express, and MongoDB, and is hosted on Railway.

## Key Features

- **Login**: Secure user authentication.
- **Signup**: User registration with validation.
- **Session Management**: Persistent user sessions.
- **Repository Design Pattern**: Structured codebase using repository design pattern.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- The backend server must be running and accessible. For backend setup instructions, refer to the [backend repository](https://github.com/sabin6969/note-app-backend).

### Frontend Setup

1. Clone the frontend repository:
   ```bash
   git clone https://github.com/sabin6969/Note-App-Flutter-App.git
   cd Note-App-Flutter-App
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure the backend server URL in your Flutter app. Open `lib/config.dart` (or equivalent configuration file) and update the `API_BASE_URL` with your backend server URL.

4. Run the Flutter app:
   ```bash
   flutter run
   ```

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Node.js](https://nodejs.org/)
- [Express](https://expressjs.com/)
- [MongoDB](https://www.mongodb.com/)
- [Railway](https://railway.app/)

---
