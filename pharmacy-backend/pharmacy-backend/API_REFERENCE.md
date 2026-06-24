# Pharmacy App — API Reference & Flutter Integration Guide

Base URL: `http://YOUR_IP:5000/api`
For Android emulator use `http://10.0.2.2:3000/api`
For iOS simulator use `http://localhost:5000/api`

---

## Authentication

All protected routes require this header:
```
Authorization: Bearer <token>
```
Store the token from login in `SharedPreferences` or `flutter_secure_storage`.

---

## Endpoints

### Auth (`/api/auth`)

| Method | Endpoint            | Body                              | Auth | Description           |
|--------|---------------------|-----------------------------------|------|-----------------------|
| POST   | `/auth/register`    | `{name, email, password}`         | No   | Register new user     |
| POST   | `/auth/login`       | `{email, password}`               | No   | Login user **or** admin |

**Login response:**
```json
{
  "message": "Login Successful",
  "token": "eyJ...",
  "user": { "id": 1, "name": "...", "email": "...", "role": "user" }
}
```
Check `user.role` — if `"admin"`, navigate to Admin Panel.

---

### Admin Panel (`/api/admin`) — Admin JWT required

| Method | Endpoint                        | Body / Params                    | Description              |
|--------|---------------------------------|----------------------------------|--------------------------|
| GET    | `/admin/dashboard`              | —                                | Stats: users, orders...  |
| GET    | `/admin/medicines`              | —                                | All medicines            |
| POST   | `/admin/medicines`              | `{name,price,category,desc,...}` | **Add Product** screen   |
| PUT    | `/admin/medicines/:id`          | same fields                      | Edit medicine            |
| DELETE | `/admin/medicines/:id`          | —                                | Remove medicine          |
| GET    | `/admin/users`                  | —                                | All registered users     |
| GET    | `/admin/orders`                 | —                                | All orders               |
| PATCH  | `/admin/orders/:id/status`      | `{status: "confirmed"}`          | Update order status      |

---

### Medicines (`/api/medicines`) — Public

| Method | Endpoint       | Description              |
|--------|----------------|--------------------------|
| GET    | `/medicines`   | Get all active medicines |

---

### Orders (`/api/orders`) — User JWT required

| Method | Endpoint       | Body                                      | Description         |
|--------|----------------|-------------------------------------------|---------------------|
| POST   | `/orders`      | `{medicine_name, quantity, total}`        | Place order (deducts wallet) |
| GET    | `/orders/my`   | —                                         | Get my orders       |

---

### Wallet (`/api/wallet`) — User JWT required

| Method | Endpoint        | Body            | Description          |
|--------|-----------------|-----------------|----------------------|
| GET    | `/wallet`       | —               | Balance + transactions |
| POST   | `/wallet/add`   | `{amount: 100}` | **Add Money** button |

---

### Profile (`/api/profile`) — User JWT required

| Method | Endpoint    | Description                       |
|--------|-------------|-----------------------------------|
| GET    | `/profile`  | Get logged-in user profile        |
| DELETE | `/profile`  | **Delete Account** button         |

---

## Flutter Code Examples

### 1. Add Money (Wallet page)

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> addMoney(String token, double amount) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/wallet/add'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({'amount': amount}),
  );

  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    // data['newBalance'] — update your UI
    print('New balance: \$${data['newBalance']}');
  } else {
    throw Exception(data['error']);
  }
}
```

### 2. Get Wallet Balance (on page load)

```dart
Future<Map> getWallet(String token) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/api/wallet'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return jsonDecode(response.body);
  // returns { balance: 250.75, transactions: [...] }
}
```

### 3. Delete Account (Profile page)

```dart
Future<void> deleteAccount(String token) async {
  final response = await http.delete(
    Uri.parse('http://10.0.2.2:3000/api/profile'),
    headers: {'Authorization': 'Bearer $token'},
  );

  final data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    // Clear token and navigate to login
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (_) => const Login()), (_) => false);
  } else {
    throw Exception(data['error']);
  }
}
```

### 4. Admin — Add Product

```dart
Future<void> addProduct(String adminToken, Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/admin/medicines'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $adminToken',
    },
    body: jsonEncode(product),
    // product = {name, price, category, description, stock}
  );
  final data = jsonDecode(response.body);
  print(data['message']);
}
```

---

## Setup Instructions

1. **Import database schema:**
   ```bash
   mysql -u root -p < database.sql
   ```

2. **Create `.env` file** (copy from `.env.example`):
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=pharmacy_app
   JWT_SECRET=change_this_to_a_long_random_string
   PORT=3000
   ```

3. **Install dependencies & run:**
   ```bash
   npm install
   npm run dev
   ```

4. **Default Admin Login:**
   - Email: `admin@pharmacy.com`
   - Password: `admin123`
   *(Change this immediately in production!)*

---

## Notes

- **Soft delete**: Deleted users are anonymised (email/name wiped) but kept for order history integrity.
- **Wallet deduction**: Placing an order automatically deducts from wallet. Insufficient balance returns 400.
- **Admin vs User login**: Use the same `/api/auth/login` endpoint. Check `user.role` in response to route to correct screen.
