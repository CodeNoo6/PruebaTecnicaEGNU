import 'dart:convert';
import 'package:gestioninsedu/domain/entities/Municipality.dart';
import 'package:http/http.dart' as http;

import '../utilities/Utilities.dart';

class MunicipalityRepository {
  static Future<List<Municipality>?> postMunicipalities(String user, String password) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': await Utilities.getLocalUser(),
      'Password': await Utilities.getLocalPassword(),
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
          final data = jsonResponse['data'];
          List<Municipality> municipios = List<Municipality>.from(data.map((x) => Municipality.fromJson(x)));
          return municipios;
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
