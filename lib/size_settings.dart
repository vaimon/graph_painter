import 'package:flutter/material.dart';
import 'constants.dart';

class SizeSettings extends StatefulWidget {
  final Function(double) settingCallback;

  const SizeSettings({Key key, this.settingCallback}) : super(key: key);
  @override
  _SizeSettingsState createState() => _SizeSettingsState();
}

class _SizeSettingsState extends State<SizeSettings> {
  double currentSize = 100.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 2,
        ),
      ),
      width: 270,
      child: Column(
        children: [
          Text(
            "Масштаб (${currentSize.floor()}%)",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            height: 30,
            width: 200,
            child: Slider(
              value: currentSize,
              activeColor: Color(0xFF900000),
              min: 1,
              max: 150,
              inactiveColor: Color(0x27900000),
              label: currentSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSize = value;
                  widget.settingCallback(value);
                });
              },
            )
          ),
        ],
      ),
    );
  }
}
