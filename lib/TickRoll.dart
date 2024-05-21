import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TickRoll extends StatefulWidget {
  @override
  State<TickRoll> createState() => _TickRoll();
}

class TickData {
  String title;
  bool value;
  String detail;

  TickData({
    required this.title,
    required this.value,
    required this.detail,
  });
}

class _TickRoll extends State<TickRoll> {
  List<TickData> TickDataList = [];

  _TickRoll() {
    print('MyHomePageState Start');
    TickDataList.add(
        TickData(title: '水を飲む2', value: false, detail: '水分補給は大事だよ！'));
    TickDataList.add(
        TickData(title: '布団をたたむ2', value: false, detail: '邪魔だからね！'));
    TickDataList.add(
        TickData(title: '大葉に水をやる2', value: false, detail: '枯れちゃうよ'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: TickDataList.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(TickDataList[index].title),
            value: TickDataList[index].value,
            subtitle: Text(TickDataList[index].detail),
            onChanged: (bool newValue) {
              setState(() {
                TickDataList[index].value = newValue;
              });
            },
          );
        },
      )),
    );
  }
}
