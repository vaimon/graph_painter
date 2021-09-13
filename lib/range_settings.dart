import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class RangeSettings extends StatefulWidget {
  final Function(Range) settingCallback;

  const RangeSettings({Key key, this.settingCallback}) : super(key: key);

  @override
  _RangeSettingsState createState() => _RangeSettingsState();
}

class _RangeSettingsState extends State<RangeSettings> {
  Range currentRange = Range(double.negativeInfinity, double.infinity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
      ),
      width: 270,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Диапазон:",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
              height: 50,
              width: 200,
              child: Row(
                children: [
                  Text("от"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 70,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          var input = double.tryParse(text);
                          currentRange.start = input == null? double.negativeInfinity : input;
                          widget.settingCallback(currentRange);
                        });
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^[+-]?\d*\.?\d{0,2})'))
                      ],
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(10, 1),
                  ),
                  Text("до"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 70,
                    height: 40,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          var input = double.tryParse(text);
                          currentRange.end = input == null? double.infinity : input;
                          widget.settingCallback(currentRange);
                        });
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^[+-]?\d*\.?\d{0,2})'))
                      ],
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
        ],
      ),
    );
  }
}
