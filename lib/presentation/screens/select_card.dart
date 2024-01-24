import 'dart:async';
import 'dart:convert';

import 'package:Smarket/presentation/screens/emptyselectcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Smarket/presentation/screens/selectaddcard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/constant.dart';
import '../widgets/selectcardwidget.dart';
import '../widgets/thankyou.dart';
import 'package:http/http.dart' as http;

import 'homeScreen.dart';

class SelectCard extends StatefulWidget {
  const SelectCard({super.key});

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');

    setState(() {
      userId = id!;
    });
  }

  getCardsList() async {
    final response = await http.get(Uri.parse(
        'https://smartcartapplback.azurewebsites.net/[CardController]/GetAllUserCard?userId=${userId.toString()}'));
    if (mounted) {
      setState(() {
        if (response.body.isNotEmpty) {
          cardList = json.decode(response.body);
        }
      });
    }
  }

  @override
  void initState() {
    getId();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      getCardsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: (cardList.isNotEmpty)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: cardList.length,
                        padding:
                            const EdgeInsets.only(left: 32, right: 32, top: 24),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              thankYou(context);
                            },
                            child: Column(
                              children: [
                                SelectCardWidget(
                                  state: cardList[index]["cardNameHolder"],
                                  cardnumber: cardList[index]["cardNumber"]
                                      .toString()
                                      .substring(
                                          cardList[index]["cardNumber"].length -
                                              4),
                                  cardId: cardList[index]["paymentCardId"]
                                      .toString(),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const EmptySelectCard(),
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff2c6976),
                  ),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SelectAddCard(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/credit_card.svg'),
                            const SizedBox(
                              width: 12.0,
                            ),
                            const Text(
                              textScaleFactor: 1,
                              'Add Card',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "harabaraBold",
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
              height: 76,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 104,
                  child: const Center(
                    child: Text(
                      textScaleFactor: 1,
                      "Select Card",
                      style: TextStyle(
                          color: myDarkGray,
                          fontFamily: "harabara",
                          fontSize: 20),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
