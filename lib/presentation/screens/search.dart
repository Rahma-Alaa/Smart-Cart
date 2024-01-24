import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScrean extends StatefulWidget {
  const SearchScrean({super.key});

  @override
  SearchScreanState createState() => SearchScreanState();
}

class SearchScreanState extends State<SearchScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 76,
        title: const Text(
          textScaleFactor: 1,
          "Search A Product",
          style: TextStyle(
            color: Color(0xff444444),
            fontFamily: "harabara",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(children: <Widget>[
                SvgPicture.asset("assets/icons/back.svg"),
              ]),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Color(0xff2c6976)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff2c6976)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff2c6976)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        textScaleFactor: 1,
                        ("Search"),
                        style: TextStyle(
                            fontFamily: "harabaraBold",
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.search,
                      color: Color(0xff2c6976),
                    ),
                  ),
                ),
                cursorColor: const Color(0xff2c6976),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
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
                              children: const [
                                Text(
                                  textScaleFactor: 1,
                                  "Milk",
                                  style: TextStyle(
                                    fontFamily: "harabaraBold",
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  textScaleFactor: 1,
                                  "1.5 L",
                                  style: TextStyle(
                                    fontFamily: "harabaraBold",
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  textScaleFactor: 1,
                                  "18 L.E",
                                  style: TextStyle(
                                    fontFamily: "harabaraBold",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                textScaleFactor: 1,
                                "x1",
                                style: TextStyle(
                                  fontFamily: "harabaraBold",
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
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
                          "assets/images/milk.png",
                          height: 80,
                          width: 70,
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
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  textScaleFactor: 1,
                  "Location:",
                  style: TextStyle(
                    fontFamily: "harabaraBold",
                    fontSize: 17,
                  ),
                ),
              ),
              Center(
                child: Text(
                  textScaleFactor: 1,
                  "3A-2F",
                  style: TextStyle(
                    fontFamily: "harabaraBold",
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 18, 30),
            child: Container(
              height: 40,
              width: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff2c6976),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset("assets/icons/mapOn.svg"),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          textScaleFactor: 1,
                          "Show Map",
                          style: TextStyle(
                            fontFamily: "harabaraBold",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
