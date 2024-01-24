import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/scan_qr.dart';

class PopScreen extends StatefulWidget {
  const PopScreen({super.key});

  @override
  PopScreenState createState() => PopScreenState();
}

class PopScreenState extends State<PopScreen> {
  Future openPop() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text(
              textScaleFactor: 1,
              "Select Cart",
              style: TextStyle(
                fontFamily: "harabaraBold",
                fontSize: 23,
              ),
            ),
            content: SizedBox(
              height: 240,
              width: 250,
              child: Column(
                children: <Widget>[
                  const Text(
                    textScaleFactor: 1,
                    "Scan with your phone’s camera to select the cart.",
                    style: TextStyle(
                      fontFamily: "harabara",
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset("assets/gifs/scan.gif"),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
                  child: Container(
                    height: 45,
                    width: 165,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffFFDC70),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const ScanQRCode()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 15,
                              ),
                              SvgPicture.asset("assets/icons/qrCode.svg"),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                textScaleFactor: 1,
                                "Scan Now",
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
                ),
              ),
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
