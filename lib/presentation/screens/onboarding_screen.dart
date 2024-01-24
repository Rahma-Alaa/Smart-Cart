// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Smarket/presentation/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnoardingScreenState createState() => OnoardingScreenState();
}

class OnoardingScreenState extends State<OnboardingScreen> {
  final int pageNum = 3;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  //Number of Intro screens

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < pageNum; i++) {
      list.add(i == currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }
  //Navigator between screens

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 7.5),
      height: 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xff2c6976) : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(color: const Color(0xff2c6976), width: 1.5),
      ),
    );
  }
  //Navigator Style

  // saveprefs() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final showScreen = preferences.getBool('showScreen') ?? false;
  //   if (showScreen == true) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const SignIn()));
  //   }
  // }
  _storeOnboardInfo() async {
    WidgetsFlutterBinding.ensureInitialized();
    int isViewed = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  void initState() {
    // saveprefs();
    _storeOnboardInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  // START [WAVE]
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/wave.svg",
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // END [WAVE]
                  // START [PAGES]
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      //Enable to navigator between intro screens

                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/gifs/QRCode.gif', // GIF
                                height: 400,
                              ),
                            ),
                            const Text(
                              textScaleFactor: 1,
                              "Scan the QR code",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'harabaraBlack',
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              textScaleFactor: 1,
                              ' and enjoy with new\nshopping experience!',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "harabara",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 100,
                            ),
                            const Text(
                              textScaleFactor: 1,
                              "Pay Online",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'harabaraBlack',
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              textScaleFactor: 1,
                              ' Shop quickly without\nwaitting for a turn at the\n        cashier!',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "harabara",
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                'assets/gifs/E_Wallet.gif', // GIF
                                height: 300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Image.asset(
                                'assets/gifs/feature.gif', // GIF
                                height: 300,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              textScaleFactor: 1,
                              "New Features",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'harabaraBlack',
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              textScaleFactor: 1,
                              'Enjoy with new features\n that are useful for you',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "harabara",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // END [PAGES]
                  // START [VECTORS]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/images/LeftVector.svg"),
                      SvgPicture.asset("assets/images/RightVector.svg"),
                    ],
                  ),
                  // END [VECTORS]
                  // START [SLIDER+BTN]
                  Column(
                    children: [
                      const SizedBox(
                        height: 600,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Row(
                              children: buildPageIndicator(),
                            ),
                          ),
                          (currentPage != pageNum - 1)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () =>
                                                pageController.jumpToPage(2),
                                            child: SvgPicture.asset(
                                              "assets/icons/Skipbtn.svg",
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: Container(
                                    height: 40,
                                    width: 95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xff2c6976),
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          //saveprefs();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignIn()),
                                          );
                                        },
                                        child: const Text(
                                          textScaleFactor: 1,
                                          "Start",
                                          style: TextStyle(
                                            fontFamily: "harabaraBold",
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                  // END [SLIDER+BTN]
                ],
              ),
            ]),
      ),
    );
  }
}
