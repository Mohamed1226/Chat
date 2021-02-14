

import 'package:flutter/material.dart';
import 'package:hasfirebase/model/sending_message_model.dart';

class SendingMessageViewModel extends ChangeNotifier{


  SendingMessageModel _sendingMessageModel=SendingMessageModel();
  submit(String message)async{

 try{
  await _sendingMessageModel.submit(message);
 }catch(e){
   print(e);
 }

  }

}