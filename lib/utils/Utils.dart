import 'package:flutter/material.dart';
import 'package:googlemap/screens/HomePageWithOutLogin/withoutLogInHomePage.dart';
import 'package:googlemap/screens/MyHomePagee.dart';
import 'package:googlemap/screens/draw_Route/draw_a_route.dart';
import 'package:googlemap/screens/explore/explore.dart';
import 'package:googlemap/screens/exploreDemo_HomeScreen.dart';
import 'package:googlemap/screens/history.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/settings/Account_setting.dart';
import 'package:googlemap/screens/settings/MorePage.dart';
import 'package:googlemap/screens/settings/Setting_screen.dart';
import 'package:googlemap/screens/settings/uploadPage.dart';
import 'package:googlemap/screens/walkdata.dart';
import 'package:googlemap/screens/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

const Color yellowColor = Color(0xfffed813); //Yellow

const Color activeCyanColor = Color(0xff0a7c97);

const Color backgroundColor = Color(0xffebecee);

const List<Color> backgroundGradient = [
  Color(0xff80d9e9),
  Color(0xffa0e9ce),
]; //Cyan, and a mix of Cyan and Green

const List<Color> lightBackgroundaGradient = [
  Color(0xffa2e0eb),
  Color.fromARGB(255, 200, 228, 218),
];
const List<Widget> screens=[
         MyHomePagee(),
        // MapsRoutesExample(title: ""),
           MyHomePage(),
           History(),
          MyMoreScreen()
];

// const List<Widget> screens2=[
//             // MyHomePagee(),
//             ExploreDemoHomeScreen(),
//            History(),
//            webView(),
//            SettingScreen(),
           
           
// ];