import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googlemap/screens/settings/widgets/mySettingWidgets.dart';
class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Settings")),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       accountCards(subTitle:"Update Profile" , desc: "",title: "General Settings",),
       accountCards(subTitle: "Default Geat", desc: "",title: "",),
       accountSettingWidget(title: "Use Metric Units",child1: Checkbox(onChanged: (val){},value: true),),
       accountCards(subTitle: "Use Metric Units", desc: "",title: "",),
       
      ],
    ),
    );
  }
}

class accountCards extends StatelessWidget {
  final String? title;
  final String subTitle;
  final String desc;

  const accountCards(
      {super.key, this.title, required this.subTitle, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        width: double.infinity,
        height: 80.h,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "$title",
                style: TextStyle(fontSize: 16, color: Colors.red),
              )),
          SizedBox(
            height: 8,
          ),
          Text(
            "$subTitle",
            style: TextStyle(
                color: Colors.black87,  fontSize: 16.sp,fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "$desc ",
            style: TextStyle(color: Colors.grey),
          ),
        ]),
      ),
    );
  }
}


class accountSettingWidget extends StatelessWidget {
  final String title;
  final Widget? child1;

  const accountSettingWidget({super.key, required this.title, this.child1});

  @override
  Widget build(BuildContext context) {
    return  Card(
      
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: Container(
          height: 80.h,
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("$title",style: TextStyle(fontWeight:FontWeight.w600),),
                child1!,
                // Divider(thickness: 1,)
              ]),
        ),
      ),
    );

    
  }
    
}
