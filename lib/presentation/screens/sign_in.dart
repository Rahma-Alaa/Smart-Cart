// ignore_for_file: use_build_context_synchronously

// import 'package:Smarket/presentation/screens/progress_home.dart';
import 'package:Smarket/presentation/screens/homeScreen.dart';
import 'package:Smarket/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/presentation/screens/create_account.dart';
import '../../data/models/get_home.dart';
import '../../data/models/get_info.dart';
import '../../data/repository/get_home.dart';
import '../../data/repository/get_signin.dart';
import '../widgets/background.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool password = true;
  bool clicked = false;
  Future<void> saveUserCredentials(int? id, String userE) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', "");
    await prefs.setString('userEmail', "");
    await prefs.setInt('id', id!);
    await prefs.setString('userEmail', userE);
    GetHome data = await homeInfo(id);
    await prefs.setString('userName', data.userName!);
    // setState(() {
    //   userName = userE;
    //   userEmail = data.userName!;
    // });
  }

  isSignin() async {
    WidgetsFlutterBinding.ensureInitialized();
    int isSign = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isSign', isSign);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(children: <Widget>[
      Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              "assets/gifs/login.gif", // GIF
              height: 265,
            ),
          ),
        ],
      ),
      Column(
        children: [
          const Text(
            textScaleFactor: 1,
            "Signin",
            style: TextStyle(
                fontFamily: "harabaraBold",
                fontSize: 30,
                color: Color(0xff2C6976)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
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
                    isDense: true,
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
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                obscureText: password,
                style: const TextStyle(
                    fontFamily: "harabaraBold",
                    color: Color(0xff333333),
                    fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Password',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff2c6976),
                ),
                child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        clicked = true;
                      });

                      GetInfo data = await signin(
                        emailController.text.toString(),
                        passwordController.text.toString(),
                      );
                      String? state = data.success;
                      int? id = data.id;

                      if (state == "True") {
                        saveUserCredentials(
                          id,
                          emailController.text.toString(),
                        );

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MyLoadingScreenToHome(
                            title: "Signin...",
                          ),
                        ));
                        isSignin();
                      } else {
                        setState(() {
                          clicked = false;
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              textScaleFactor: 1, "Oops, this process failed"),
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
                              // const SizedBox(
                              //   width: 5.0,
                              // ),
                              SvgPicture.asset(
                                'assets/icons/signin.svg',
                                width: 15,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Text(
                                textScaleFactor: 1,
                                'Signin',
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
          const SizedBox(
            height: 08.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            textScaleFactor: 1,
            'Do you still not have an account?',
            style: TextStyle(
              fontFamily: "harabaraBold",
              color: Color(0xff333333),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const CreateAccount(),
              ));
            },
            child: const Text(
              textScaleFactor: 1,
              'Join Now',
              style: TextStyle(
                fontFamily: "harabaraBold",
                color: Color(0xff5B759C),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      )
      // CONTENT
    ]);
  }
}
