import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:online_music_app/playlist.dart';
import 'Components/custom_list.dart';
import 'HomeScreen.dart';
import 'Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // void _signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser!.authentication;
  //
  //     // Use the obtained googleAuth.accessToken and googleAuth.idToken
  //     // for further authentication or API calls.
  //   } catch (error) {
  //     // Handle sign-in error.
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white
        )
      ),
      home:  HomeScreen(),
      getPages: [
        GetPage(name: '/', page: ()=> HomeScreen()),
        GetPage(name: '/register', page: ()=> RegistrationForm()),
        GetPage(name: '/playlist', page: ()=> playList())
      ],
    );
  }
}

