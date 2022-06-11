 
import 'package:flutter/material.dart';
import 'package:kin_music/screens/home/home.dart';
import 'package:kin_music/screens/login/login.dart';

import 'package:kin_music/screens/home/register.dart';

import '../screens/login/login.dart';


final Map<String, WidgetBuilder> routesx = {
  '/' : (context) => login(),
  '/reg' : (context) =>  register(),
  '/home': (context) => homex(),
  
};  