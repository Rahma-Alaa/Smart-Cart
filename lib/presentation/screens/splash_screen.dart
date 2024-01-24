import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/presentation/screens/progress_home.dart';
import 'package:Smarket/presentation/screens/sign_in.dart';
import 'no_internet.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? isviewed;
  int? isSign;
  getIsViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isviewed = prefs.getInt('onBoard');
      isSign = prefs.getInt('isSign');
      // print(isSign);
    });
  }

  bool connected = false;

  Future<void> _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      connected = result != ConnectivityResult.none;
    });
  }

  @override
  void initState() {
    getIsViewed();
    _checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EasySplashScreen(
          backgroundColor: Colors.white,
          logo:
              Image.asset('assets/images/SplashScreenLogo.png'), //SmartCartLogo
          logoWidth: 250,
          loadingText: const Text(
            textScaleFactor: 1,
            'All Rights Reserved © 2023',
            style: TextStyle(
                color: Color(0xff5B5050), fontSize: 20, fontFamily: "harabara"),
          ),
          showLoader: false,
          navigator: connected
              ? (((isviewed?.toInt()) == 1)
                  ? ((isSign?.toInt()) == 1)
                      ? MyLoadingScreenToHome(
                          title: 'Starting...',
                        )
                      : const SignIn()
                  : const OnboardingScreen())
              : const NoInternet(),
          durationInSeconds: 2,
        ),
      ),
    );
  }
}
