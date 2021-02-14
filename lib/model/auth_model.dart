import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthModel {

  static String message = "no no";
  Future<void> auth(bool isLogin, File _image, String _name, String _email,
      String _password) async {
    UserCredential userCred;
    try {
      if (isLogin) {
        print("try auth model true");
        userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
      } else {
        print("try auth model false");
        userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        print("try auth model create");
        final ref = storage.FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child(userCred.user.uid +"jpeg");
      storage.StorageUploadTask upload =  ref.putFile(_image);
      await upload.onComplete;



        print("try auth model send image to storage ");
        final url = await ref.getDownloadURL();
        print("try auth model taking url ");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user.uid)
            .set({
          "username": _name.trim(),
          "email": _email.trim(),
          "password": _password.trim(),
          "imageUrl": url.toString(),
        });
        print("try auth model sending data");
      }
    } on FirebaseAuthException catch (e) {
              message="errors";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }else{
        message= e.code;
      }
      throw(message);
    } catch (e) {
     print(e);
    }
  }
}
