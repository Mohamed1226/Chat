
import 'package:flutter/material.dart';
import 'package:hasfirebase/view_model/sending_message_view_model.dart';
import 'package:provider/provider.dart';
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

     await Provider.of<SendingMessageViewModel>(context,listen: false).submit(_message);
     _buttonController.clear();
  }
}
