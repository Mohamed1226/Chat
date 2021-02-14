import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hasfirebase/view/widget/messages.dart';
import 'package:hasfirebase/view/widget/sending_button.dart';

class ChattingView extends StatelessWidget {



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
