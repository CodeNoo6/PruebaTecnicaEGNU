import 'dart:convert';
import 'package:gestioninsedu/domain/entities/Municipality.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  static Future<String?> postLogin(String user, String password) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': user,
      'Password': password,
      'option': 'municipios'
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['login'] == 'Fail') {
          return null;
        } else {
          return "Autenticado";
        }
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
