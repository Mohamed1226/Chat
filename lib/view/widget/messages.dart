import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'mesage_bubble.dart';
class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("chat").orderBy(
          "currentDate", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var docs = snapshot.data.docs;
        final user = FirebaseAuth.instance.currentUser;


        return ListView.builder(
          reverse: true,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) {
            return
              MessageBubble(
                userImage: docs[index]["userImage"],
                key: ValueKey("docs[index]"),
                message: docs[index]["text"],
                isMe: user.uid == docs[index]["userId"],
                userName: docs[index]["userName"],

              );
          },
          itemCount: docs.length,
        );
      },
    );
  }

}