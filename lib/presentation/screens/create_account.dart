// ignore_for_file: use_build_context_synchronously

import 'package:Smarket/presentation/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/get_info.dart';
import '../../data/repository/post_account.dart';
import '../../data/repository/post_card.dart';
import '../widgets/background.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccount();
}

Future<void> saveUserCredentials(int? id, String userN, String userE) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setInt('id', id!);
  await prefs.setString('userName', userN);
  await prefs.setString('userEmail', userE);
}

class _CreateAccount extends State<CreateAccount> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var usernameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool password = true;
  bool clicked = false;
  isSignin() async {
    WidgetsFlutterBinding.ensureInitialized();
    int isSign = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isSign', isSign);
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(close: true, closeScreen: "signin", children: <Widget>[
      Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              "assets/gifs/Signup.gif", // GIF
              height: 265,
            ),
          ),
        ],
      ),
      Column(
        children: [
          const Text(
            textScaleFactor: 1,
            "Create Account",
            style: TextStyle(
                fontFamily: "harabaraBold",
                fontSize: 30,
                color: Color(0xff2C6976)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              width: 280,
              height: 48,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                style: const TextStyle(
                    fontFamily: "harabaraBold",
                    color: Color(0xff333333),
                    fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Name',
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
                      SvgPicture.asset("assets/icons/solid_user.svg"),
                      const SizedBox(
                        width: 14,
                      )
                    ],
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              width: 280,
              height: 48,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: emailController,
                style: const TextStyle(
                    fontFamily: "harabaraBold",
                    color: Color(0xff333333),
                    fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Email',
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
                      SvgPicture.asset("assets/icons/email.svg"),
                      const SizedBox(
                        width: 14,
                      )
                    ],
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SizedBox(
              width: 280,
              height: 48,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                obscureText: password,
                style: const TextStyle(
                    fontFamily: "harabaraBold",
                    color: Color(0xff333333),
                    fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'password',
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
                      SvgPicture.asset("assets/icons/lock.svg"),
                      const SizedBox(
                        width: 14,
                      )
                    ],
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      password ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xff2C6976),
                    ),
                    onPressed: () {
                      setState(() {
                        password = !password;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 44, 105, 118)),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 40,
                  width: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff2c6976),
                  ),
                  child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          clicked = true;
                        });
                        GetInfo data = await createAccount(
                          usernameController.text.toString(),
                          emailController.text.toString(),
                          passwordController.text.toString(),
                        );
                        int? id = data.id;
                        // print("-------------$id--------------");
                        // print("-------------${data.success}--------------");

                        if (data.success == "true") {
                          saveUserCredentials(
                              id,
                              usernameController.text.toString(),
                              emailController.text.toString());
                          userName = usernameController.text.toString();
                          userEmail = emailController.text.toString();
                          labelName = usernameController.text.toString();
                          base = "issues";
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => MyLoadingScreenToHome(
                              title: 'Creating Account...',
                            ),
                          ));
                          createCard(usernameController.text.toString(),
                              "123123123123", "05/25", "123", id.toString());
                          isSignin();
                          // final date = DateTime.now();
                          // final dueDate = date.add(const Duration(days: 7));
                          // List<InvoiceProduct> productListPdf = [];
                          // GetMsg msg = await addInvoice(
                          //     "14",
                          //     "ss1mmctp",
                          //     id.toString(),
                          //     DateFormat.yMd()
                          //         .format(DateTime.now())
                          //         .toString());
                          // // print("+++++++AddInvoice+++++++");

                          // RegExp regExp = RegExp(r'\d+');
                          // Iterable<Match> matches =
                          //     regExp.allMatches(msg.message!);
                          // List<int> invoiceId = matches
                          //     .map((match) => int.parse(match.group(0)!))
                          //     .toList();
                          // productListPdf.add(const InvoiceProduct(
                          //   name: "Indomie",
                          //   detail: "noodles",
                          //   quantity: 2,
                          //   unitPrice: 14,
                          //   size: "regular",
                          // ));
                          // final invoice = Invoice(
                          //   supplier: const Supplier(
                          //     name: 'Smarket App',
                          //     address: 'AIET',
                          //   ),
                          //   customer: const Customer(
                          //     name: 'Smarket Inc.',
                          //     email: 'Smarket@gmail.com',
                          //   ),
                          //   info: InvoiceInfo(
                          //     date: date,
                          //     dueDate: dueDate,
                          //     number: '${DateTime.now().year}',
                          //   ),
                          //   products: productListPdf,
                          // );
                          // // print("+++++++done pdf+++++++");

                          // final pdfFile = await PdfInvoiceApi.generate(invoice);
                          // postPdf(userId.toString(), invoiceId[0].toString(),
                          //     pdfFile);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                textScaleFactor: 1,
                                "Oops, this process failed"),
                          ));
                        }
                      },
                      child: clicked
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/start.svg',
                                  width: 15,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text(
                                  textScaleFactor: 1,
                                  'Create',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "harabaraBold",
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            )),
                ),
              ),
            ),
          ),
        ],
      )
      // CONTENT
    ]);
  }
}
