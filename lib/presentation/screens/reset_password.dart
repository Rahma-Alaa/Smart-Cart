import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smarket/data/repository/put_account_settings_repo.dart';
import '../widgets/label.dart';

import '../../core/constants/constant.dart';
import '../widgets/background.dart';
import 'homeScreen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

final newPassword = TextEditingController();
final rePassword = TextEditingController();

class _ResetPasswordState extends State<ResetPassword> {
  int userId = 0;
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');

    setState(() {
      userId = id!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  bool pass1 = true;
  bool pass2 = true;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return BackGround(
      close: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/gifs/password.gif",
          height: 220,
        ),
        const SizedBox(
          height: 48,
        ),
        const Text(
          textScaleFactor: 1,
          "Reset Your Password",
          style: TextStyle(
              color: myDarkGreen, fontFamily: "harabaraBold", fontSize: 30),
        ),
        const SizedBox(
          height: 36,
        ),
        Label(
          suffixIcon: IconButton(
            icon: Icon(
              pass1 ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                pass1 = !pass1;
              });
            },
          ),
          obscureText: pass1,
          labelText: "New Password",
          icon: "lock",
          controller: newPassword,
          height: 48,
          width: 280,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(
          height: 20,
        ),
        Label(
          suffixIcon: IconButton(
            icon: Icon(
              pass2 ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                pass2 = !pass2;
              });
            },
          ),
          obscureText: pass2,
          labelText: "Re Password",
          icon: "reset",
          controller: rePassword,
          height: 48,
          width: 280,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(
          height: 22,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              clicked = true;
            });
            if (rePassword.text == newPassword.text) {
              putPassword(userId, newPassword.text.toString());
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Home(),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text(textScaleFactor: 1, "Oops, Password does not match"),
              ));
            }
          },
          child: Container(
              width: 220,
              padding: const EdgeInsets.fromLTRB(16, 9, 16, 9),
              decoration: BoxDecoration(
                  color: myDarkGreen, borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: clicked
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          children: [
                            SvgPicture.asset("assets/icons/reset_white.svg"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              textScaleFactor: 1,
                              "Reset Password",
                              style: TextStyle(
                                  fontFamily: "harabaraBold",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ],
                        ))),
        )
      ],
    );
  }
}
