import 'package:flutter/material.dart';
import 'package:googlemap/screens/AppDemo.dart';
import 'package:googlemap/screens/Guides/Live_logging/Live_logging.dart';
import 'package:googlemap/screens/Guides/RouteNavigation/route_Navigation.dart';
import 'package:googlemap/screens/Guides/preview_a_route/preview_a_routeScreen.dart';
import 'package:googlemap/screens/Guides/viewRide_screen/viewRide_screen.dart';
import 'package:googlemap/screens/homepage.dart';
import 'package:googlemap/screens/plan_a_route/plan_a_route.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: SingleChildScrollView(
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                        image: AssetImage("assets/path2.jpg"), fit: BoxFit.cover)),
                        child: Padding(
                          padding: const EdgeInsets.only(top:110.0),
                          child: Text("Help Center",style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
              ),
            
                Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DemoScreen(),));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/path.jpg"),
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3), BlendMode.darken),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(15)),
                         child: Icon(Icons.info,size: 60,color: Colors.white,),
                                      ),
                                       SizedBox(height: 10,),
                      Text("App Overview",style: TextStyle(fontSize: 22),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/th.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3), BlendMode.darken)),
                          borderRadius: BorderRadius.circular(15)),
                          child: Icon(Icons.adjust,color: Colors.white,size: 60,),
                        ),
                        SizedBox(height: 10,),
                       Text("Record a Ride",style: TextStyle(fontSize: 22),), 
                      ],
                    ),
                  ),
                ],
              ),
            
               SizedBox(height: 3,),
              Container(
                width: double.infinity,
                height: 40,
                color: Colors.grey,child: Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text("How To Guide",textAlign: TextAlign.left,style: TextStyle(color: Colors.white),),
                ),),
            
                    SizedBox(height: 3,),
                Container(width: double.infinity,height: 120,
                decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IntroductionScreens(),));
                  },
                  child: MyNavWidget(
                    title: "Navigate Routes",
                    description: "Have a route you want to Navigate ? how to begin voice navigation and what to expect while riding ?",
                    url: "assets/nav.png",
                  ),
                ),),
            
                   SizedBox(height: 3,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlanArouteScreens(),));
                  },
                  child: Container(width: double.infinity,height: 120,
                  decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                  child: MyNavWidget(description: "Plan a Route",title: " Learn how to Plan a new route in the app ",url: "assets/route.png",),
                  ),
                ),
                 SizedBox(height: 3,),
                InkWell(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewArideScreens(),));
                  },
                  child: Container(width: double.infinity,height: 120,
                  decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
                  child: MyNavWidget(title: "View a Ride",description: "Learn how to get the most out of your ride metrics or check your route before settings",url: "assets/seeride.png",),
                  ),
                ),

              //    SizedBox(height: 3,),
              // InkWell(
              //   onTap: (){
              //      Navigator.push(context, MaterialPageRoute(builder: (context) => previewRouteScreens(),));
              //   },
              //   child: Container(width: double.infinity,height: 120,
              //   decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
              //   child: MyNavWidget(title: "preView a Ride",description: "Learn how to check your route before setting out ",url: "assets/location.png",),
              
              //   ),
              // ),

              // SizedBox(height: 3,),
              // InkWell(
              //   onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => LiveLoggingScreens(),));
              //   },
              //   child: Container(width: double.infinity,height: 120,
              //   decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 1)),
              //   child: MyNavWidget(title: "Live Logging",description: "Learn About sharing your location while you ride using Live Logging",url: "assets/logging.png",),
              //   ),
              // ),

              
                    ],
                  ),
            ),
          )),
    );
  }
}

class MyNavWidget extends StatelessWidget {
 final String? title;
final String? description;
final String? url;

  const MyNavWidget({super.key, this.title, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 3,
        child: Container(child: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("$title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text(" $description ",style: TextStyle(fontSize: 14),),
          ]),
        ),)),
        SizedBox(width: 5,),
         Expanded(
        flex: 1,
        child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("$url",),),borderRadius: BorderRadius.circular(10),color: Colors.white),)),
    ]);
  }
}


