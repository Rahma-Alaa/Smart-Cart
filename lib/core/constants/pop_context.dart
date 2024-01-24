import 'package:flutter/material.dart';

class PopContext {
  static BuildContext? _popContext ;

  static void setPopContext(BuildContext newPopContext) {
    _popContext = newPopContext;
  }

  static BuildContext? gePopContexty() {
    return _popContext;
  }
}
