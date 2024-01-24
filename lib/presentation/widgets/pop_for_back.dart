import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackPopScreen extends StatefulWidget {
  const BackPopScreen({super.key});

  @override
  BackPopScreenState createState() => BackPopScreenState();
}

class BackPopScreenState extends State<BackPopScreen> {
  Future openPop() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              textScaleFactor: 1,
              "Warning!",
              style: TextStyle(
                fontFamily: "harabaraBold",
                fontSize: 23,
                color: Colors.red,
              ),
            ),
            content: SizedBox(
              height: 100,
              width: 250,
              child: Column(
                children: const <Widget>[
                  Text(
                    textScaleFactor: 1,
                    "Are you sure you want to leave?",
                    style: TextStyle(
                      fontFamily: "harabara",
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textScaleFactor: 1,
                    "If you choose leave you will lose all active",
                    style: TextStyle(
                      fontFamily: "harabara",
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff2c6976),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      textScaleFactor: 1,
                                      "Leave",
                                      style: TextStyle(
                                        fontFamily: "harabaraBold",
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff2c6976),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      textScaleFactor: 1,
                                      "Cancle",
                                      style: TextStyle(
                                          fontFamily: "harabaraBold",
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
      );

  //All above for pop screen
  //This code will be linked to the Home screen code (Eng.Mohamed's task)

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      // used MaterialApp just for run in main.dart

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff2C6976),
        body: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Center(
              child: Text(
                textScaleFactor: 1,
                "Home Screeen",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: "harabaraBold"),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              height: 80,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    openPop();
                  },
                  child: const Text(
                    textScaleFactor: 1,
                    "Market",
                    style: TextStyle(
                      fontFamily: "harabaraBold",
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      //Just for test the screen
    );
  }
}
