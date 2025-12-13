import 'dart:convert';
import 'package:http/http.dart' as http;

class RestAdapterRepository {
  static const String BASE_URL = "https://fakestoreapi.com/";

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    final uri = Uri.parse(BASE_URL + endpoint).replace(queryParameters: params);

    final response = await http.get(uri);

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse(BASE_URL + endpoint);

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse(BASE_URL + endpoint);

    final response = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }


  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse(BASE_URL + endpoint);

    final response = await http.delete(uri);

    return _handleResponse(response);
  }

  /// ---------------------- Response handler ----------------------
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode} ${response.body}");
    }
  }
}
