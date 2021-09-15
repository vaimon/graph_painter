import 'dart:math';

class FunctionsHelper {
  static List<Function(double)> functions = [
    (double x) => sin(x),
    (double x) => pow(x, 2),
    (double x) => pow(x, 3),
    (double x) => cos(x),
  ];

  static List<String> functionNames = ["sin(x)", "x^2", "x^3", "cos(x)"];

  static List<Range> functionExtremums = [
    Range(-1, 1),
    Range(0, double.infinity),
    Range(double.negativeInfinity, double.infinity),
    Range(-1, 1)
  ];
}

class Range {
  double start, end;

  Range(this.start, this.end);

  bool isInRange(double x) {
    return x >= start && x <= end;
  }

  bool isInfinite(){
    return start == double.negativeInfinity || end == double.infinity;
  }
}
