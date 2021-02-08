
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SendingButton extends StatefulWidget {
  @override
  _SendingButtonState createState() => _SendingButtonState();
}

class _SendingButtonState extends State<SendingButton> {
  TextEditingController _buttonController =TextEditingController();

  String _message="";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      child:  Row(
        children: [
         Expanded(child:  TextField(

           decoration: InputDecoration(

               labelText: "your message"
           ),
           controller:_buttonController ,
           onChanged: (val){
             setState(() {
               _message =val;
             });
           },
         ),),
          IconButton(
            icon: Icon(Icons.send),
               color: Theme.of(context).primaryColor,
               onPressed:_message.trim().isEmpty?null: submit,
          ),
        ],
      ),
    );
  }
  submit()async{
    FocusScope.of(context).unfocus();
    final user= FirebaseAuth.instance.currentUser;
    final userData=await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    FirebaseFirestore.instance.collection("chat").add({
      "text": _message,
      "currentDate": Timestamp.now(),
      "userId": user.uid,
      "userName":userData["username"],
      "userImage":userData["imageUrl"],
    });
    _buttonController.clear();
  }
}
