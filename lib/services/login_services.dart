import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itc_firebase/model/user_model.dart';

class LoginServices {
  static void register(UserModel user) async {
    final url = Uri.https(
        'itc-flutter-db2f9-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list.json');
    await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user': user.name, 'pass': user.pass}));
  }

  static Future<bool> loginUser(UserModel user) async {
    final url = Uri.https(
        'itc-flutter-db2f9-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    bool data = false;
    for (var item in listData.entries) {
      if (item.value['user'] == user.name && item.value['pass'] == user.pass) {
        data = true;
        break;
      }
    }
    return data;
  }

  static Future<bool> checkEmail(UserModel user) async {
    final url = Uri.https(
        'itc-flutter-db2f9-default-rtdb.asia-southeast1.firebasedatabase.app',
        'activity-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    bool data = false;
    for (var item in listData.entries) {
      if (item.value['user'] == user.name) {
        data = true;
        break;
      }
    }
    return data;
  }
}
