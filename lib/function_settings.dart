import 'dart:async';

import 'package:flutter/material.dart';

import 'constants.dart';

class FunctionSettings extends StatefulWidget {
  final Function(Function(double)) functionCallback;

  const FunctionSettings({Key key, this.functionCallback}) : super(key: key);
  @override
  _FunctionSettingsState createState() => _FunctionSettingsState();
}

class _FunctionSettingsState extends State<FunctionSettings> {

  int selectedGraphFun = 0;

  setSelectedGraph(dynamic val) {
    setState(() {
      widget.functionCallback(FunctionsHelper.functions[val]);
      selectedGraphFun = val;
    });
  }

  List<Container> generateTiles(){
    var res = <Container>[];
    for(int i = 0; i < 4; i++){
      res.add(Container(
        height: 50,
        width: 250,
        child: RadioListTile(
          activeColor: Color(0xFF900000),
          value: i,
          groupValue: selectedGraphFun,
          onChanged: setSelectedGraph,
          title: Text(FunctionsHelper.functionNames[i]),
        ),
      ),);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
        vertical: 10
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: generateTiles()
      ),
    );
  }
}
