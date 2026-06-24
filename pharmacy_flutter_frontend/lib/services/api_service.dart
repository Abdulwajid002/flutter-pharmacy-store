import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ── Base URL ────────────────────────────────────────────────────────────────
// const String kBaseUrl = 'http://10.0.2.2:5000/api';
const String kBaseUrl = 'http://localhost:5000/api';
// ── Token helpers ────────────────────────────────────────────────────────────
class TokenStorage {
  static const _tokenKey = 'jwt_token';
  static const _roleKey  = 'user_role';
  static const _nameKey  = 'user_name';
  static const _emailKey = 'user_email';
  static const _idKey    = 'user_id';

  static Future<void> save({
    required String token,
    required String role,
    required String name,
    required String email,
    required int id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_roleKey, role);
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setInt(_idKey, id);
  }

  static Future<String?> getToken()  async => (await SharedPreferences.getInstance()).getString(_tokenKey);
  static Future<String?> getRole()   async => (await SharedPreferences.getInstance()).getString(_roleKey);
  static Future<String?> getName()   async => (await SharedPreferences.getInstance()).getString(_nameKey);
  static Future<String?> getEmail()  async => (await SharedPreferences.getInstance()).getString(_emailKey);
  static Future<int?>    getId()     async => (await SharedPreferences.getInstance()).getInt(_idKey);

  static Future<void> clear() async => (await SharedPreferences.getInstance()).clear();
}

// ── ApiService ───────────────────────────────────────────────────────────────
class ApiService {
  // ── Auth headers ──────────────────────────────────────────────────────────
  static Future<Map<String, String>> _authHeaders() async {
    final token = await TokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Map<String, String> _jsonHeaders() => {'Content-Type': 'application/json'};

  // ── Response parser ───────────────────────────────────────────────────────
  static dynamic _parse(http.Response res) {
    final body = jsonDecode(res.body);
    if (res.statusCode >= 200 && res.statusCode < 300) return body;
    final msg = body['error'] ?? body['message'] ?? 'Request failed (${res.statusCode})';
    throw ApiException(msg, res.statusCode);
  }

  // ─────────────────────────────── AUTH ─────────────────────────────────────
  /// POST /auth/login → { token, user }
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/auth/login'),
      headers: _jsonHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// POST /auth/register → { message }
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/auth/register'),
      headers: _jsonHeaders(),
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ─────────────────────────── MEDICINES ────────────────────────────────────
  /// GET /medicines → List<medicine>
  static Future<List<dynamic>> getMedicines() async {
    final res = await http.get(Uri.parse('$kBaseUrl/medicines'));
    return _parse(res) as List<dynamic>;
  }

  // ─────────────────────────────── ORDERS ───────────────────────────────────
  /// POST /orders → place order (deducts wallet)
  static Future<Map<String, dynamic>> placeOrder({
    required String medicineName,
    required int quantity,
    required double total,
  }) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/orders'),
      headers: await _authHeaders(),
      body: jsonEncode({
        'medicine_name': medicineName,
        'quantity': quantity,
        'total': total,
      }),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// GET /orders/my → List<order>
  static Future<List<dynamic>> getMyOrders() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/orders/my'),
      headers: await _authHeaders(),
    );
    return _parse(res) as List<dynamic>;
  }

  // ─────────────────────────────── WALLET ───────────────────────────────────
  /// GET /wallet → { balance, transactions }
  static Future<Map<String, dynamic>> getWallet() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/wallet'),
      headers: await _authHeaders(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// POST /wallet/add → { newBalance }
  static Future<Map<String, dynamic>> addMoney(double amount) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/wallet/add'),
      headers: await _authHeaders(),
      body: jsonEncode({'amount': amount}),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  // ─────────────────────────────── PROFILE ──────────────────────────────────
  /// GET /profile → user object
  static Future<Map<String, dynamic>> getProfile() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/profile'),
      headers: await _authHeaders(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// DELETE /profile → soft-delete account
  static Future<void> deleteAccount() async {
    final res = await http.delete(
      Uri.parse('$kBaseUrl/profile'),
      headers: await _authHeaders(),
    );
    _parse(res);
  }

  // ─────────────────────────── ADMIN ────────────────────────────────────────
  /// GET /admin/dashboard
  static Future<Map<String, dynamic>> getAdminDashboard() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/admin/dashboard'),
      headers: await _authHeaders(),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// POST /admin/medicines → add product
  static Future<Map<String, dynamic>> adminAddMedicine(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$kBaseUrl/admin/medicines'),
      headers: await _authHeaders(),
      body: jsonEncode(data),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// PUT /admin/medicines/:id
  static Future<Map<String, dynamic>> adminUpdateMedicine(int id, Map<String, dynamic> data) async {
    final res = await http.put(
      Uri.parse('$kBaseUrl/admin/medicines/$id'),
      headers: await _authHeaders(),
      body: jsonEncode(data),
    );
    return _parse(res) as Map<String, dynamic>;
  }

  /// DELETE /admin/medicines/:id
  static Future<void> adminDeleteMedicine(int id) async {
    final res = await http.delete(
      Uri.parse('$kBaseUrl/admin/medicines/$id'),
      headers: await _authHeaders(),
    );
    _parse(res);
  }

  /// GET /admin/users
  static Future<List<dynamic>> adminGetUsers() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/admin/users'),
      headers: await _authHeaders(),
    );
    return _parse(res) as List<dynamic>;
  }

  /// GET /admin/orders
  static Future<List<dynamic>> adminGetOrders() async {
    final res = await http.get(
      Uri.parse('$kBaseUrl/admin/orders'),
      headers: await _authHeaders(),
    );
    return _parse(res) as List<dynamic>;
  }
}

// ── Custom exception ──────────────────────────────────────────────────────────
class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}
