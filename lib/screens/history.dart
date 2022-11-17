import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/screens/showing_history_details/show_history_details.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  ValueNotifier<List<Map<String, dynamic>>> list = ValueNotifier([]);

  TextStyle style = TextStyle(
    color: Colors.red,
  );

  getHistory() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        
        .collection('History')
        .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (querySnapshot.docs.isEmpty) {
      Fluttertoast.showToast(msg: 'No data to show');
    } else {
      if (querySnapshot.docs.length > 0 && querySnapshot.docs.length == 1) {
        list.value.add({
          'Average Speed': querySnapshot.docs[0]['average Speed'].toString(),
          'Total Time': querySnapshot.docs[0]['Time taken'].toString(),
          'Distance Covered':
              querySnapshot.docs[0]['Total Distance Covered'].toString()
        });
      } else {
        for (DocumentSnapshot doc in querySnapshot.docs) {
          list.value.add({
            'Average Speed': doc['average Speed'].toString(),
            'Total Time': doc['Time taken'].toString(),
            'Distance Covered': doc['Total Distance Covered'].toString()
          });
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            
            .collection("History")
            .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
    );
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.red,
    //       title: Text('History'),
    //       centerTitle: true,
    //     ),
    //     body: ListView.builder(itemCount: list.value.length,itemBuilder: (context,index){
    //       return list.value.length!=0? ValueListenableBuilder(valueListenable: list,builder: (context,value,child){
    //         return Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(color: Colors.red,width: 2.0),
    //               borderRadius: BorderRadius.circular(20.0),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Expanded(child: Text('Average Speed: '+list.value[index]['Average Speed'].toString(),style: style,)),
    //                   Expanded(child: Text('Time Taken: '+list.value[index]['Total Time'].toString(),style: style,)),
    //                   Expanded(child: Text('Distance: '+list.value[index]['Distance Covered'].toString(),style: style,)),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       },):Center(child: CircularProgressIndicator());
    //     }),
    //   ),
    // );
  }
}
