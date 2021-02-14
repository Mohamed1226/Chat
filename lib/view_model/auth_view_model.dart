import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hasfirebase/model/auth_model.dart';

import 'package:image_picker/image_picker.dart';

class AuthModelView with ChangeNotifier {
  AuthModel _authModel = AuthModel();
String _message ="";



  Future<void> auth( bool isLogin, String _name, String _email, String _password) async {
    try{

  await _authModel.auth(isLogin, image, _name, _email, _password);
  print("try auth view  model");
  }catch(e){
      throw(e.toString());

  }
  }

  File get image => _image;

  File _image;
  final ImagePicker picker = ImagePicker();

  void getImage(ImageSource src) async {
    // PermissionStatus permissionResult =
    //   await SimplePermissions.requestPermission(
    //     Permission.WriteExternalStorage);
    // if (permissionResult == PermissionStatus.authorized) {
    // code of read or write file in external storage (SD card)
    final pickedFile = await picker.getImage(
        source: src, imageQuality: 50, maxWidth: 150, maxHeight: 150);
    if (pickedFile != null) {
      _image = File(pickedFile.path);

      notifyListeners();
    } else {
      print('No image selected.');
    }
    // } else {
    // Toast.show(
    //   src == ImageSource.gallery
    //     ? "please give permission for gallery"
    //   : "please give permission for camera",
    //cxt,
    // duration: 4);
    //}
  }

//  String _token, _id;
//  DateTime _expire;
//
//  bool get isAuth {
//    return token != null;
//  }
//
//  String get token {
//    if (_token != null && _expire.isAfter(DateTime.now()) && _expire != null) {
//      return _token;
//    } else {
//      return null;
//    }
//  }
//
//  Future<void> _authenticate(
//      String email, String password, String urlSegment) async {
//    final url =
//        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCa7PpIPcGDoGCw5AyzrafnPYlUqpiTBUA";
//    try {
//      final res = await http.post(url,
//          body: json.encode({
//            "email": email,
//            "password": password,
//            "returnSecureToken": true
//          }));
//
//      final resData = json.decode(res.body);
//      if (resData["error"] != null) {
//        throw "${resData["error"]["message"]}";
//      }
//      _token = resData["idToken"];
//      _id = resData["localId"];
//      _expire = DateTime.now().add(Duration(seconds: int.parse(resData["expiresIn"])));
//    notifyListeners();
//    } catch (e) {
//      throw e;
//    }
//  }
//
//  Future<void> signUp(String email, String password) async {
//    return _authenticate(email, password, "signUp");
//  }
//
//  Future<void> logIn(String email, String password) async {
//    return _authenticate(email, password, "signInWithPassword");
//  }
}
