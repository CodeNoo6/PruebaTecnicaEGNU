import 'dart:convert';
import 'package:gestioninsedu/domain/entities/Municipality.dart';
import 'package:gestioninsedu/domain/utilities/Utilities.dart';
import 'package:http/http.dart' as http;

import '../entities/Campus.dart';
import '../entities/Institution.dart';

class CampusRepository {
  static Future<List<Campus>?> postCampus(String CodInst) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': await Utilities.getLocalUser(),
      'Password': await Utilities.getLocalPassword(),
      'option': 'sedes',
      'CodInst': CodInst
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
          final data = jsonResponse['data'];
          List<Campus> sedes = List<Campus>.from(data.map((x) => Campus.fromJson(x)));
          return sedes;
        }
      } else {
        print('Error en la petición: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
