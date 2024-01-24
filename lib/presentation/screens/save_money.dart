import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/data/repository/save_money.dart';
import '../../core/constants/constant.dart';
import '../widgets/customAppBar2.dart';
import '../widgets/label.dart';
import 'cart_produt.dart';

class SaveMoney extends StatefulWidget {
  const SaveMoney({super.key});

  @override
  State<SaveMoney> createState() => _SaveMoneyState();
}

class _SaveMoneyState extends State<SaveMoney> {
  int userId = 0;

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');

    setState(() {
      userId = id!;
    });
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final moneyText = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomAppBar2(
        title: 'Save Money',
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/gifs/savingMoney.gif",
            height: (kIsWeb) ? MediaQuery.of(context).size.height / 2.5 : 250,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            textScaleFactor: 1,
            "Conserve your money by \nsetting a purchase value so \nthat you do not exceed it",
            style: TextStyle(fontFamily: "harabaraBold", fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          Label(
            labelText: "Money Value",
            icon: "moneyBag",
            controller: moneyText,
            height: 48,
            width: 280,
            keyboardType: TextInputType.number,
            obscureText: false,
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setMoney("0", userId.toString());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CartProduct1(),
                  ));
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 9, 16, 9),
                    decoration: BoxDecoration(
                        border: Border.all(color: myLightGray),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      textScaleFactor: 1,
                      "Deactive",
                      style: TextStyle(
                          fontFamily: "harabaraBold",
                          fontSize: 20,
                          color: myLightGray),
                    ))),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // print("++++${moneyText.text.toString()}++++++");
                  // print("++++${userId.toString()}++++++");
                  setMoney(moneyText.text.toString(), userId.toString());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CartProduct1(),
                  ));
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 9, 16, 9),
                    decoration: BoxDecoration(
                        color: myDarkGreen,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/next.svg"),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          textScaleFactor: 1,
                          "Set Value",
                          style: TextStyle(
                              fontFamily: "harabaraBold",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ))),
              )
            ],
          )
        ]),
      ),
    );
  }
}
