import 'package:flutter/material.dart';
import 'package:tickroll/TickRoll.dart';

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

class TickTitle {
  String title;
  String detail;

  TickTitle({
    required this.title,
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
  List<TickTitle> TickTitleList = [];

  _addTickTile() {
    //実際の空データの追加
    TickTitleList.add(TickTitle(title: "", detail: ""));

    setState(() {});
  }

  _MyHomePageState() {
    print('MyHomePageState Start');
    TickTitleList.add(TickTitle(title: '朝リスト', detail: '起きてやること'));
    TickTitleList.add(TickTitle(title: '昼リスト', detail: 'ランチ後にやること'));
    TickTitleList.add(TickTitle(title: '夜リスト', detail: '寝る前にやること'));
  }

  @override
  void initState() {
    super.initState();
    // TextEditingControllerの初期化
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TickRoll()),
                );
              },
              child: Text('TickRoll')),
        ],
      ),
      body: Center(
          child: ListView.builder(
        itemCount: TickTitleList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(TickTitleList[index].title),
              subtitle: Text(TickTitleList[index].detail),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                ],
              ),
            ),
            // Icon(Icons.book),
            // Icon(Icons.co2),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addTickTile();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add)),
    );
  }
}
