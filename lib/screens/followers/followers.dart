import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/MyProfile_setting/Edit_info.dart';
import 'package:googlemap/screens/followers/AddUsers.dart';
import 'package:googlemap/screens/followers/Following.dart';
import 'package:googlemap/screens/history.dart';

import '../MyProfile_setting/photos_page.dart';
import '../MyProfile_setting/profile_detail_page.dart';
class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepOrange,
      bottom: TabBar(
        tabs: [
          Tab(text: "Following",),
          // Tab(text: "Followers",),
          // Tab(text: "Routes",),
          Tab(text: "Friends",),
        ],
      ),
      title: Text('Followers'),
    ),
    body: TabBarView(
      children: [
       Followingscreen(),
        AddUsers(),
        //  GetRoutes(),
          PhotosPage()
      ],
    ),
  ),
);
  }
}