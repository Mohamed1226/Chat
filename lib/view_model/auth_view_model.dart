import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthModelView with ChangeNotifier {
  String _token, _id;
  DateTime _expire;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null && _expire.isAfter(DateTime.now()) && _expire != null) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCa7PpIPcGDoGCw5AyzrafnPYlUqpiTBUA";
    try {
      final res = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      final resData = json.decode(res.body);
      if (resData["error"] != null) {
        throw "${resData["error"]["message"]}";
      }
      _token = resData["idToken"];
      _id = resData["localId"];
      _expire = DateTime.now().add(Duration(seconds: int.parse(resData["expiresIn"])));
    notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
