// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'dart:async';
// import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:Smarket/presentation/screens/save_money.dart';
import 'package:Smarket/presentation/screens/search.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:Smarket/data/repository/save_money.dart';
import 'package:Smarket/presentation/screens/select_card.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../core/constants/constant.dart';
import '../../data/models/customer.dart';
import '../../data/models/get_msg.dart';
import '../../data/models/invoice.dart';
import '../../data/models/supplier.dart';
import '../../data/repository/post_invoice.dart';
import '../../data/repository/post_pic.dart';
import '../../data/repository/put_checkout.dart';
import '../../pdf/pdf_invoice_api.dart';
import '../widgets/market_widget.dart';
import 'homeScreen.dart';
import 'market_empty.dart';

class CartProduct1 extends StatefulWidget {
  const CartProduct1({super.key});
  @override
  CartProduct1State createState() => CartProduct1State();
}

Map<double, String> calculateSimilarity() {
  double similarity = 0;
  Map<double, String> finalMap = {};
  Map<String, int> inputMap = {
    "egg": 3,
    "milk": 5,
    "salt": 1,
    "pepper": 1,
    "butter": 12,
    "cheese": 1,
    "vegetables": 2
  };

  for (var recipe in recipes) {
    double ratio = 0;
    String recipeName = recipe.keys.first;

    Map<String, int> ingredients = recipe.values.first;
    int len = ingredients.length;
    for (var ingredientEntry in ingredients.entries) {
      String ingredientName = ingredientEntry.key;
      int quantity = ingredientEntry.value;

      int value = inputMap[ingredientName] ?? 0;
      if (inputMap.containsKey(ingredientName)) {
        ratio += 100.0 - ((quantity - value) < 0 ? 0 : quantity - value);
        print(quantity);
        print(value);
        print(ratio);
        print(len);
      }
    }
    similarity = ratio / len;
    finalMap[double.parse(similarity.toStringAsFixed(2))] = recipeName;
    print('Recipe: $recipeName');
    print('Similarity: $similarity%');
    print('------------------------');
  }
  List<MapEntry<double, String>> sortedEntries = finalMap.entries.toList()
    ..sort((a, b) => b.key.compareTo(a.key));

  Map<double, String> sortedMap = Map.fromEntries(sortedEntries);
  return sortedMap;
}

List<Map<String, Map<String, int>>> recipes = [
  {
    "cake": {
      "egg": 2,
      "flour": 1,
      "sugar": 1,
      "butter": 1,
      "vanilla extract": 1,
      "baking powder": 1,
      "milk": 1
    }
  },
  {
    "pizza": {
      "flour": 2,
      "yeast": 1,
      "sugar": 1,
      "salt": 1,
      "olive oil": 1,
      "water": 1,
      "tomato sauce": 1,
      "cheese": 2,
      "toppings": 3
    }
  },
  {
    "smoothie": {
      "banana": 2,
      "strawberries": 1,
      "yogurt": 1,
      "milk": 1,
      "honey": 1,
      "ice cubes": 4
    }
  },
  {
    "pancakes": {
      "flour": 1,
      "sugar": 1,
      "baking powder": 1,
      "salt": 1,
      "milk": 1,
      "egg": 1,
      "butter": 1
    }
  },
  {
    "omelette": {
      "egg": 3,
      "milk": 2,
      "salt": 1,
      "pepper": 1,
      "butter": 1,
      "cheese": 1,
      "vegetables": 2
    }
  },
  {
    "salad": {
      "lettuce": 1,
      "tomato": 2,
      "cucumber": 1,
      "onion": 1,
      "bell pepper": 1,
      "olives": 0,
      "feta cheese": 1,
      "olive oil": 1,
      "lemon juice": 1,
      "salt": 1,
      "pepper": 1
    }
  },
  {
    "muffins": {
      "flour": 1,
      "sugar": 1,
      "baking powder": 1,
      "salt": 1,
      "milk": 1,
      "egg": 1,
      "butter": 1
    }
  },
  {
    "stir-fry": {
      "chicken": 1,
      "vegetables": 3,
      "soy sauce": 1,
      "garlic": 2,
      "ginger": 1,
      "cornstarch": 1,
      "sesame oil": 1,
      "salt": 1,
      "pepper": 1
    }
  },
  {
    "pasta": {
      "pasta": 1,
      "tomato sauce": 1,
      "ground beef": 1,
      "onion": 1,
      "garlic": 2,
      "olive oil": 1,
      "salt": 1,
      "pepper": 1,
      "Italian seasoning": 1,
      "parmesan cheese": 1
    }
  }
];

// String money = "0";
List productList = [];
Map<double, String> similarity = {};
int user_id = 0;
String userqr = "";
double sum = 0;
String overLoad = "000False";

class CartProduct1State extends State<CartProduct1> {
  bool clicked = false;
  final dio = Dio();
  saveState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('state', state);
  }

  // void _bottomSheet(BuildContext context) {
  //   Map<double, String> similarity = calculateSimilarity();
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //           child: Column(
  //             children:
  //               for (var similarityW in similarity.entries)
  //                 {Text('${similarityW.key}:${similarityW.value} ')}

  //           ),
  //         );
  //       },
  //       context: context);
  // }

  Future openPop() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/warning.svg",
                  height: 30,
                  width: 30,
                ),
                const Text(
                  textScaleFactor: 1,
                  "Warning!",
                  style: TextStyle(
                    fontFamily: "harabaraBold",
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: 80,
              width: 250,
              child: Column(
                children: const <Widget>[
                  Text(
                    textScaleFactor: 1,
                    "Are you sure you want to leave?",
                    style: TextStyle(
                      fontFamily: "harabara",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textScaleFactor: 1,
                    "If you choose leave you will lose all your data",
                    style: TextStyle(
                      fontFamily: "harabara",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff2c6976),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      textScaleFactor: 1,
                                      "Leave",
                                      style: TextStyle(
                                        fontFamily: "harabaraBold",
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 36,
                          width: 84,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: const Color(0xff888888)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      textScaleFactor: 1,
                                      "Cancle",
                                      style: TextStyle(
                                          fontFamily: "harabaraBold",
                                          fontSize: 16,
                                          color: Color(0xff888888)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
      );
  getProductsList() async {
    // print(
    // 'https://smartcartapplback.azurewebsites.net/Product/GetProductCart?cartId=$userqr&userId=${user_id.toString()}');
    // final response = await http.get(Uri.parse(
    //     'https://smartcartapplback.azurewebsites.net/Product/GetProductCart?cartId=$userqr&userId=${user_id.toString()}'));
    final response = await dio.get(
        'https://smartcartapplback.azurewebsites.net/Product/GetProductCart?cartId=$userqr&userId=${user_id.toString()}');
    // print(response.data);
    // print("+++++response");
    setState(() {
      productList = response.data;
    });
  }

  getOverLoad() async {
    final response2 = await dio.get(
        'https://smartcartapplback.azurewebsites.net/Product/GetCartOverloaded?cartId=$userqr');
    // print("+++++response2 ${response2.data}");
    if (mounted) {
      setState(() {
        overLoad = response2.data["message"];
      });
    }
  }

  getUseId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');
    String? qr = prefs.getString('qr');
    setState(() {
      user_id = id!;
      // print(user_id);
      userqr = qr!;
    });
  }

  Future warninng(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext contex) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 120,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Column(
                      children: const [
                        Center(
                          child: Text(
                            textScaleFactor: 1,
                            "⚠️",
                            style: TextStyle(
                                fontFamily: "harabaraBold",
                                fontSize: 24,
                                color: Color(0xff666666)),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Center(
                          child: Text(
                            textScaleFactor: 1,
                            "\nPlease note that an additional item has been placed in the cart, please remove it to continue shopping.",
                            style: TextStyle(
                                fontFamily: "harabaraBold",
                                fontSize: 14,
                                color: Color(0xff666666)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 36,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: myDarkGreen),
                      child: InkWell(
                        onTap: () {
                          getOverLoad();
                          if (overLoad.contains("False")) {
                            print("+++++");
                            Navigator.pop(contex);
                            initState();
                          }
                        },
                        child: const Center(
                          child: Text(
                            textScaleFactor: 1,
                            "Check Again",
                            style: TextStyle(
                                fontFamily: "harabaraBold",
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // _resetStyle() {
  //   InAppNotifications.instance
  //     ..titleFontSize = 14.0
  //     ..descriptionFontSize = 14.0
  //     ..textColor = Colors.black
  //     ..backgroundColor = Colors.white
  //     ..shadow = true
  //     ..animationStyle = InAppNotificationsAnimationStyle.scale;
  // }
  String recomendationState = "";
  bool pepsiOffer = false;
  bool indomieNew = false;
  double TOP = 0;
  @override
  void initState() {
    pepsiOffer = false;
    indomieNew = false;
    recomendationState = "";
    saveState(false);
    getUseId();
    // print("++++++++++++++$user_id");
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Map<String, dynamic> lastProduct = {};
      getProductsList();
      getOverLoad();
      print(overLoad);
      if (overLoad.contains("True")) {
        warninng(context);
        timer.cancel();
      }
      // print("++++I+++$overLoad");
      // print(productList);
      // getMoney(userId.toString()).then((apiMoney) => money = apiMoney);
      sum = 0;
      for (var product in productList) {
        //TODO
        sum += (product["productId"] == 6 &&
                (int.parse(product["productAmount"]) / 3).floor() >= 1)
            ? int.parse(product["productPrice"]) -
                ((int.parse(product["productAmount"]) / 3).floor())
            : double.parse(product["productPrice"]);
        lastProduct = product;
      }
      if (productList.isEmpty) {
        TOP = 0;
      }
      if (lastProduct["productId"] == 6) {
        recomendationState = "Offer : ";
        TOP = 80;
        // print(recomendationState);
        // if (!pepsiOffer) {
        // print("++++pp+++++");
        // _resetStyle();
        // InAppNotifications.show(
        //     persistent: true,
        //     title: recomendationState,
        //     leading: Row(
        //       children: [
        //         Image.asset(
        //           "assets/products/1.png",
        //           height: 50,
        //         ),
        //         SizedBox(
        //           width: 12,
        //         )
        //       ],
        //     ),
        //     description: recomendationTxt,
        //     onTap: () {});
        // }
        pepsiOffer = true;
        indomieNew = false;
      } else if (lastProduct["productId"] == 0) {
        TOP = 80;
        recomendationState = "New : ";
        // print(recomendationState);
        // if (!indomieNew) {
        // print("++++nnn+++++");
        // _resetStyle();
        // InAppNotifications.show(
        //     persistent: true,
        //     title: recomendationState,
        //     leading: Image.asset(
        //       "assets/products/0.png",
        //       height: 50,
        //     ),
        //     description: recomendationTxt,
        //     onTap: () {});
        // }
        indomieNew = true;
        pepsiOffer = false;
      }
      // print("qr1-----$userqr------");
      // print(productList);
      // print("userId1-----${userId.toString()}------");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 76,
        title: const Text(
          textScaleFactor: 1,
          "Your Cart",
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Home(),
                ));
              },
              child: Row(children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/back.svg",
                  height: 32,
                ),
              ]),
            )
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(22),
        //     child: InkWell(
        //         onTap: () => _bottomSheet(context),
        //         child: SvgPicture.asset("assets/icons/saveMoney.svg")),
        //   )
        // ],
      ),
      body: Stack(
        children: [
          recomendationState != ""
              ? Column(children: <Widget>[
                  const SizedBox(
                    height: 0,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // height: 28,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: recomendationState == "Offer : "
                                    ? const Color.fromARGB(172, 214, 152, 171)
                                    : const Color.fromARGB(172, 76, 175, 79),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Center(
                                  child: Text(
                                    textScaleFactor: 1,
                                    "Recommended $recomendationState",
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 14,
                                        fontFamily: "harabaraBold"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 28,
                              width: MediaQuery.of(context).size.width - 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromARGB(88, 104, 178, 159),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Center(
                                  child: (indomieNew && !pepsiOffer)
                                      ? Row(
                                          children: const [
                                            Flexible(
                                              flex: 30,
                                              child: TextScroll(
                                                "Introducing our mouthwatering noodles, the perfect blend of flavor and convenience for a satisfying meal anytime, anywhere!",
                                                intervalSpaces: 10,
                                                delayBefore:
                                                    Duration(seconds: 1),
                                                style: TextStyle(
                                                    color: myDarkGreen,
                                                    fontSize: 14,
                                                    fontFamily: "harabaraBold"),
                                                velocity: Velocity(
                                                    pixelsPerSecond:
                                                        Offset(50, 0)),
                                              ),
                                            ),
                                            SizedBox(width: 0),
                                            Expanded(
                                              child: SizedBox(),
                                            ),
                                          ],
                                        )
                                      : (pepsiOffer && !indomieNew)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Flexible(
                                                  flex: 30,
                                                  child: TextScroll(
                                                    "Buy 3 Pepsi for 17 L.E instead of 18 L.E.",
                                                    intervalSpaces: 10,
                                                    delayBefore:
                                                        Duration(seconds: 1),
                                                    style: TextStyle(
                                                        color: myDarkGreen,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "harabaraBold"),
                                                    velocity: Velocity(
                                                        pixelsPerSecond:
                                                            Offset(50, 0)),
                                                  ),
                                                ),
                                                SizedBox(width: 0),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: const [
                                                Flexible(
                                                  flex: 30,
                                                  child: TextScroll(
                                                    "Sooon",
                                                    intervalSpaces: 10,
                                                    delayBefore:
                                                        Duration(seconds: 1),
                                                    style: TextStyle(
                                                        color: myDarkGreen,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "harabaraBold"),
                                                    velocity: Velocity(
                                                        pixelsPerSecond:
                                                            Offset(50, 0)),
                                                  ),
                                                ),
                                                SizedBox(width: 0),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                              ],
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ])
              : const SizedBox(
                  height: 0,
                ),
          Padding(
            padding: EdgeInsets.only(top: TOP, bottom: 122),
            child: (productList.isNotEmpty)
                ? ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          MarketWidget(
                            pic: "${productList[index]["productId"]}",
                            productName: "${productList[index]["productName"]}",
                            size: "${productList[index]["productDetail"]}",
                            price: "${productList[index]["productPrice"]}",
                            quantity: "${productList[index]["productAmount"]}",
                          )
                        ],
                      );
                    })
                : const EmptyMarket(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff68B2A0), Color(0xff89B6BF)],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            textScaleFactor: 1,
                            "Sub Total",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "harabaraBold",
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            textScaleFactor: 1,
                            sum.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "harabaraBold",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              if (productList.isNotEmpty) {
                                setState(() {
                                  clicked = true;
                                });
                                saveState(true);
                                // print("+++++++done save+++++++");
                                GetMsg msg = await addInvoice(
                                    sum.toString(),
                                    userqr,
                                    user_id.toString(),
                                    DateFormat.yMd()
                                        .format(DateTime.now())
                                        .toString());
                                // print("+++++++AddInvoice+++++++");
                                RegExp regExp = RegExp(r'\d+');
                                Iterable<Match> matches =
                                    regExp.allMatches(msg.message!);
                                List<int> ivoiceId = matches
                                    .map((match) => int.parse(match.group(0)!))
                                    .toList();
                                // print("++++++++");
                                // print(ivoiceId[0]);
                                final date = DateTime.now();
                                final dueDate =
                                    date.add(const Duration(days: 7));
                                List<InvoiceProduct> productListPdf = [];
                                // print(productList);
                                for (var product in productList) {
                                  productListPdf.add(InvoiceProduct(
                                    name: product["productName"].toString(),
                                    detail: product["productDetail"].toString(),
                                    quantity:
                                        int.parse(product["productAmount"]),
                                    //TODO
                                    unitPrice: (product["productId"] == 6 &&
                                            (int.parse(product[
                                                            "productAmount"]) /
                                                        3)
                                                    .floor() >=
                                                1)
                                        ? int.parse(product["productPrice"]) -
                                            ((int.parse(product[
                                                            "productAmount"]) /
                                                        3)
                                                    .floor()) *
                                                1.0
                                        : double.parse(product["productPrice"]),
                                  ));
                                }
                                final invoice = Invoice(
                                  supplier: const Supplier(
                                    name: 'Smarket App',
                                    address: 'AIET',
                                  ),
                                  customer: const Customer(
                                    name: 'Smarket Inc.',
                                    email: 'Smarket@gmail.com',
                                  ),
                                  info: InvoiceInfo(
                                    date: date,
                                    dueDate: dueDate,
                                    number: '${DateTime.now().year}',
                                  ),
                                  products: productListPdf,
                                );
                                // print("+++++++done pdf+++++++");
                                final pdfFile =
                                    await PdfInvoiceApi.generate(invoice);
                                postPdf(user_id.toString(),
                                    ivoiceId[0].toString(), pdfFile);
                                // print("+++++++post pdf+++++++");
                                putCheckout(user_id, userqr);
                                // print("+++++++Checkout+++++++");
                                // print("++++++$pdfFile++++++");
                                // final imgg =
                                // await PdfConverter.convertToImage(pdfFile.path);
                                // PdfApi.openFile(pdfFile);
                                setState(() {
                                  productList = [];
                                });
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const SelectCard(),
                                ));
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: clicked
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: myDarkGreen,
                                      ),
                                    )
                                  : Row(
                                      children: <Widget>[
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        SvgPicture.asset(
                                            "assets/icons/checkout.svg"),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text(
                                          textScaleFactor: 1,
                                          "Checkout",
                                          style: TextStyle(
                                            fontFamily: "harabaraBold",
                                            fontSize: 20,
                                            color: Color(0xff2c6976),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
