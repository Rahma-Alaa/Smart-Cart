// ignore_for_file: file_names, library_private_types_in_public_api
import 'dart:convert';
import 'package:Smarket/data/models/get_home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/constant.dart';
import '../../data/models/get_msg.dart';
import '../../data/repository/get_home.dart';
import '../widgets/drawerHeader.dart';
import '../widgets/drawerListTitle.dart';
import '../widgets/homeBtn.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String userName = "";
String userEmail = "";
int userId = 0;
String base = "";
String labelName = "";
List cardList = [];
List invoicesList = [];

class _HomeState extends State<Home> {
  fastuserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? name = prefs.getString('userName');
    // final String? email = prefs.getString('userEmail');
    final int? id = prefs.getInt('id');
    // print(name);

    GetHome data = await homeInfo(id!);
    GetMsg msg = await userImg(id);
    final response = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[CardController]/GetAllUserCard?userId=${id.toString()}'));
    final response2 = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[InvoiceHistory]/GetInvoicesData?useId=${id.toString()}'));

    setState(() {
      base = msg.message!;
      userName = data.userName!;
      userEmail = data.userEmail!;
      labelName = data.userName!;
      cardList = json.decode(response.body);
      invoicesList = json.decode(response2.body);
    });
  }

  @override
  void initState() {
    fastuserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: myDarkGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDrawerHeader(base64: base, name: userName, email: userEmail),
          const DrawerListTitle(
            title: "Account Settings",
            icon: "user",
            toScreen: 'setting',
          ),
          const DrawerListTitle(
            title: "Billing Settings",
            icon: "bank",
            toScreen: 'billing',
          ),
          const DrawerListTitle(
            title: "Signout",
            icon: "logout",
            toScreen: 'signout',
            divider: true,
            logOut: true,
          ),
          const DrawerListTitle(
            title: "Support",
            icon: "support",
            toScreen: 'support',
          ),
          const DrawerListTitle(
            title: "About",
            icon: "help",
            toScreen: 'about',
          ),
        ],
      )),
      body: Stack(
        children: [
          // START [GIF]
          Center(
            child: Column(
              mainAxisAlignment: (MediaQuery.of(context).size.width <= 620)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gifs/Hello.gif",
                  width: (MediaQuery.of(context).size.width <= 680)
                      ? (kIsWeb)
                          ? 300
                          : 350
                      : 380,
                )
              ],
            ),
          ),
          // END [GIF]
          //_____________
          // START [CIRCLE 1]
          Column(
            children: [
              const SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  SvgPicture.asset(
                    "assets/images/circle.svg",
                    alignment: Alignment.center,
                  ),
                ],
              )
            ],
          ),
          // END [CIRCLE 1]
          //_____________
          // START [RIGHT LEAF]
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                "assets/images/rightLeaf.svg",
              ),
              const SizedBox(
                width: 14,
              )
            ],
          ),
          // END [RIGHT LEAF]
          //_____________
          // START [CIRCLE 2]
          Column(
            children: [
              const SizedBox(
                height: 190,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/circle.svg",
                  ),
                  const SizedBox(
                    width: 70,
                  )
                ],
              ),
            ],
          ),
          // END [CIRCLE 2]
          //_____________
          // START [LEFT LEAF]
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset("assets/images/leftLeaf.svg"),
              const SizedBox(
                height: 100,
              )
            ],
          ),
          // END [LEFT LEAF]
          //_____________
          // START [BTN]
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 24,
                  ),
                  HomeBtn(title: "Market", toScreen: "market"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  HomeBtn(title: "Invoices", toScreen: "Invoices"),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
          // END [BTN]
          //_____________
          // START [TEXT]
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  SizedBox(
                    height:
                        (MediaQuery.of(context).size.height <= 600) ? 0 : 55,
                  ),
                  const Text(
                    textScaleFactor: 1,
                    "Hi,",
                    style: TextStyle(
                        fontFamily: "harabaraBold",
                        fontSize: 44,
                        color: Colors.white),
                  ),
                  const Text(
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    "Enjoy Shopping",
                    style: TextStyle(
                        fontFamily: "harabaraBold",
                        fontSize: 24,
                        color: Colors.white),
                  )
                ],
              ),
            ],
          )
          // END [TEXT]
        ],
      ),
    );
  }
}

class MyLoadingScreenToHome extends StatefulWidget {
  final String title;
  // ignore: prefer_const_constructors_in_immutables
  MyLoadingScreenToHome({Key? key, required this.title}) : super(key: key);

  @override
  _MyLoadingScreenToHomeState createState() => _MyLoadingScreenToHomeState();
}

class _MyLoadingScreenToHomeState extends State<MyLoadingScreenToHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  // fastuserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? name = prefs.getString('userName');
  //   final String? email = prefs.getString('userEmail');
  //   setState(() {
  //     userName = name!;
  //     userEmail = email!;
  //     labelName = name;
  //   });
  // }

  getUseInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');

    GetHome data = await homeInfo(id!);
    GetMsg msg = await userImg(id);
    final response = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[CardController]/GetAllUserCard?userId=${id.toString()}'));
    final response2 = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[InvoiceHistory]/GetInvoicesData?useId=${id.toString()}'));
    setState(() {
      userName = data.userName!;
      userEmail = data.userEmail!;
      labelName = data.userName!;
      userId = id;
      base = msg.message!;
      cardList = json.decode(response.body);
      invoicesList = json.decode(response2.body);
    });
  }

  @override
  void initState() {
    if (widget.title != "Creating Account...") {
      // fastuserInfo();
      getUseInfo();
    }
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Create a curved animation
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _animationController.forward();

    // Wait for 1 second, then navigate to the new page
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textScaleFactor: 1,
            widget.title,
            style: const TextStyle(
              color: myDarkGreen,
              fontFamily: "harabaraBold",
              fontSize: 32.0,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    color: myDarkGreen,
                    value: _animation.value,
                    strokeWidth: 10,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
