# 🏥 Flutter Pharmacy Store

## 📌 Project Title

Flutter Pharmacy Store (Mobile App + Backend API)

---

## 📖 Description

This is a full-stack Pharmacy Management System built using Flutter for the frontend and Node.js (Express) with MySQL for the backend.

The application allows users to browse medicines, place orders, and manage authentication securely. The backend provides REST APIs for handling users, medicines, and orders.

This project demonstrates real-world mobile app development with backend integration and database management.

---

## ✨ Features

### 👤 User Features

* User Registration & Login (JWT Authentication)
* Browse Medicines List
* View Medicine Details
* Place Orders
* View Order History
* Secure API communication

### 🛠️ Admin/Backend Features

* RESTful API using Express.js
* MySQL Database integration
* Password encryption using bcrypt
* JWT token authentication
* Order management system
* Medicine management API

---

## 🧰 Technologies Used

### 📱 Frontend

* Flutter (Dart)
* Provider / State Management
* HTTP Package

### 🖥️ Backend

* Node.js
* Express.js
* MySQL
* bcryptjs
* jsonwebtoken
* dotenv

### 🗄️ Database

* MySQL

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Abdulwajid002/flutter-pharmacy-store.git
```

---

### 2️⃣ Setup Flutter Frontend

```bash
cd flutter-pharmacy-store
flutter pub get
flutter run
```

---

### 3️⃣ Setup Backend

```bash
cd pharmacy_backend
npm install
```

---

### 4️⃣ Configure Environment Variables

Create a `.env` file in backend folder:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=root
DB_NAME=pharmacy_app
JWT_SECRET=your_secret_key
```

---

### 5️⃣ Run Backend Server

```bash
node server.js
```

or

```bash
nodemon server.js
```

---

## 📂 Project Structure

```text
flutter-pharmacy-store/
│
├── lib/ (Flutter App)
│   ├── pages/
│   ├── services/
│   ├── admin/
│   └── main.dart
│
├── pharmacy_backend/
│   ├── controllers/
│   ├── routes/
│   ├── services/
│   ├── config/
│   └── server.js
│
└── README.md
```

---

## 🚀 Future Improvements

* Admin Dashboard (Web Panel)
* Payment Gateway Integration
* Inventory Management System
* AI-based medicine recommendation
* Push Notifications

---

## 👨‍💻 Author

Abdul Wajid
Software Engineering Student
SZABIST
