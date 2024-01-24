import 'package:flutter/material.dart';
import 'package:Smarket/presentation/screens/splash_screen.dart';
import '../../core/constants/constant.dart';
import '../widgets/background.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  NoInternetState createState() => NoInternetState();
}

class NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return BackGround(
      children: <Widget>[
        const SizedBox(
          height: 85,
        ),
        Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/gifs/No_connection.gif", height: 300),
              const SizedBox(
                height: 24,
              ),
              const Text(
                textScaleFactor: 1,
                "No internet connection",
                style: TextStyle(
                  fontFamily: "harabaraBold",
                  fontSize: 20,
                  color: myDarkGray,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 18, 30),
                child: Container(
                  height: 45,
                  width: 165,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff2c6976),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              textScaleFactor: 1,
                              "Check Again",
                              style: TextStyle(
                                fontFamily: "harabaraBold",
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
