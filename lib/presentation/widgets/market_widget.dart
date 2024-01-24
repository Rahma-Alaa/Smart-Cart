import 'package:flutter/material.dart';

class MarketWidget extends StatelessWidget {
  final String pic, productName, size, price, quantity;

  const MarketWidget(
      {super.key,
      required this.pic,
      required this.productName,
      required this.size,
      required this.price,
      required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Center(
            child: Container(
              height: 64,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff68B2A0), Color(0xff89B6BF)],
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textScaleFactor: 1,
                            productName,
                            style: const TextStyle(
                              fontFamily: "harabaraBold",
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            textScaleFactor: 1,
                            size,
                            style: const TextStyle(
                              fontFamily: "harabaraBold",
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //TODO
                          (pic == "6" && (int.parse(quantity) / 3).floor() >= 1)
                              ? Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              8), // this line is optional to make strikethrough effect outside a text
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/line.png'),
                                            fit: BoxFit.contain),
                                      ),
                                      child: Text(
                                        textScaleFactor: 1,
                                        "$price L.E",
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 170, 46, 38),
                                          fontFamily: "harabaraBold",
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      textScaleFactor: 1,
                                      "${int.parse(price) - (int.parse(quantity) / 3).floor()} L.E",
                                      style: const TextStyle(
                                        fontFamily: "harabaraBold",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  textScaleFactor: 1,
                                  "$price L.E",
                                  style: const TextStyle(
                                    fontFamily: "harabaraBold",
                                    fontSize: 12,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          textScaleFactor: 1,
                          "x$quantity",
                          style: const TextStyle(
                            fontFamily: "harabaraBold",
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Image.asset(
                    "assets/products/$pic.png",
                    height: 60,
                    width: 80,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              )
            ],
          )
        ],
      ),
    );
  }
}
