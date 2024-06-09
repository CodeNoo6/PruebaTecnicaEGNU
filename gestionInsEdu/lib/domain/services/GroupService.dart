import 'dart:convert';
import 'package:gestioninsedu/domain/entities/Group.dart';
import 'package:gestioninsedu/domain/responseObjects/InfoGroupResponse.dart';
import 'package:gestioninsedu/domain/utilities/Utilities.dart';
import 'package:http/http.dart' as http;
class GroupRepository {
  static Future<List<Group>?> postGroups(String CodSede) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': await Utilities.getLocalUser(),
      'Password': await Utilities.getLocalPassword(),
      'User': 'etraining',
      'Password': 'explorandoando2020%',
      'option': 'grupos',
      'CodSede': CodSede
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
          List<Group> grupos = List<Group>.from(data.map((x) => Group.fromJson(x)));
          return grupos;
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

  static Future<InfoGroupResponse?> getGroupById(String idGroup) async {
    final url = 'https://www.php.engenius.com.co/DatabaseIE.php';
    final data = jsonEncode({
      'User': await Utilities.getLocalUser(),
      'Password': await Utilities.getLocalPassword(),
      'User': 'etraining',
      'Password': 'explorandoando2020%',
      'option': 'infoGrupo',
      'IdGrupo': idGroup
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
          final dataList = jsonResponse['data'];
          if (dataList != null && dataList is List && dataList.isNotEmpty) {
            return InfoGroupResponse.fromJson(dataList[0]);
          } else {
            return null;
          }
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
