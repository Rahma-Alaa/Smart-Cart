import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/presentation/screens/sign_in.dart';
import '../../core/constants/constant.dart';
import '../screens/cart_produt.dart';
import '../screens/homeScreen.dart';

Future<void> logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('isSign', 0);
}

Future<void> saveUserCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('id', 0);
  await prefs.setString('userName', "");
  await prefs.setString('userEmail', "");
}

Future openDialog(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext contex) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        content: Container(
          height: 125,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/logout.svg",
                    color: const Color(0xff444444),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    textScaleFactor: 1,
                    "SignOut",
                    style: TextStyle(
                        fontFamily: "harabaraBold",
                        fontSize: 18,
                        color: Color(0xff444444)),
                  ),
                ],
              ),
              const Text(
                textScaleFactor: 1,
                "Are you sure want to SignOut ?",
                style: TextStyle(
                    fontFamily: "harabara",
                    fontSize: 16,
                    color: Color(0xff666666)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() => Navigator.of(context, rootNavigator: true)
                        .pop('dialog')),
                    child: Container(
                      height: 36,
                      width: 84,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xff888888)),
                          color: Colors.white),
                      child: const Center(
                        child: Text(
                          textScaleFactor: 1,
                          "Cancel",
                          style: TextStyle(
                              fontFamily: "harabaraBold",
                              fontSize: 16,
                              color: Color(0xff888888)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      logOut();
                      // saveUserCredentials();
                      cardList.clear();
                      productList.clear();
                      invoicesList.clear();
                      userName = " ";
                      userEmail = " ";
                      userId = 0;
                      base = "";
                      labelName = "";
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ));
                    },
                    child: Container(
                      height: 36,
                      width: 84,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: myDarkGreen),
                      child: const Center(
                        child: Text(
                          textScaleFactor: 1,
                          "SignOut",
                          style: TextStyle(
                              fontFamily: "harabaraBold",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
