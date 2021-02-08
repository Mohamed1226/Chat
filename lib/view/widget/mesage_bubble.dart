
import "package:flutter/material.dart";
class MessageBubble extends StatelessWidget {
 final String message,userImage;
 final bool isMe;
 final String userName;
 final Key key;

 MessageBubble({this.userImage,this.message, this.isMe, this.userName, this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [

        Row(
          mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              margin: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: isMe?Colors.deepPurpleAccent.withOpacity(0.6):Colors.grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft:  Radius.circular(14),
                  bottomRight: isMe?Radius.circular(0):Radius.circular(14),
                  bottomLeft: isMe?Radius.circular(14):Radius.circular(0),
                ),
              ),

              child: Column(

                crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(userName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                  Text(message,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: isMe? 180:null,
          right: isMe? null:180,
          child: CircleAvatar(

            backgroundImage: NetworkImage(userImage),
          ),),
      ],
    );
  }
}
