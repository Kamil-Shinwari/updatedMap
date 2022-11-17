import 'package:flutter/material.dart';
import 'package:googlemap/screens/settings/Account_setting.dart';
import 'package:googlemap/screens/settings/widgets/mySettingWidgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("settings")),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingScreen(),)),
                child: MySettingsCard(
                  desc:
                      "Update Profile, metric units, jome location, privacy\n delete account ,notifications",
                  title: "Settings",
                  subTitle: "Account",
                ),
              ),
              MySettingsCard(title: "",subTitle: "Logging", desc: "Intervals and photo upload"),
              MySettingsCard(title: " ",subTitle: "Navigation", desc: "Alert distance, cues, sounds"),
                MySettingsCard(subTitle: "Live logging", desc: "Frequency, Photo uploads",title: " ",),
                MySettingsCard(title: " ",subTitle: "Bluetooth and Sensors", desc: "Add devices and displays"),
              MySettingsCard(title: "Help",subTitle: "About", desc: "Rate , Share and Learn about Ride with GPS"),
            MySettingsCard(title: "",subTitle: "Contact Support", desc: " "),
            MySettingsCard(subTitle: "Send Logs", desc: "Send debugging information to our staff to help \n diagnose a problem",title: "",),
            MySettingsCard(subTitle: "Send Database", desc: "Send application database to our staff to help \n diagnose problem",title: "",),
            ]),
      ),
    );
  }
}

