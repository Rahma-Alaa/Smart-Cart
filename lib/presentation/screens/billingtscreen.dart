import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/presentation/screens/addcard.dart';
import '../widgets/billingwidget.dart';
import '../widgets/customAppBar.dart';
import 'emptycard.dart';

import 'homeScreen.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  int userId = 0;
  bool clicked = false;
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
      body: CustomAppBar(
        title: 'Billing Setting',
        child: Column(
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
                        return Column(
                          children: [
                            BillingWidget(
                              state: cardList[index]["cardNameHolder"],
                              cardnumber: cardList[index]["cardNumber"]
                                  .toString()
                                  .substring(
                                      cardList[index]["cardNumber"].length - 4),
                              cardId:
                                  cardList[index]["paymentCardId"].toString(),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        );
                      },
                    )
                  : const EmptyCard(),
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
                      setState(() {
                        clicked = true;
                      });
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AddCard(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: clicked
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/credit_card.svg'),
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
      ),
    );
  }
}
