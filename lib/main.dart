import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/AllScreens/loginScreen.dart';
import 'package:riderapp/AllScreens/mainscreen.dart';
import 'package:riderapp/AllScreens/registrationScreen.dart';
import 'package:riderapp/DataHandler/appData.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AppData(),
      child: MaterialApp(
        title: 'TOWIT',
        theme: ThemeData(
          fontFamily: "Brand Bold ",
          primarySwatch: Colors.blue,
        ),
        initialRoute:RegistrationScreen.idScreen,
        routes:{
          RegistrationScreen.idScreen:(context) => RegistrationScreen(),
          LoginScreen.idScreen:(context) => LoginScreen(),
          MainScreen.idScreen:(context) => MainScreen(),

        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}




