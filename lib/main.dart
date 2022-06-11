import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kin_music/components/routText.dart';
import 'package:kin_music/screens/home/profile.dart';
import 'package:kin_music/screens/login/google.dart';
import 'package:kin_music/screens/login/login.dart';
import 'package:kin_music/screens/home/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/mainNav.dart';
import '../../screens/home/home.dart';
import 'package:provider/provider.dart';

import 'provider/userProvider.dart';

  GoogleSignIn googleSignin = GoogleSignIn(
  scopes: <String>[
    'email'
  ]
);

 void main(){
 
   runApp(ChangeNotifierProvider(create: (_)=> userProvider(), child: start())  );
 }
 
 class start extends StatefulWidget{
   @override 
   _main_state createState() => _main_state();
 }

 class _main_state extends State<start>{
    GoogleSignInAccount? CurrentUser;
 
  void initState(){
    super.initState();
    googleSignin.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        CurrentUser = account;
      });
     });
    // googleSignin.signInSilently();
    
  }

  checkLogin() async {
    SharedPreferences local = await SharedPreferences.getInstance();

    if(local.getString('token') == null){
      return false;
    }else{
      return true;
    }
  }

   Widget build(BuildContext context){
      // GoogleSignInAccount? User = CurrentUser;
      // if(User == null){
      //   googleSignin.disconnect();
      // }else{
      //      googleSignin.signInSilently();
      // }
    // if(checkLogin()){
    //    Navigator.pushReplacement(
    //                             context, 
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     HomePage(test:'You are loged in' ,)
    //                                     ));
    // }else{
    //    Navigator.pushReplacement(
    //                             context, 
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     login()
    //                                     ));
    // }

    //      checkLogin().then((success) {
    //   if (success) {
    //     Navigator.pushReplacement(
    //                             context, 
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     HomePage(test:'You are loged in' ,)
    //                                     ));
    //   } else {
    //     Navigator.pushReplacement(
    //                             context, 
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     login()
    //                                     ));
    //   }
    // });

     return  MaterialApp(
       debugShowCheckedModeBanner: false,
        
       initialRoute: '/',
       routes: routesx,
      );
        
   }
 }