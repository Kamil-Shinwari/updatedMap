import 'package:flutter/material.dart';
// import 'package:googlemap/screens/help_screen.dart';

class ExploreDemoHomeScreen extends StatefulWidget {
  const ExploreDemoHomeScreen({super.key});

  @override
  State<ExploreDemoHomeScreen> createState() => _ExploreDemoHomeScreenState();
}

class _ExploreDemoHomeScreenState extends State<ExploreDemoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black.withOpacity(0.8),
        body: Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 50,
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 120,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Ampus Ride ! Take A look \n arround or check out some tips by tapping\n",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      InkWell(
                        child: Text(
                          "More> Help Center",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.6),
            child: AlertDialog(
              title: Text('Home'), // To display the title it is optional
              content: Text(
                  'The home screen lets you see your  own recent activites and content stats, upcoming, events, and your, friends activity, all in one place '), // Message which will be pop up on the screen
              // Action widget which will provide the user to acknowledge the choice
              actions: [
                TextButton(
                  // FlatButton widget is used to make a text to work like a button
                  // textColor: Colors.black,
                  onPressed:
                      () {}, // function used to perform after pressing the button
                  child: Text('Dissmiss'),
                ),
                TextButton(
                  // textColor: Colors.black,
                  onPressed: () {},
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
