import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LiveLoggingScreens extends StatelessWidget {
  const LiveLoggingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "What is Logging?",
              body:
                  'Live logging is a great way to share your real time location with friends and faimly. As Long as you are in cellular data range, the app will broadcast your progress, allowing the people you care about to follow on thier phone or computer',
              image: Image.asset(
                "assets/live1.png",
                width: 500.w,
                height: 500.h,
              ),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Start Live Logging',
              body: 'Tap Tools , then tap share to bring up the Live Logging menu. Tap Enable Live logging to begin  and Disable at any time by tapping the live logging icon in the lower left corner',
              image: Image.asset("assets/live2.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Live Log Setting',
              body: 'Tap Configure Setting in the Live Logging menu to modify broadcast interval , photo upload preferences and the privacy of your recording',
              image: Image.asset("assets/live3.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Share Your Live Log',
              body: 'To Share your live log, tap share in the live logging meny and then send your live log link via email , text , or social media. Now your friends and faimly can follow along from thier phone or computer',
              image: Image.asset("assets/live4.png"),
              // image: buildImage("assets/RouteNavigation/img3.png",context),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Viewing',
              body: 'The appp Makes it easy to share your progress with friends and faimly . They will see your ride stats, photos, phone signal and battery level . if Navigating, your route and estimated time of completion will be shown',
              image: Image.asset("assets/live5.png"),
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
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          isBottomSafeArea: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: Container(
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
