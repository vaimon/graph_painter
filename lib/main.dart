import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graph_painter/constants.dart';
import 'package:graph_painter/function_settings.dart';
import 'package:graph_painter/painter.dart';
import 'package:graph_painter/range_settings.dart';
import 'package:graph_painter/size_settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Function(double) function;
  double size;
  Range range;
  Range extremums;

  setSize(double newSize) {
    setState(() {
      size = newSize;
    });
  }

  setFunction(Function(double) newFunction, Range newExtremums) {
    setState(() {
      function = newFunction;
      extremums = newExtremums;
      size = 100;
    });
  }

  setRange(Range newRange) {
    setState(() {
      range = newRange;
      size = 100;
    });
  }

  @override
  void initState() {
    size = 100;
    function = FunctionsHelper.functions[0];
    extremums = FunctionsHelper.functionExtremums[0];
    range = Range(double.negativeInfinity, double.infinity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лучше, чем матлаб',
      builder: (context, child) {
        return child;
      },
      home: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: GraphPainter(function,extremums, size, range),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FunctionSettings(
                        functionCallback: setFunction,
                      ),
                      RangeSettings(
                        settingCallback: setRange,
                      ),
                      SizeSettings(
                        settingCallback: setSize,
                        size: size,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
