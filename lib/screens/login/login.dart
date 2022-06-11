import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kin_music/network/api_service.dart';
import 'package:kin_music/screens/home/profile.dart';
import 'package:kin_music/screens/utils/math_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json, jsonDecode;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../provider/userProvider.dart';

GoogleSignIn googleSignin = GoogleSignIn(
  scopes: <String>[
    'email'
  ]
);

final url = Uri.parse('http://34.79.92.74/rest-auth/login/');
final urlz = Uri.parse('http://34.79.92.74/rest-auth/google/');
var  Authz = 'sdf';

class login extends StatefulWidget{
  @override 

  loginState createState() => loginState();

}


class loginState extends State<login>{
  GoogleSignInAccount? CurrentUser;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override 
  void initState(){
    super.initState();
    googleSignin.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        CurrentUser = account;
      });
     });
    googleSignin.signInSilently();
  }

void GoogleHandle() async {
 
    
 var  ask = await googleSignin.signIn();
 var gauth = await ask!.authentication;
//  var auth = await googleSignin.scopes.map((e) =>  e);
 var cc =   GoogleAuthProvider.credential(
  accessToken: gauth.accessToken,
  idToken: gauth.idToken
);
// if(cc.accessToken == null){
//   setState(){
//     Authz =  cc.accessToken!;
// //   }
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text('Registerd Successfully!!')));
// }
setState((){
  Authz = cc.accessToken as String;
});
// Authz =  cc.accessToken!;
// if(gauth.accessToken != null || gauth.idToken != null){
//     return gauth.accessToken;
// }
// return cc.accessToken! as String;
   
  
}
// CircularProgressIndicator()

 Widget loginPage(context){

    GoogleSignInAccount? USER = CurrentUser;

  if(USER != null){
   return loginHandler(context);
  }

  
   return SafeArea(child: 
        Scaffold(
          body: Container(
            color: Color(0xffEEEEEE),
            width: size.width,
            height: size.height,
            // height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
              
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: 
                      EdgeInsets.only(
                        top: getVerticalSize( 110 ),
                      ),
                      child: Column(children: [
                        Center(
                          child: Column(
                          children: [
                          Text('K I N', style:  
                          TextStyle(color: Color.fromARGB(248, 22, 21, 20), fontSize: getFontSize(20))),
                          SizedBox(height: getVerticalSize(15)),
                          Text('Stream your music all day!', style:TextStyle(fontSize: getFontSize(15), color: Color.fromARGB(234, 221, 119, 2) )),
                          SizedBox(height: getVerticalSize(20)),
                          Image.asset('assets/images/img_vecteezyca2.png',
                              height: getVerticalSize(170),
                              fit: BoxFit.fill,
                                ),
                          SizedBox(height: getVerticalSize(25),),
                          Padding(padding: EdgeInsets.only(
                            left: getHorizontalSize(70),
                            right: getHorizontalSize(70),
                          ),
                          child: Column(children: [
                            TextField(
                             controller: username,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              fillColor: Color.fromARGB(248, 216, 126, 9),
                              labelText: 'Enter your username',
                              labelStyle: TextStyle(
                                fontSize: getFontSize(15),
                                color: Color.fromARGB(248, 22, 21, 20)
                                 ),
                              hintText: 'username',
                              prefixIcon: Icon(Icons.email, color: Color.fromARGB(234, 221, 119, 2),)
                               
                            ),
                          ),
                          TextField(
                             controller: password,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              fillColor: Color.fromARGB(248, 22, 21, 20),
                              labelText: 'Enter your Password',
                              labelStyle: TextStyle(
                                fontSize: getFontSize(15),
                                color: Color.fromARGB(248, 22, 21, 20) 
                                 ),
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock, color: Color.fromARGB(234, 221, 119, 2) ,)
                               
                            ),
                          ),
                           Consumer<userProvider>(builder: (context, value, child) {
                             if(value.isLoading == true){
                             return Center(child: Column(children: [
                               ElevatedButton(
                            onPressed: ()  {
                             
                               
                              },
                              style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all(Color.fromARGB(234, 221, 119, 2))  
                            ),
                            child:  Text('Login'), 
                              ),
                              Stack(
                                    alignment: Alignment.center,
                                    children: [
                                  CircularProgressIndicator()
                                    ],
                                  )
                             ],)
                              );
                             }else{
                              return ElevatedButton(
                            onPressed: () async{
                             
                                if(value.isLoading == true){
                                     Stack(
                                    alignment: Alignment.center,
                                    
                                    children: [
                                      Center(child:  CircularProgressIndicator(),)
                                    ],
                                  );

                                }else{
                                 var data = {
                                   "username": username.text,
                                   "email": username.text,
                                   "password": password.text
                                  };  
                                    var ask = await value.login(url, data);
                                    // var de = json.decode(ask);
                                  // var dd = json.decode(de);
                                //  
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(ask))); 
                                   
                                }
                              },
                              style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all(Color.fromARGB(234, 221, 119, 2))  
                            ),
                            child:  Text('Login'), 
                              );
                             }
                            // FutureBuilder(
                            //   future: 
                            //   builder: builder){
                              
                            // }
                            }),
                               TextButton(onPressed: ()async {
                                await googleLogout();
                               }, child: Text('logout')),
                          Center(
                            child: Column(children: [
                              TextButton( onPressed: (){}, child: Text('Register Now')),
                              // Text('Continue with')
                            ]),
                          ),
                          Container(child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              TextButton(onPressed: ()async{
                               GoogleHandle();
                              }, child: SvgPicture.asset('assets/images/google.svg', height: getVerticalSize(60),)),
                              SvgPicture.asset('assets/images/fb.svg', height: getVerticalSize(60))
                            ],),)
                          ],
                          
                          )
                          )
                          
                            ],
                          )
                        )
                      ]),
                    )
                ],)
              )
               ),
          ),
        )
    );

 }

 
  // var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');/

 Widget loginHandler(context){
   return Scaffold(
     body: FutureBuilder(
       future: googeAuthApi(Authz, urlz),
       builder: (context, AsyncSnapshot<dynamic> snapshot)  {
         if(snapshot.connectionState == ConnectionState.waiting){
           return Stack(alignment: Alignment.center,
           children: [
             CircularProgressIndicator()
           ],
           ); 
         }else{
           if(snapshot.hasData){
            //  var xx = jsonDecode(snapshot.data);
            //  var dd = json.decode(xx);
             return HomePage(test: snapshot.data);
           }else{
             return Text('error');
           }
         }
       },
        ) ,
   );
 }


 Future googleLogout() async{
   try{
   googleSignin.disconnect();

   }
   catch (error){
     print(error);
   }
 }

  Widget build(BuildContext context){


 
      return loginPage(context);
     
     
  }
}