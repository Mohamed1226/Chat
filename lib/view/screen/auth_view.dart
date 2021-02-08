import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:hasfirebase/view/screen/chat_view.dart';
import 'package:hasfirebase/view/widget/custom_text_form_field.dart';
import 'package:hasfirebase/view/widget/user_image_picker.dart';
//import 'package:hasfirebase/view_model/auth_view_model.dart';
//import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  String _name = "", _email = "", _password = "";
  bool isLogin = true;
  bool isLoading=false;

  File _image;
   void pickedFn(File image){
     _image=image;
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body:isLoading?Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),): Center(
        child: Card(
          margin: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (!isLogin) UserImagePicker(pickedFn),
                  CustomTextFormField(
                    isObscure: false,
                    valueKey: "email",
                    textType: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "please input your email",
                    onSaved: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    validate: (val) {
                      if (val.isEmpty || !val.contains("@")) {
                        return "please input an correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  if (!isLogin)
                    CustomTextFormField(
                      isObscure: false,
                      valueKey: "name",
                      textType: TextInputType.name,
                      labelText: "Name",
                      hintText: "please input your name",
                      onSaved: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                      validate: (val) {
                        if (val.isEmpty || val.length < 4) {
                          return "please input an correct name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  CustomTextFormField(
                    isObscure: true,
                    valueKey: "password",
                    textType: TextInputType.number,
                    labelText: "Password",
                    hintText: "please input your password",
                    onSaved: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    validate: (val) {
                      if (val.isEmpty || val.length < 6) {
                        return "please input an strong password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  RaisedButton(
                    onPressed:()=> submit(context),
                    child: Text(isLogin ? "Log In" : "Sign Up"),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Sign Up"
                        : "LogIn"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit(BuildContext cxt) async {
    final isValidate = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(!isLogin&&_image==null){
      Toast.show("please choose a photo", cxt,duration: 4);
      return;
    }

    if (isValidate) {
      _formKey.currentState.save();

      UserCredential userCred;
      try {
        setState(() {
          isLoading =true;
        });
        if (isLogin) {
          userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.trim(),
            password: _password.trim(),
          );
        } else {
          userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.trim(),
            password: _password.trim(),
          );
         final ref =  storage.FirebaseStorage.instance.ref().child("user_image").child(userCred.user.uid+ ".jpg");
         await ref.putFile(_image);
         final url =await ref.getDownloadURL();
         
         
       await   FirebaseFirestore.instance.collection("users").doc(userCred.user.uid).set({
            "username":_name.trim(),
            "email": _email.trim(),
            "password": _password.trim(),
            "imageUrl":url.toString(),
          });
        }
        Navigator.pushReplacement(cxt, MaterialPageRoute(builder: (cxt)=> HomeView()));
      } on FirebaseAuthException catch (e) {
        String message="no no";
        if (e.code == 'weak-password') {
          message='The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message='The account already exists for that email.';
        }else if (e.code == 'user-not-found') {
    message='No user found for that email.';
        } else if (e.code == 'wrong-password') {
    message='Wrong password provided for that user.';
        }
        setState(() {
          isLoading =false;
        });
Toast.show(message, cxt,duration: 4);


   } catch (e) {
        print(e);
        setState(() {
          isLoading =false;
        });
      }
    }
  }
}
