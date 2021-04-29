import 'package:driverapp/components/globalVariables.dart';
import 'package:driverapp/views/home.dart';
import 'package:driverapp/views/login.dart';
import 'package:driverapp/views/signup.dart';
import 'package:driverapp/views/vehicleInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : const FirebaseOptions(
      appId: '1:780492299038:android:1cf81adc429f110c72870f',
      apiKey: 'AIzaSyCzFWpinf2_mgOio38RUTEzxctPvB3_dz4',
      messagingSenderId: '780492299038',
      projectId: 'select-transportation',
      databaseURL: 'https://select-transportation.firebaseio.com',
    ),
  );

  currentFirebaseUser=await FirebaseAuth.instance.currentUser;

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //initialRoute: VehicleInfo.id,
        initialRoute: (currentFirebaseUser==null)?Login.id: Home.id,

        routes: {

          Home.id: (context)=>Home(),
          Signup.id:(context)=>Signup(),
          Login.id:(context)=>Login(),
          VehicleInfo.id:(context)=> VehicleInfo(),
        }

//home:RecommendRecipe(),);

    );
  }
}
