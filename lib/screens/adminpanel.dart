import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/login.dart';
import 'package:googlemap/screens/showing_history_details/show_history_details.dart';
import 'package:googlemap/screens/walkdata.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {

  // check()async{
  //   QuerySnapshot querySnapshot=await FirebaseFirestore.instance.collection('user').get();
  //
  //   if(querySnapshot!=null){
  //     print('hello');
  //     print(querySnapshot.docs.length);
  //   }
  //   else{
  //     print('hello no data');
  //   }
  //
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  check();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Colors.red,
      //     title: Text(
      //       'Admin Panel'
      //     ),
      //     centerTitle: true,
      //     actions: [
      //       InkWell(
      //         onTap: (){
      //           FirebaseAuth.instance.signOut();
      //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      //         },
      //         child: Icon(Icons.logout),
      //       )
      //     ],
      //   ),
      //   body: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text('Sr No.'),
      //             Text('Name'),
      //             Text('Total Distance'),
      //             Text('View Details'),
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: StreamBuilder(
      //           stream:FirebaseFirestore.instance.collection('user').orderBy('totalDistance',descending: true).snapshots(),
      //           builder: (context,snapshot){
      //             if(snapshot.hasData){
      //               if(snapshot.connectionState==ConnectionState.active){
      //                 QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
      //                    return ListView.builder(itemCount:querySnapshot.docs.length,itemBuilder: (context,index){
      //                     double distance= querySnapshot.docs[index]['totalDistance'];
      //                   return Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                         border: Border.all(color: Colors.red,width: 2.0),
      //                         borderRadius: BorderRadius.circular(20.0),
      //                       ),
      //                       child: InkWell(
      //                         onTap: (){
      //                           Navigator.push(context, MaterialPageRoute(builder: (context)=>WalkData(uid: querySnapshot.docs[index]['uid'])));

      //                         },
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Text((index+1).toString()),
      //                               Text(querySnapshot.docs[index]['name'],textAlign: TextAlign.center,),
      //                               Row(
      //                                 children: [
      //                                   Text(distance.toStringAsFixed(3)),
      //                                   Text('M'),
      //                                 ],
      //                               ),
      //                               Icon(Icons.note),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 });
      //               }

      //             }
      //             return Center(child: CircularProgressIndicator(color: Colors.red,));
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),


      child: Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            
            .collection("History")
            .orderBy("Total Distance Covered",descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Loading..."),
                  SizedBox(
                    height: 50.0,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.docs[index]["url"]),
                                  fit: BoxFit.cover)),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowingDetails(
                                        latitude: snapshot.data!.docs[index]
                                            ["lat"],
                                        longitude: snapshot.data!.docs[index]
                                            ["lon"],
                                            newLongitude: snapshot.data!.docs[index]
                                            ["newlng"],
                                            newlatitude: snapshot.data!.docs[index]
                                            ["newlat"],
                                            distance:snapshot.data!.docs[index]
                                            ["Total Distance Covered"] ,
                                            totalTime: snapshot.data!.docs[index]
                                            ["Time taken"],
                                            title:snapshot.data!.docs[index]
                                            ["title"] ,
                                            url: snapshot.data!.docs[index]
                                            ["url"],
                                            averageSpeed:snapshot.data!.docs[index]
                                            ["average Speed"] ,
                                            description:snapshot.data!.docs[index]
                                            ["desc"] ,
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Title : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              ["title"])
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Time Taken : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              ["Time taken"])
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Distance : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              ["Total Distance Covered"])
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Description : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              ["desc"])
                                        ],
                                      )
                                    ]),
                              ),
                            )),
                      ]),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ),
    );
  }
}
