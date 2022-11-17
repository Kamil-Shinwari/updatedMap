import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

class previewRouteScreens extends StatelessWidget {
  const previewRouteScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Let's Get Started",
              body:
                  'Naviagating routes in the app is easy! Find routes using the FIND sections,or plan your own using the route planner, available in this app or on ridewithgps.com',
              image: Image.asset(
                "assets/pview1.png",
                width: 500.w,
                height: 500.h,
              ),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Tap Navigate',
              body: 'Once you open a route, just tap Navigate to start Navigation. The app may take a moment to acquire GPS signal',
              image: Image.asset("assets/pview2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Start in Route Navigation',
              body: 'Your position will be displayed on the map as a blue dot , and navigation will begin. Follow the route line to start your ride. When you approach your first cue, it will be displayed at the top of the navigation screen and will also be spoken aloud',
              image: Image.asset("assets/pview3.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Viewing Cues on the LockScreen',
              body: 'if your phone screen turns off , you will still be able to see your cues on the lockscreen . Tap the cue to see an expanded view. Tap[repeat icon] to repeat the cute announcement',
              image: Image.asset("assets/pview4.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview5.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview6.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview7.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview8.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview9.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview10.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview11.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview12.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: 'off Course Alerts',
              body: 'if you end up off course ,the app will alert you with a warning sound and display an off course notification . it will give you prompts to the direction and distance to get back on course',
              image: Image.asset("assets/pview13.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            if (kDebugMode) {
              print("Done clicked");
            }
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          // showDoneButton: true,
          // showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: Padding(
            padding: EdgeInsets.only(left:50.0.h),
            child: Container(
              width: 70.w,
              height: 30.h,
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
    return  PageDecoration(
      imagePadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      imageFlex: 3,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
      pageColor: Color(0xff424242),
      // bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      // titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
      ),
    );
  }
}
