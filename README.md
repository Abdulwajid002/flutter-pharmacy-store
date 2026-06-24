# 💊 Pharmacy Store Management System

A complete Pharmacy Store Management System developed using Flutter and Backend APIs. This application provides a seamless experience for customers to browse medicines, manage their wallet, place orders, and perform secure payments. It also includes an Admin Panel for managing medicines, users, and revenue analytics.

---

## 📌 Project Overview

The Pharmacy Store Management System is designed to simplify the process of purchasing medicines online. Users can register, log in, browse available medicines, add products to their cart, manage wallet balance, and complete purchases securely.

Administrators can manage medicines, monitor users, and track overall business revenue through the admin dashboard.

---

# 🚀 Features

## 👤 User Features

### Authentication

* User Registration (Sign Up)
* User Login
* Secure Authentication
* Logout Functionality
* Account Deletion

### Medicine Management

* View Available Medicines
* Search Medicines
* View Medicine Details
* Medicine Categorization

### Shopping Cart

* Add Medicines to Cart
* Remove Medicines from Cart
* Update Quantity
* View Cart Summary

### Wallet System

* In-App Wallet
* Add Balance to Wallet
* Check Current Balance
* Wallet Transaction Validation

### Payment System

* Purchase Medicines Using Wallet Balance
* Insufficient Balance Validation
* Secure Checkout Process
* Order Confirmation

### User Account Management

* View Profile
* Update Profile Information
* Delete Account
* View Order History

---

## 🛠️ Admin Features

### Admin Authentication

* Admin Login
* Secure Access Control

### Medicine Management

* Add New Medicines
* Update Medicine Information
* Delete Medicines
* Manage Stock Availability

### User Management

* View Registered Users
* Monitor User Activities
* Manage User Records

### Revenue Dashboard

* View Total Revenue
* Track Sales Performance
* Monitor Orders
* Business Analytics

---

# 🔄 System Workflow

## User Workflow

1. User Sign Up
2. User Login
3. Browse Available Medicines
4. Select Required Medicines
5. Add Medicines to Cart
6. Review Cart
7. Check Wallet Balance
8. Proceed to Payment
9. Payment Validation
10. Order Confirmation
11. Logout (Optional)
12. Delete Account (Optional)

---

## Admin Workflow

1. Admin Login
2. Access Dashboard
3. Manage Medicines
4. View User Details
5. Monitor Orders
6. Track Revenue
7. Update Inventory
8. Logout

---

# 🏗️ System Architecture

Frontend:

* Flutter

Backend:

* REST APIs
* Node.js / Express (Backend)

Database:

* MYSQL

Authentication:

* JWT Authentication



---

# 📂 Project Structure

```text
pharmacy_flutter_project
│
├── pharmacy_flutter_frontend
│   ├── lib
│   ├── assets
│   ├── screens
│   ├── models
│   ├── services
│   └── widgets
│
└── pharmacy-backend
    ├── controllers
    ├── models
    ├── routes
    ├── middleware
    ├── services
    ├── config
    └── server.js
```

---

# 🔐 Security Features

* JWT Authentication
* Protected Routes
* Role-Based Access Control
* Secure Password Handling
* Input Validation

---

# 📊 Admin Dashboard Analytics

The Admin Dashboard provides:

* Total Revenue
* Total Orders
* Total Users
* Total Medicines
* Inventory Monitoring
* Sales Tracking

---

# 💰 Wallet-Based Payment System

The application uses an internal wallet mechanism.

### Payment Rules

* Users must have sufficient wallet balance.
* Payment is only successful if the wallet contains enough funds.
* Insufficient balance prevents order placement.
* Wallet balance is updated automatically after successful payment.

---

# 🎯 Future Enhancements

* Online Payment Gateway Integration
* Order Tracking System
* Medicine Recommendations
* Push Notifications
* Prescription Upload Feature
* Multi-Vendor Support
* AI-Based Medicine Suggestions

---

# 👨‍💻 Developed By

**Abdul Wajid**

Software Engineering Student

SZABIST University

---

# 📜 License

This project is developed for educational and learning purposes.

© 2026 Abdul Wajid. All Rights Reserved.
