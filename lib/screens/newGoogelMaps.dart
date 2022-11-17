import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapsExample extends StatefulWidget {
  const GoogleMapsExample({super.key});

  @override
  State<GoogleMapsExample> createState() => _GoogleMapsExampleState();
}

class _GoogleMapsExampleState extends State<GoogleMapsExample> {
  int x=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(34.206123, 72.029800),zoom: 14)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 350,
          child: DChartBar(
    data: [
            {
                'id': 'Bar',
                'data': [
                    {'domain': 'january', 'measure': x,},
                    {'domain': 'febuary', 'measure': 0},
                    {'domain': 'March', 'measure': 0},
                    {'domain': 'April', 'measure': 0},
                ],
            },
    ],
    domainLabelPaddingToAxisLine: 16,
    axisLineTick: 2,
    axisLinePointTick: 2,
    axisLinePointWidth: 10,
    axisLineColor: Colors.green,
    measureLabelPaddingToAxisLine: 16,
    barColor: (barData, index, id) => Colors.green,
    showBarValue: true,
),
        ),
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      setState(() {
        x++;
      });
    },child: Text("Click")),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:draw_graph/draw_graph.dart';
// import 'package:draw_graph/models/feature.dart';

// final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
// double x=0;
// List<double>? mydata=<double>[];
// class MyScreen extends StatefulWidget {
//   @override
//   State<MyScreen> createState() => _MyScreenState();
// }

// class _MyScreenState extends State<MyScreen> {
//   final List<Feature> features = [
//     Feature(
//       title: "Ride",
//       color: Colors.blue,
//       data:mydata! ,
//     ),
//     // Feature(
//     //   title: "Exercise",
//     //   color: Colors.pink,
//     //   data: [1, 0.8, 0.6, 0.7, 0.3],
//     // ),
//     // Feature(
//     //   title: "Study",
//     //   color: Colors.cyan,
//     //   data: [0.5, 0.4, 0.85, 0.4, 0.7],
//     // ),
//     // Feature(
//     //   title: "Water Plants",
//     //   color: Colors.green,
//     //   data: [0.6, 0.2, 0, 0.1, 1],
//     // ),
//     // Feature(
//     //   title: "Grocery Shopping",
//     //   color: Colors.amber,
//     //   data: [0.25, 1, 0.3, 0.8, 0.6],
//     // ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return 
//        Scaffold(
//          body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 64.0),
//               child: Text(
//                 "Tasks Track",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//               ),
//             ),
//             LineGraph(
//               features: features,
//               size: Size(320, 400),
//               labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5','Day 6'],
//               labelY: ['20%', '40%', '60%', '80%', '100%'],
//               showDescription: true,
//               graphColor: Colors.black,
//               graphOpacity: 0.2,
//               verticalFeatureDirection: true,
//               descriptionHeight: 130,
//             ),
//             SizedBox(
//               height: 50,
//             )
//           ],
             
//            ),
//            floatingActionButton: FloatingActionButton(onPressed: (){
//             setState(() {
//               x++;
//               mydata!.add(x);
//             });
//            },child: Text("click me"),),
//        );
//   }
// }