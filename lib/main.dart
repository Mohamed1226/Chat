import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hasfirebase/view/screen/auth_view.dart';
//import 'package:hasfirebase/view_model/auth_view_model.dart';
//import 'package:provider/provider.dart';
import 'package:hasfirebase/view/screen/chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(  MyApp());
      //MultiProvider(
    //providers: [
     // ChangeNotifierProvider<AuthModelView>(create: (_) => AuthModelView()),
   // ],
    //child:,
 // ),

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            primarySwatch: Colors.pink,
            accentColor: Colors.deepPurple,
            backgroundColor: Colors.pink,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return HomeView();
            }else{
              return AuthView();
            }
          },
          ),
    );
  }
}
