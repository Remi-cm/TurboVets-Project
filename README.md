# Flutter Chat & Internal Tools Dashboard

This repository contains the submission for the **"Messaging App with Embedded Internal Tools Dashboard"** assessment. It consists of two distinct applications that work together:

* **`flutter_app/`**: A native Flutter messaging app featuring an **AI Support Agent** (powered by Firebase AI/Gemini) and an embedded **WebView**.
* **`webpage/`**: A responsive Angular + Tailwind CSS dashboard simulating internal tools (Tickets, Logs, Knowledgebase).

---

## Features & Bonus Points

### Part 1: Flutter App (Messaging)

* **AI Integration**: Uses **Firebase AI (Gemini 2.5 Flash)** to simulate a smart support agent instead of hardcoded responses.
* **Context Awareness**: The bot remembers conversation history within the session.
* **Multi-modal Support**: Users can send **images** to the bot, which it can analyze and describe.
* **Local Persistence**: Messages are saved locally using **Hive**, restoring chat history on app restart.
* **Rich Text**: Renders **Markdown** responses (bold, lists, code blocks) from the AI.
* **UX Polish**: Typing indicators, auto-scroll, retry logic for failed messages, and emoji picker.

### Part 2: Angular Dashboard (Internal Tools)

* **Tech Stack**: Angular 16+ with **Tailwind CSS v4**.
* **Responsive Design**: Fully adaptive layout with a collapsible mobile drawer and desktop sidebar.
* **Dark Mode**: Toggleable dark/light theme (persisted in session).
* **Components**:
    * **Ticket Viewer**: Filterable list of support tickets.
    * **Live Logs**: "Hacker terminal" style logs that auto-update and scroll.
    * **Knowledgebase**: Markdown-ready editor interface.

---

## Prerequisites

* **Flutter SDK** (3.x or later)
* **Node.js & npm** (for Angular)
* **Angular CLI** (`npm install -g @angular/cli`)
* **Firebase Account** (Blaze plan required for Vertex AI, but it won't cost anything for now)

---

## 📦 Setup Instructions

### 1. The Angular Dashboard (`/webpage`)

The dashboard must be running locally for the Flutter WebView to access it.

1.  **Navigate** to the directory:

    ```bash
    cd webpage
    ```

2.  **Install dependencies**:

    ```bash
    npm install
    ```

3.  **Crucial Step**: Run the server ensuring it binds to all interfaces (`0.0.0.0`). This is required for the **Android Emulator** to access the host machine.

    ```bash
    ng serve --host 0.0.0.0 --port 4200
    ```

    * **Access via Browser**: `http://localhost:4200`
    * **Access via Android Emulator**: `http://10.0.2.2:4200`

### 2. The Flutter App (`/flutter_app`)

1.  **Navigate** to the directory:

    ```bash
    cd flutter_app
    ```

2.  **Install dependencies**:

    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration**:
    This project uses `firebase_ai`. You must configure it with your own Firebase project.
    * Ensure you have the **FlutterFire CLI** installed.
    * Run:
        ```bash
        flutterfire configure
        ```
    * **Note**: Ensure the **Vertex AI API** is enabled in your Firebase Console and the project is on the **Blaze plan**.

4.  **Run the App**:

    ```bash
    flutter run
    ```

---

## 📱 Networking & WebView Details

### The "Localhost" Challenge

The Flutter app includes a WebView tab that loads the Angular dashboard.

* **On Android**: `localhost` refers to the emulator itself. To reach the computer's `localhost`, we use the special IP **`10.0.2.2`**.
* **On iOS Simulator**: `localhost` correctly refers to the computer.

### Receive Thanks from Remi D.