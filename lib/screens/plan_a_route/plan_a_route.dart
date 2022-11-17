import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class PlanArouteScreens extends StatelessWidget {
  const PlanArouteScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Let's Get Started",
              body:
                  'Planning a route on the mobile route planner is easy! Just tap where you want to go on the map , and the routing engine will start generating your route ,For Planning A route first of all Click on the seconds ride tab from bottom navigationbar ,At corner of appbar we have a menu button click on menu button and the Click on Route',
              image: Image.asset(
                "assets/PlanAroute/screen1.png",
                width: 500,
                height: 500,
              ),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Tapping',
              body: 'now click on the circle button to get your current location . after getting current location tap anywhere on the map it will placed a Marker at that point , Now tap on the other place at map it will place a second Marker',
              image: Image.asset("assets/PlanAroute/screen2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'button Cllick',
              body: 'After placing two markers now click the draw button and hence it will draw your route',
              image: Image.asset("assets/PlanAroute/screen3.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            // PageViewModel(
            //   title: 'Routing types',
            //   body: 'The mobile route planner default routing type is cycling. However you can change the routing system to work better for walking or even driving. if you encounter roads or paths htat wont allow you to coute on them cycling mode, try walking mode, or use the draw linees tool to get through , and then return to cycling mode',
            //   image: Image.asset("assets/plan4.png"),
            //   // image: buildImage("assets/RouteNavigation/img3.png",context),
            //   //getPageDecoration, a method to customise the page style
            //   decoration: getPageDecoration(),
            // ),
            // PageViewModel(
            //   title: 'Add POI',
            //   body: 'You can add points of interest (POI) to your route to denote water stops, photo, oppurtunites , canpsites or any number of thing . To add a POI to your route , just tap on Route Tools, and select "Add POI. you Can choose the type of POI and add as much additional information as you like',
            //   image: Image.asset("assets/plan5.png"),
            //   // image: buildImage("assets/RouteNavigation/img3.png",context),
            //   //getPageDecoration, a method to customise the page style
            //   decoration: getPageDecoration(),
            // ),
          ],
          onDone: () {
            if (kDebugMode) {
              print("Done clicked");
            }
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: Container(
            width: 70,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );
  }

  //widget to add the image on screen
  // Widget buildImage(String imagePath,BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //       height: 200,
  //     child: Image.asset(
  //       imagePath,

  //     ),
  //   );
  // }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      imageFlex: 3,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      pageColor: Color(0xff424242),
      // bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      // titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
