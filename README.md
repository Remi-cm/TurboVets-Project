# Flutter Chat & Internal Tools Dashboard

This repository contains the submission for the **"Messaging App with Embedded Internal Tools Dashboard"** assessment. It consists of two distinct applications that work together:

<div align="center>
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FChatDark.png?alt=media&token=e1b74d37-2be5-4b67-829c-00140a3b25fe" width="180" />
   <video src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FTurboVetsRecording.webm?alt=media&token=1e0c85bc-379e-48bc-90d8-d9a874dcdc0e" ></video>
   
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FChatDark.png?alt=media&token=e1b74d37-2be5-4b67-829c-00140a3b25fe" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FDashboardDark.png?alt=media&token=794c9060-d571-46b9-a875-9ae2ecff8fd8" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FEmojiKeyboard.png?alt=media&token=77e203aa-ecfc-4149-a9fb-6995642d64a2" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FHomeScreenDark.png?alt=media&token=e7382c56-8fe9-4278-b12f-768fff2d1f07" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FDashboardLight.png?alt=media&token=fec0a5a6-c2b7-412c-9628-b1e0c380bd8c" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FDashboardDrawerDark.png?alt=media&token=a7ec768a-1cb2-43e2-8cc2-5601c213ef74" width="180" />
   <img src="https://firebasestorage.googleapis.com/v0/b/g4all-db.appspot.com/o/Samples%2FHomeScreenLight.png?alt=media&token=8e54ebd9-3ec3-409d-a9c4-825820e60e61" width="180" />
   
</div>



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

## Setup Instructions

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

### You can also directly install the apk
The chat bot will be easier to test: https://drive.google.com/file/d/1tr7OibucxEF4NckPakPECJcasaIqw9wS/view?usp=sharing

---

### Whatever the outcome, I really enjoyed doing this.
