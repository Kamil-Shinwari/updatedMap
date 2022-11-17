import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ViewArideScreens extends StatelessWidget {
  const ViewArideScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Let's Get Started",
              body:
                  'View all Your rides at once is so easy ',
              image: Image.asset(
                "assets/viewride1.png",
                width: 500,
                height: 500,
              ),
              
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
             PageViewModel(
              title: "Click bottomBar Item",
              body:
                  'Once You Login Successfully click on the Third bottom NavigationBar item . after clicking it will naviagte you to all History page , here will be given a list of all your rides that you have done it upto now ',
              image: Image.asset(
                "assets/PlanAroute/ride1.png",
                width: 500,
                height: 500,
              ),
              
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),

              PageViewModel(
              title: "Detils",
              body:
                  'A list of all your rides will be there . if you want to check details of each of ride along its path click on it and it will navigate you to details pages',
              image: Image.asset(
                "assets/PlanAroute/ride2.png",
                width: 500,
                height: 500,
              ),
              
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
