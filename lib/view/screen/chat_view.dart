//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hasfirebase/view/widget/messages.dart';
import 'package:hasfirebase/view/widget/sending_button.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
//String imageUrl ="";

//  userInfo()async{
//    final user= FirebaseAuth.instance.currentUser;
//    final userData=await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
//
//    setState(() {
//      imageUrl= userData["imageUrl"];
//    });
//
//  }
//@override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    userInfo();
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed:(){
            FirebaseAuth.instance.signOut();
          },icon :Icon(Icons.exit_to_app)),
        ],

      ),
      body: Container(
//        decoration: BoxDecoration(
//          image:DecorationImage(
//            fit: BoxFit.cover,
//            image: imageUrl==""?null:NetworkImage(imageUrl),
//          ) ,
       // ),
        child: Column(

          children:[
           Expanded(child: Messages()),
  SendingButton(),
          ]
        ),
      ),

    );
  }
}
