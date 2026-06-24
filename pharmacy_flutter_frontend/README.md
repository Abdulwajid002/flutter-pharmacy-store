# 💊 Pharmacy App – Flutter Frontend

A fully functional Flutter frontend for the Pharmacy App backend. Clean architecture with JWT authentication, complete API integration, and a modern blue/white UI.

---

## 🚀 Quick Start

### 1. Copy your asset files
Copy your existing fonts and images from the original project:
```
fonts/  → Poppins-Light.ttf, Poppins-SemiBold.ttf,
           fredoka-latin-400-normal.ttf, fredoka-latin-ext-700-normal.ttf
images/ → medicine.png, boy1.jpg (or any placeholder images)
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Start the backend
```bash
cd pharmacy_backend
npm run dev
# Default port: 5000
```

### 4. Run the app
```bash
flutter run
# For Android emulator – base URL is already set to http://10.0.2.2:5000/api
```

---

## 🏗 Project Architecture

```
lib/
├── main.dart                        # App entry + SplashScreen (auto-login check)
│
├── services/
│   └── api_service.dart             # All HTTP calls + TokenStorage (SharedPreferences)
│
├── models/
│   ├── medicine.dart                # Medicine model
│   ├── order.dart                   # Order model
│   └── transaction.dart             # Wallet transaction model
│
├── widgets/
│   └── app_widgets.dart             # AppColors, AppTextField, PrimaryButton,
│                                    # AppCard, GradientHeader, showSuccess/showError
│
└── screens/
    ├── login_screen.dart            # Login with role routing
    ├── signup_screen.dart           # Register new user
    ├── main_nav.dart                # Bottom nav shell (4 tabs)
    ├── home_screen.dart             # Medicines grid with search & categories
    ├── medicine_detail_screen.dart  # Product detail + qty selector
    ├── order_screen.dart            # Order review before checkout
    ├── checkout_screen.dart         # Place order via API
    ├── my_orders_screen.dart        # User order history
    ├── wallet_screen.dart           # Balance + transactions + add money
    ├── profile_screen.dart          # User profile + logout + delete account
    └── admin/
        ├── admin_login_screen.dart  # Standalone admin login
        ├── admin_panel.dart         # Dashboard with stats + quick actions
        ├── add_product_screen.dart  # Add / Edit medicine (dual mode)
        ├── admin_medicines_screen.dart # List + edit + delete medicines
        ├── admin_orders_screen.dart    # View all orders
        └── admin_users_screen.dart    # View all registered users
```

---

## 🔐 Authentication Flow

```
App Launch
    └── SplashScreen
         ├── No token  ──────────────────→ LoginScreen
         ├── token + role==user  ────────→ MainNav (4-tab bottom nav)
         └── token + role==admin ────────→ AdminPanel
```

Login uses `POST /auth/login`. The response `user.role` determines routing:
- `"user"` → MainNav
- `"admin"` → AdminPanel

Token is stored in **SharedPreferences** via `TokenStorage`.

---

## 📱 Screens

| Screen | Route | Notes |
|--------|-------|-------|
| Login | `/` | Role-based routing |
| Signup | Push from Login | POST /auth/register |
| Home | Tab 0 | Medicines grid, search, categories |
| My Orders | Tab 1 | GET /orders/my |
| Wallet | Tab 2 | Balance + transactions, Add money |
| Profile | Tab 3 | User info, logout, delete account |
| Medicine Detail | Push from Home | Qty selector, Order Now |
| Order Review | Push from Detail | Qty adjuster + price breakdown |
| Checkout | Push from Order | Places order, deducts wallet |
| Admin Panel | After admin login | Dashboard with stats |
| Add Product | Push from Admin | POST /admin/medicines |
| Edit Product | Push from Manage | PUT /admin/medicines/:id |
| Manage Medicines | Push from Admin | List + edit + delete |
| All Orders | Push from Admin | GET /admin/orders |
| All Users | Push from Admin | GET /admin/users |

---

## 🎨 UI Theme

| Token | Value |
|-------|-------|
| Primary | `#1E3A8A` (deep blue) |
| Accent | `#3B82F6` (sky blue) |
| Success | `#10B981` |
| Error | `#EF4444` |
| Background | `#F8FAFF` |
| Card | White + subtle shadow |

---

## 🔑 Default Admin Credentials

```
Email:    admin@pharmacy.com
Password: admin123
```

The Login screen has a **"Login as Admin"** button that pre-fills these credentials.

---

## 📦 Dependencies

```yaml
curved_navigation_bar: ^1.0.6   # Animated bottom nav
http:                  ^1.2.1   # HTTP client
shared_preferences:    ^2.2.2   # Token persistence
```

---

## ⚙️ API Base URL

Change in `lib/services/api_service.dart`:

```dart
const String kBaseUrl = 'http://10.0.2.2:5000/api'; // Android emulator
// const String kBaseUrl = 'http://localhost:5000/api'; // iOS simulator
// const String kBaseUrl = 'http://YOUR_IP:5000/api';   // Physical device
```

---

## 🐛 Troubleshooting

| Issue | Fix |
|-------|-----|
| Connection refused | Ensure backend is running on port 5000 |
| 401 Unauthorized | Token expired – logout and re-login |
| Insufficient balance | Add money to wallet before ordering |
| Image not showing | Ensure `images/` folder has `medicine.png` |
| Fonts missing | Copy `fonts/` folder from original project |
