import 'package:flutter/material.dart';

import 'billingtscreen.dart';

class EmptyCard extends StatefulWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/gifs/Credit_card.gif", // GIF
              height: 280,
            ),
          ),
          const SizedBox(
            height: 50.0,
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
                      builder: (context) => const BillingScreen(),
                    ));
                  },
                  child: clicked
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            textScaleFactor: 1,
                            'ReLoad...',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "harabaraBold",
                              fontSize: 20.0,
                            ),
                          ),
                        )),
            ),
          ),
          const SizedBox(
            height: 28.0,
          ),
          const Text(
            textScaleFactor: 1,
            "There are no cards. \nplease add a card",
            style: TextStyle(
                fontFamily: "harabaraBold",
                fontSize: 24,
                color: Color(0xff2C6976)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 28.0,
          ),
        ],
      ),
    );
  }
}
