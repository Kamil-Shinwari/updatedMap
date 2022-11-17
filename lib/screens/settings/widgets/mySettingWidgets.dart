import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySettingsCard extends StatelessWidget {
  final String? title;
  final String subTitle;
  final String desc;

  const MySettingsCard(
      {super.key, this.title, required this.subTitle, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        width: double.infinity,
        height: 100,
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
                color: Colors.black87,  fontSize: 16,fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
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
