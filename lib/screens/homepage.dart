import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/screens/draw_Route/draw_a_route.dart';
import 'package:googlemap/screens/history.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/settings/uploadPage.dart';

import 'package:googlemap/screens/webview.dart';
import 'package:googlemap/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum menu { logout, history,drawRoute }

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<double> distance = ValueNotifier(0.0);
  double totalDistance = 0.0;
  late DateTime initialTime;
  late DateTime finalTime;
  late String totalTime;
  bool iconChanger = false;
  bool isKm =false;
  ValueNotifier<double> speed = ValueNotifier(0.0);
  ValueNotifier<double> aveS = ValueNotifier(0.0);
  List<double> averageSpeed = [];
  Uuid uuid = Uuid();
  TextEditingController Searchcontroller = TextEditingController();
  List<dynamic> myPredications = [];
  String sessionToken = '12345';
  List<LatLng> mylatlng = [];
  bool timerrunning = false;
  String myApiKey = 'AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI';
  late StopWatchTimer _stopWatchTimer;

  Set<Polyline> _polyline = {
    // Polyline(polylineId: PolylineId('1'), points:[
    //   LatLng(34.206123, 72.029800),
    // ]),
  };

  getPolyLinePoints(Position position, List<Location> list) async {
    PolylinePoints polylinePoints = PolylinePoints();
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        });
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            myApiKey,
            PointLatLng(position.latitude, position.longitude),
            PointLatLng(list[0].latitude, list[0].longitude));
    List<LatLng> polyLineCoordinates = [];

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
        _polyline.add(Polyline(
            polylineId: PolylineId('mydestiny'),
            points: polyLineCoordinates,
            color: Colors.red));
      });
      Navigator.pop(context);

      Fluttertoast.showToast(msg: polyLineCoordinates.length.toString());
    } else {
      Fluttertoast.showToast(msg: 'list is empty');
    }

    //_polyline.add(Polyline(polylineId: PolylineId('mydestiny'),points:polylineResul));
  }

  Future<Position> getlatlong() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(34.206123, 72.029800),
    zoom: 14.4746,
  );

  List<Marker> mymarkers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.206123, 72.029800),
      infoWindow: InfoWindow(
        title: 'My initial place',
      ),
    ),
  ];

  getData(String txtField) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    String request =
        '$baseURL?input=$txtField&key=$myApiKey&sessiontoken=$sessionToken';

    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      myPredications = jsonDecode(response.body)['predictions'];
      setState(() {});
    } else {
      print('some thing went wrong');
    }
  }

  onChange() {
    if (sessionToken == null) {
      sessionToken = uuid.v1();
    } else {
      getData(Searchcontroller.text);
    }
  }

  @override
  void initState() {
    Searchcontroller.addListener(() {
      onChange();
    });
    getlatlong().then((value) async {
      mymarkers.add(Marker(
          markerId: MarkerId('mylocation'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'MyCurrent Location')));
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      //if(mylatlng.length>0){
      // mylatlng.add(LatLng(value.latitude, value.longitude));
      //}
      setState(() {});
    });

    super.initState();
  }

  int x = 0;
  @override
  Widget build(BuildContext context) {
    // final countProvider = Provider.of<CountProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => webView()));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.bike_scooter),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Book a Ride Now!'),
                  )
                ],
              ),
            ),
            // leading: ValueListenableBuilder(valueListenable: aveS,builder: (context,value,child){
            //   return Text(aveS.value.toStringAsFixed(3));
            // }),
            // title: ValueListenableBuilder(
            //   valueListenable: speed,
            //   builder: (context,value,child){
            //     return Text(speed.value.toStringAsFixed(3)+ ' m/s');
            //   },
            // ),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                  child: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (var value) {
                    if (value == menu.history) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => History()));
                    } else if(value==menu.drawRoute){
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>MapsRoutesExample(title: "")));
                    }
                    
                    else {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          value: menu.history,
                          child: Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'History',
                                style: txtstyle,
                              )
                            ],
                          )),
                      PopupMenuItem(
                          value: menu.logout,
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Log Out',
                                style: txtstyle,
                              )
                            ],
                          )),
                        PopupMenuItem(child: Row(
                          children: [
                            Icon(Icons.change_circle,color: Colors.red,),
                            SizedBox(width: 5,),
                           Checkbox(value: isKm, onChanged: (value) {
                            
                              setState(() {
                                isKm = value!;
                                Navigator.pop(context);
                              });
                             
                           },)
                           
                          ],
                        )),
                           PopupMenuItem(
                          value: menu.drawRoute,
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Route',
                                style: txtstyle,
                              )
                            ],
                          ))
                    ];
                  }),
            ],
          ),
          body: Column(
            children: [
              TextFormField(
                controller: Searchcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Your Destination',
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: myPredications.length,
                      itemBuilder: (context, index) {
                        if (myPredications.length > 0) {
                          return ListTile(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              Searchcontroller.clear();
                              showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.red,
                                      )));
                              List<Location> list = await GeocodingPlatform
                                  .instance
                                  .locationFromAddress(
                                      myPredications[index]['description']);
                              Navigator.pop(context);
                              mymarkers.add(Marker(
                                  markerId: MarkerId(
                                      myPredications[0]['description']),
                                  position: LatLng(
                                      list[0].latitude, list[0].longitude),
                                  infoWindow: InfoWindow(
                                      title: myPredications[index]
                                          ['description'])));
                              Position position = await getlatlong();
                              getPolyLinePoints(position, list);
                              //  _polyline.add(Polyline(polylineId: PolylineId('mydestiny'),points:[LatLng(position.latitude, position.longitude),LatLng(list[0].latitude, list[0].longitude)]));
                            },
                            title: Text(myPredications[index]['description']),
                          );
                        } else {
                          return Container(
                            height: 200.0,
                          );
                        }
                      }),
                ),
              ),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      myLocationEnabled: true,
                      markers: Set.of(mymarkers),
                      polylines: _polyline,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Distance',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Speed',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        totalDistance.toStringAsFixed(3),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        ' meters',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      )
                                    ],
                                  ),
                                  
                                  Row(
                                    children: [
                                      Text(
                                     isKm==false? ((speed.value * 0.001) * 0.62137).toStringAsFixed(6)
                                     :((speed.value * 0.001)).toStringAsFixed(6),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                       isKm ==false? ' Ml/h':'Km/h',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(' Duration',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  timerrunning == true
                                      ? StreamBuilder<int>(
                                          stream: _stopWatchTimer.rawTime,
                                          initialData:
                                              _stopWatchTimer.rawTime.value,
                                          builder: (context, snapshot) {
                                            var value = snapshot.data;
                                            final displayTime =
                                                StopWatchTimer.getDisplayTime(
                                                    value!,
                                                    minute: true);
                                            return Text(
                                              displayTime,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            );
                                          })
                                      : Text(
                                          '0.000',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                  Text(
                                    'Stop Watch',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Elevation Gain',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Average Speed',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '0.000',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        ' Meters',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                       isKm ==false? ((aveS.value * 0.001)* 0.62137) .toStringAsFixed(6)
                                       : ((aveS.value * 0.001)) .toStringAsFixed(6),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                      Text(
                                        isKm==false?' Ml/h':'km/h',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        final ImagePicker imagePicker =
                                            ImagePicker();
                                        XFile? pickedFile =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                      },
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      )),
                                  CupertinoButton(
                                    onPressed: () async {
                                      timerrunning = true;
                                      _stopWatchTimer = StopWatchTimer();
                                      if (iconChanger == false) {
                                        iconChanger = true;
                                        initialTime = DateTime.now();
                                        Position position1 = await getlatlong();
                                        GoogleMapController controller =
                                            await _controller.future;
                                        controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                    target: LatLng(
                                                        position1.latitude,
                                                        position1.longitude),
                                                    zoom: 14)));

                                        Timer.periodic(Duration(seconds: 2),
                                            (timer) async {
                                          if (timerrunning != true) {
                                            _stopWatchTimer.dispose();
                                            QuerySnapshot querry =
                                                await FirebaseFirestore.instance
                                                    .collection('user')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection('LatLong')
                                                    .get();

                                            double fetchedTotalDistance;

                                            DocumentSnapshot dataTotalDistance =
                                                await FirebaseFirestore.instance
                                                    .collection('user')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get();

                                            if (dataTotalDistance.data() !=
                                                null) {
                                              var data =
                                                  dataTotalDistance.data();
                                              Map<String, dynamic> myd =
                                                  data as Map<String, dynamic>;

                                              // Map<String,dynamic> myTotalDistance=dataTotalDistance.data() as Map<String, dynamic>;
                                              // print('our total distance is: '+myTotalDistance['totalDistance']);
                                              fetchedTotalDistance =
                                                  myd['totalDistance'];
                                              fetchedTotalDistance =
                                                  (fetchedTotalDistance +
                                                      totalDistance);
                                              await FirebaseFirestore.instance
                                                  .collection('user')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'totalDistance':
                                                    fetchedTotalDistance
                                              });
                                            } else {
                                              debugPrint(
                                                  'total distance is empty');
                                            }

                                            finalTime = DateTime.now();
                                            //  totalTime=(finalTime.hour-initialTime.hour).toString()+' '+(finalTime.minute-initialTime.minute).toString()+' '+(finalTime.second-initialTime.second).toString();
                                            totalTime = (((finalTime.hour *
                                                            60) +
                                                        finalTime.minute +
                                                        (finalTime.second /
                                                            60)) -
                                                    ((initialTime.hour * 60) +
                                                        initialTime.minute +
                                                        (initialTime.second /
                                                            60)))
                                                .toStringAsFixed(3);

                                            double averageSpe = aveS.value;
                                            aveS.value = 0.000;
                                            String keyUid = uuid.v1();
                                            // setState(() {
                                            //   countProvider.setcount();
                                            // });

                                            // await FirebaseFirestore.instance
                                            //     .collection('user')
                                            //     .doc(FirebaseAuth
                                            //         .instance.currentUser!.uid)
                                            //     .collection('History')
                                            //     .doc(keyUid)
                                            //     .set({
                                            //   'lat': position1.latitude,
                                            //   "lon": position1.longitude,
                                            //   'ride': "new",
                                            //   'uid': keyUid,
                                            //   'average Speed':
                                            //       ((averageSpe / 1000) * 3600)
                                            //               .toStringAsFixed(3) +
                                            //           ' km/h',
                                            //   'Time taken':
                                            //       totalTime + ' minutes',
                                            //   'Total Distance Covered':
                                            //       totalDistance
                                            //               .toStringAsFixed(3) +
                                            //           ' meters',
                                            // }).then((value) {
                                            //   print('success');
                                            // });
                                            String totDist = totalDistance
                                                .toStringAsFixed(3);
                                            totalDistance = 0.000;
                                            Position newP= await getlatlong();
                                            Future.delayed(
                                              Duration(seconds: 3),
                                              () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UploadPage(
                                                            newLat: newP.latitude,
                                                            newlng: newP.longitude,
                                                            lat: position1
                                                                .latitude,
                                                            long: position1
                                                                .longitude,
                                                            averagespeed:
                                                                (averageSpe)
                                                                    .toString(),
                                                            time: totalTime,
                                                            distance: totDist,
                                                            speed: speed
                                                                .toString(),
                                                          ))),
                                            );
                                            // showModalBottomSheet(
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return Container(
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.red,
                                            //         ),
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.all(8.0),
                                            //           child: Column(
                                            //             children: [
                                            //               Expanded(
                                            //                   child: Row(
                                            //                     mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .spaceBetween,
                                            //                     children: [
                                            //                       CircleAvatar(
                                            //                         child: Icon(
                                            //                           Icons.show_chart,
                                            //                           color: Colors.red,
                                            //                         ),
                                            //                         backgroundColor:
                                            //                         Colors.white,
                                            //                       ),
                                            //                       Text(
                                            //                         'Total Distance: ',
                                            //                         style: TextStyle(
                                            //                             fontWeight:
                                            //                             FontWeight.bold),
                                            //                       ),
                                            //                       Text(
                                            //                         '${totDist} meters',
                                            //                         style: TextStyle(
                                            //                             fontSize: 25.0,
                                            //                             color: Colors.white),
                                            //                       )
                                            //                     ],
                                            //                   )),
                                            //               Expanded(
                                            //                   child: Row(
                                            //                     mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .spaceBetween,
                                            //                     children: [
                                            //                       CircleAvatar(
                                            //                         child: Icon(
                                            //                           Icons.timer,
                                            //                           color: Colors.red,
                                            //                         ),
                                            //                         backgroundColor:
                                            //                         Colors.white,
                                            //                       ),
                                            //                       Text(
                                            //                         'Total Time: ',
                                            //                         style: TextStyle(
                                            //                             fontWeight:
                                            //                             FontWeight.bold),
                                            //                       ),
                                            //                       Text(
                                            //                         totalTime + ' Minutes',
                                            //                         style: TextStyle(
                                            //                             fontSize: 25.0,
                                            //                             color: Colors.white),
                                            //                       )
                                            //                     ],
                                            //                   )),
                                            //               Expanded(
                                            //                   child: Row(
                                            //                     mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .spaceBetween,
                                            //                     children: [
                                            //                       CircleAvatar(
                                            //                         child: Icon(
                                            //                           Icons.speed,
                                            //                           color: Colors.red,
                                            //                         ),
                                            //                         backgroundColor:
                                            //                         Colors.white,
                                            //                       ),
                                            //                       Text(
                                            //                         'Average Speed: ',
                                            //                         style: TextStyle(
                                            //                             fontWeight:
                                            //                             FontWeight.bold),
                                            //                       ),
                                            //                       Text(
                                            //                         ((averageSpe / 1000) * 3600)
                                            //                             .toStringAsFixed(
                                            //                             3) +
                                            //                             ' km/hr',
                                            //                         style: TextStyle(
                                            //                             fontSize: 25.0,
                                            //                             color: Colors.white),
                                            //                       )
                                            //                     ],
                                            //                   )),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       );
                                            //     });
                                            // showDialog(context: context, builder: (context){
                                            //  return AlertDialog(
                                            //     title: Text(
                                            //       'Your Journey Details'
                                            //     ),
                                            //     content: Column(
                                            //       mainAxisSize: MainAxisSize.min,
                                            //       children: [
                                            //         Text('Average Speed: ' + ((averageSpe/1000)*3600).toStringAsFixed(3) +' km/hr'),
                                            //         Text('Distance Covered: '+totalDistance.toStringAsFixed(3)+' meters'),
                                            //         Text('Time taken: '+totalTime+' Minutes'),
                                            //       ]
                                            //     ),
                                            //   );
                                            // });

                                            for (var doc in querry.docs) {
                                              doc.reference.delete();
                                            }
                                            // Fluttertoast.showToast(msg: 'triggered');
                                            mylatlng = [];
                                            mymarkers = [];
                                            distance.value = 0.0;
                                            speed.value = 0.0;
                                            aveS.value = 0.0;
                                            _polyline = {};
                                            Searchcontroller.clear();
                                            //_polyline.remove(['fd',]);
                                            // _polyline.remove('mydestiny');
                                            setState(() {});
                                            timer.cancel();
                                          } else {
                                            _stopWatchTimer.onStartTimer();
                                            Position position =
                                                await getlatlong();
                                            String uu = uuid.v1();
                                            speed.value = position.speed;
                                            averageSpeed.add(position.speed);
                                            setState(() {});
                                            for (int z = 0;
                                                z < averageSpeed.length;
                                                z++) {
                                              aveS.value =
                                                  aveS.value  + averageSpeed[z];
                                            }
                                            aveS.value = aveS.value /
                                                averageSpeed.length;
                                            setState(() {});

                                            //  Fluttertoast.showToast(msg: position.speed.toString());
                                            
                                            await FirebaseFirestore.instance
                                                .collection('user')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection('LatLong')
                                                .doc(uu)
                                                .set({
                                              'uid': uu,
                                              'longi': position.longitude,
                                              'lati': position.latitude,
                                            }).then((value) async {
                                              print('success');

                                              QuerySnapshot querySnapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('user')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('LatLong')
                                                      .get();
                                              if (querySnapshot.docs.length >
                                                  0) {
                                                List<Map<String, dynamic>>
                                                    myfetchedlatlong = [];
                                                for (int i = 0;
                                                    i <
                                                        querySnapshot
                                                            .docs.length;
                                                    i++) {
                                                  int j = i + 1;
                                                  if (j <
                                                      querySnapshot
                                                          .docs.length) {
                                                    distance.value = distance
                                                            .value +
                                                        Geolocator
                                                            .distanceBetween(
                                                                querySnapshot
                                                                        .docs[i]
                                                                    ['lati'],
                                                                querySnapshot
                                                                        .docs[i]
                                                                    ['longi'],
                                                                querySnapshot
                                                                        .docs[j]
                                                                    ['lati'],
                                                                querySnapshot
                                                                        .docs[j]
                                                                    ['longi']);
                                                    //  Fluttertoast.showToast(msg: distance.value.toStringAsFixed(3));
                                                  }
                                                  // double distanceInMeters = sqrt(pow((querySnapshot.docs[j]['longi']-querySnapshot.docs[i]['longi']),2)+pow((querySnapshot.docs[j]['lati']-querySnapshot.docs[i]['lati']),2));
                                                  // distance=distance+distanceInMeters;
                                                  // Fluttertoast.showToast(msg: distance.toStringAsFixed(3));

                                                  mylatlng.add(LatLng(
                                                      querySnapshot.docs[i]
                                                          ['lati'],
                                                      querySnapshot.docs[i]
                                                          ['longi']));
                                                }

                                                _polyline.add(Polyline(
                                                    polylineId:
                                                        PolylineId('fd'),
                                                    points: mylatlng));
                                                // Fluttertoast.showToast(msg: distance.toString());
                                                // distance=0.0;
                                                mylatlng = [];
                                                totalDistance = distance.value;
                                                distance.value = 0.0;
                                                setState(() {});
                                              } else {
                                                print('no data found');
                                              }
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          }
                                        });
                                        // Position position = await getlatlong();
                                        // String uu=uuid.v1();
                                        // await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('LatLong').doc(uu).set(
                                        //     {
                                        //       'uid':uu,
                                        //       'longi':position.longitude,
                                        //       'lati':position.latitude,
                                        //     }
                                        // ).then((value){
                                        //   print('success');
                                        // }).onError((error, stackTrace){
                                        //   print(error.toString());
                                        // });
                                        // QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('LatLong').get();
                                        // if(querySnapshot.docs.length>0){
                                        //   List<Map<String,dynamic>> myfetchedlatlong=[];
                                        //
                                        //   for(int i=0;i<querySnapshot.docs.length;i++){
                                        //     mylatlng.add(LatLng(querySnapshot.docs[i]['lati'], querySnapshot.docs[i]['longi']));
                                        //   }
                                        //
                                        //   print(mylatlng.length);
                                        //   _polyline.add(Polyline(polylineId: PolylineId('fd'),points: mylatlng));
                                        //   setState(() {
                                        //
                                        //   });
                                        // mydata={
                                        //   'latitude':querySnapshot.docs[0]['lati'],
                                        //   'longitude':querySnapshot.docs[0]['longi'],
                                        // };
                                        // Map<String,dynamic> mydata2;
                                        // mydata2={
                                        //   'latitude':querySnapshot.docs[4]['lati'],
                                        //   'longitude':querySnapshot.docs[4]['longi'],
                                        // };
                                        // myfetchedlatlong.add(mydata);
                                        // myfetchedlatlong.add(mydata2);
                                        //
                                        // print(myfetchedlatlong[1]['longitude']);
                                        // print(myfetchedlatlong[1]['latitude']);
                                        //
                                        // mylatlng.add(LatLng(mydata2['latitude'], mydata2['longitude']));
                                        // _polyline.add(Polyline(polylineId: PolylineId('fd'),points: mylatlng));
                                        // setState(() {
                                        // });

                                        // //   }
                                        //    else{
                                        //      print('no data found');
                                        //    }
                                      } else {
                                        iconChanger = false;
                                        timerrunning = false;
                                        setState(() {});
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25.0,
                                      child: iconChanger == true
                                          ? Icon(
                                              Icons.pause,
                                              size: 50.0,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.play_arrow,
                                              size: 50.0,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        final ImagePicker imagePicker =
                                            ImagePicker();
                                        XFile? pickedFile =
                                            await imagePicker.pickImage(
                                                source: ImageSource.camera);
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MapsRoutesExample(title: ""),));
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: AlignmentDirectional.bottomCenter,
                    //   child:
                    // )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
