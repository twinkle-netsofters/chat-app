import 'package:flutter/material.dart';
class Constant {
  BuildContext context;

  Constant(this.context) : assert (context != null);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}