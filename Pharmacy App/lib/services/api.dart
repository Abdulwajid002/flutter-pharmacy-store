// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   static const baseUrl = "http://10.0.2.2:5000/api";
//
//   // GET MEDICINES
//   static Future<List> getMedicines() async {
//     final res = await http.get(Uri.parse("$baseUrl/medicines"));
//     return jsonDecode(res.body);
//   }
//
//   // REGISTER
//   static Future register(data) async {
//     final res = await http.post(
//       Uri.parse("$baseUrl/auth/register"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(data),
//     );
//     return jsonDecode(res.body);
//   }
//
//   // LOGIN
//   static Future login(data) async {
//     final res = await http.post(
//       Uri.parse("$baseUrl/auth/login"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(data),
//     );
//     return jsonDecode(res.body);
//   }
//
//   // PLACE ORDER
//   static Future placeOrder(data) async {
//     final res = await http.post(
//       Uri.parse("$baseUrl/orders/place"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(data),
//     );
//     return jsonDecode(res.body);
//   }
// }

// Grock
import 'package:http/http.dart' as http;
import 'dart:convert';

// const String baseUrl = "http://10.0.2.2:5000/api"; // Android Emulator
const String baseUrl = "http://localhost:5000/api";

class ApiService {
  static Future<List<dynamic>> getMedicines() async {
    final response = await http.get(Uri.parse('$baseUrl/medicines'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load medicines');
    }
  }

  static Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders/place'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderData),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to place order');
    }
  }
}