// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/repository/post_card.dart';
import '../widgets/customAppBar.dart';
import 'billingtscreen.dart';
import 'homeScreen.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (oldValue.text.length >= text.length) {
      return newValue;
    }

    if (text.length == 2) {
      final newText = '$text/';
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}

class _AddCardState extends State<AddCard> {
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirtationDateController =
      TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomAppBar(
        title: "Add New Card",
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                Center(
                  child: Image.asset(
                    "assets/gifs/newCard.gif", // GIF
                    height: 280,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: 400,
                height: 48,
                child: TextFormField(
                  controller: _cardHolderController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                      fontFamily: "harabaraBold",
                      color: Color(0xff333333),
                      fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Card Holder Name',
                    labelStyle: const TextStyle(
                        fontFamily: "harabaraBold",
                        color: Color(0xff2C6976),
                        fontSize: 18),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset("assets/icons/cardName.svg"),
                        const SizedBox(
                          width: 14,
                        )
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: 400,
                height: 48,
                child: TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  // validator: CardUtils.validateCardNum,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                  ],
                  style: const TextStyle(
                      fontFamily: "harabaraBold",
                      color: Color(0xff333333),
                      fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: const TextStyle(
                        fontFamily: "harabaraBold",
                        color: Color(0xff2C6976),
                        fontSize: 18),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset("assets/icons/cardNumber.svg"),
                        const SizedBox(
                          width: 14,
                        )
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: 400,
                height: 48,
                child: TextFormField(
                  controller: _expirtationDateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ExpiryDateFormatter(),
                    LengthLimitingTextInputFormatter(5),
                  ],
                  //obscureText: NumberInputElement.supported,
                  style: const TextStyle(
                      fontFamily: "harabaraBold",
                      color: Color(0xff333333),
                      fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Expriration Date',
                    hintText: "MM/YY",
                    labelStyle: const TextStyle(
                        fontFamily: "harabaraBold",
                        color: Color(0xff2C6976),
                        fontSize: 18),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset("assets/icons/date.svg"),
                        const SizedBox(
                          width: 14,
                        )
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: SizedBox(
                width: 400,
                height: 48,
                child: TextFormField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  style: const TextStyle(
                      fontFamily: "harabaraBold",
                      color: Color(0xff333333),
                      fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    labelStyle: const TextStyle(
                        fontFamily: "harabaraBold",
                        color: Color(0xff2C6976),
                        fontSize: 18),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset("assets/icons/cvv.svg"),
                        const SizedBox(
                          width: 14,
                        )
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1.0,
                            color: Color.fromARGB(255, 44, 105, 118)),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
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
                    onPressed: () async {
                      setState(() {
                        clicked = true;
                      });
                      createCard(
                          _cardHolderController.text.toString(),
                          _cardNumberController.text.toString(),
                          _expirtationDateController.text.toString(),
                          _cvvController.text.toString(),
                          userId.toString());
                      await Future.delayed(const Duration(seconds: 1));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const BillingScreen(),
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
