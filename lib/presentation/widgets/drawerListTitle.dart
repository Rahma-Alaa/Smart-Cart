// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Smarket/presentation/screens/progress.dart';
import 'package:Smarket/presentation/screens/support.dart';
import 'package:Smarket/presentation/widgets/logout_pop.dart';
import '../../core/constants/constant.dart';
import '../screens/about.dart';
import '../screens/billingtscreen.dart';

class DrawerListTitle extends StatelessWidget {
  final String icon, title, toScreen;
  final bool divider;
  final bool logOut;
  const DrawerListTitle(
      {super.key,
      required this.title,
      required this.icon,
      required this.toScreen,
      this.divider = false,
      this.logOut = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => (logOut
              ? openDialog(context)
              : Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => (toScreen == "about")
                      ? const About()
                      : (toScreen == "support")
                          ? const Support()
                          : (toScreen == "setting")
                              ? const MyLoadingScreen()
                              : const BillingScreen(),
                ))),
          leading: SvgPicture.asset("assets/icons/$icon.svg"),
          title: Text(
              textScaleFactor: 1,
              title,
              style: const TextStyle(
                  fontFamily: "harabaraBold",
                  fontSize: 18,
                  color: myLightGray)),
        ),
        if (divider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(
              thickness: 1,
              color: myLightGray,
            ),
          )
      ],
    );
  }
}
