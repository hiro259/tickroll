import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicRoll',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TickRoll'),
    );
  }
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TickData> TickDataList = [];

  _MyHomePageState() {
    print('MyHomePageState Start');
    TickDataList.add(
        TickData(title: '水を飲む', value: false, detail: '水分補給は大事だよ！'));
    TickDataList.add(
        TickData(title: '布団をたたむ', value: false, detail: '邪魔だからね！'));
    TickDataList.add(
        TickData(title: '大葉に水をやる', value: false, detail: '枯れちゃうよ'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
