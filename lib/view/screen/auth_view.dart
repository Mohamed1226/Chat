import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hasfirebase/view/screen/chat_view.dart';
import 'package:hasfirebase/view/widget/custom_text_form_field.dart';
import 'package:hasfirebase/view/widget/user_image_picker.dart';
import 'package:hasfirebase/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  String _name = "", _email = "", _password = "";
  bool isLogin = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : Center(
              child: Card(
                margin: EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!isLogin) UserImagePicker(),
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
                        Builder(
                          builder:(cont)=> RaisedButton(
                            onPressed: () => submit(cont),
                            child: Text(isLogin ? "Log In" : "Sign Up"),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(isLogin ? "Sign Up" : "LogIn"),
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
    FocusScope.of(cxt).unfocus();
    if (!isLogin && Provider.of<AuthModelView>(cxt,listen: false).image == null) {
      Toast.show("please choose a photo", cxt, duration: 4);
      return;
    }

    if (isValidate) {
      setState(() {
        _isLoading=true;
      });
      _formKey.currentState.save();
      try
      {
        print("try view ");

        await Provider.of<AuthModelView>(cxt,listen: false).auth(isLogin, _name, _email, _password).then((v){

          Navigator.of(cxt)
              .push(MaterialPageRoute(builder: (cxt) => ChattingView()));
        });
        setState(() {
          _isLoading=false;
        });
      }catch(e){
        Toast.show(e.toString(), context);
        setState(() {
          _isLoading=false;
        });
      }
      setState(() {
        _isLoading=false;
      });
    }
  }
}
