// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/presentation/screens/invoices_screen.dart';
import 'package:Smarket/presentation/screens/scan_qr.dart';

import '../../core/constants/constant.dart';
import '../screens/cart_produt.dart';
import 'homeBtnClipPath.dart';
import 'homeBtnDecoration.dart';

class HomeBtn extends StatefulWidget {
  final String title, toScreen;

  const HomeBtn({super.key, required this.title, required this.toScreen});

  @override
  State<HomeBtn> createState() => _BtnState();
}

bool userState = true;

class _BtnState extends State<HomeBtn> {
  getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? state = prefs.getBool('state');
    setState(() {
      userState = state ?? true;
    });
  }

  bool clipPath = true;
  double sizeAnimation = 28.0;
  @override
  void initState() {
    getState();
    // print("++++++$userState+++++++");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // START [BTN]
    return GestureDetector(
        onTap: () {
          setState(() {
            clipPath = false;
            sizeAnimation = 0.0;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => (widget.toScreen == "market")
                  ? (userState ? const ScanQRCode() : const CartProduct1())
                  : const InvoicesScreen(),
            ));
          });
        },
        child: SizedBox(
          height: 75,
          width: 175,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // START [GRADIENT BORDER]
              Container(
                height: 73,
                width: 173,
                decoration: outterBox,
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: DecoratedBox(
                    decoration: innerBox,
                  ),
                ),
              ),
              // END [GRADIENT BORDER]
              //_____________
              // START [BTN BODY COLOR]
              Container(
                height: 60,
                width: 160,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              // END [BTN BODY COLOR]
              //_____________
              // START [BTN CLIPPATH]
              ClipPath(
                clipper: (clipPath) ? ClipPathBtn(title: widget.title) : null,
                child: Container(
                  decoration: const BoxDecoration(
                    color: myLightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 60,
                  width: 160,
                ),
              ),
              // END [BTN CLIPPATH]
              //_____________
              // START [BTN BODY CONTENT]
              Container(
                height: 60,
                width: 160,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                child: Center(
                  child: Row(
                    textDirection: (widget.title == "Invoices")
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        (widget.title == "Market")
                            ? "assets/icons/shoppingCartBtn.svg"
                            : "assets/icons/invoice.svg",
                        width: 20,
                        height: (widget.title == "Market") ? 24 : 20,
                        color: Colors.white,
                      ),
                      TweenAnimationBuilder(
                        curve: Curves.linear,
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 28.0, end: sizeAnimation),
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
                          return SizedBox(
                            width: value,
                          );
                        },
                      ),
                      if (clipPath)
                        Text(
                          textScaleFactor: 1,
                          widget.title,
                          style: const TextStyle(
                              fontFamily: "harabaraBlack",
                              fontSize: 20,
                              color: myDarkGray),
                        ),
                    ],
                  ),
                ),
              ),
              // END [BTN BODY CONTENT]
            ],
          ),
        ));
    // END [BTN]
  }
}
