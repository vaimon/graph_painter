import 'dart:math';

class FunctionsHelper {
  static List<Function(double)> functions = [
  (double x) => sin(x),
  (double x) => pow(x, 2),
  (double x) => pow(x,3),
  (double x) => cos(x),
  ];

  static List<String> functionNames = [
    "sin(x)",
    "x^2",
    "x^3",
    "cos(x)"
  ];
}

class WorldState {
  static Function(double) function = FunctionsHelper.functions[0];
  static double size = 100;
}