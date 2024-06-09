import 'dart:convert';
import 'package:gestioninsedu/domain/utilities/Utilities.dart';
import 'package:http/http.dart' as http;
import '../entities/Institution.dart';

class InstitutionsRepository {
  static Future<List<Institution>?> postInstitutions(String codMun) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': await Utilities.getLocalUser(),
      'Password': await Utilities.getLocalPassword(),
      'User': 'etraining',
      'Password': 'explorandoando2020%',
      'option': 'instituciones',
      'CodMun': codMun
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
          List<Institution> instituciones = List<Institution>.from(data.map((x) => Institution.fromJson(x)));
          return instituciones;
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
