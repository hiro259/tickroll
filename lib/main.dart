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

    //Title用Textfiledの文字列変更用のcontrollerの追加
    _titleControllers
        .add(TextEditingController(text: TickTitleList.last.title));
    //detail用Textfiledの文字列変更用のcontrollerの追加
    _detailControllers
        .add(TextEditingController(text: TickTitleList.last.detail));
  }

  _MyHomePageState() {
    print('MyHomePageState Start');
    TickTitleList.add(TickTitle(title: '朝リスト', detail: '起きてやること'));
    TickTitleList.add(TickTitle(title: '昼リスト', detail: 'ランチ後にやること'));
    TickTitleList.add(TickTitle(title: '夜リスト', detail: '寝る前にやること'));
  }

  final _titleControllers = <TextEditingController>[];
  final _detailControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    // TextEditingControllerの初期化
    for (final item in TickTitleList) {
      _titleControllers.add(TextEditingController(text: item.title));
      _detailControllers.add(TextEditingController(text: item.detail));
    }
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
            title: TextField(
              controller: _titleControllers[index],
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                TickTitleList[index].title = value;
              },
            ),
            subtitle: TextField(
              controller: _detailControllers[index],
              decoration: InputDecoration(labelText: 'detail'),
              onChanged: (value) {
                TickTitleList[index].detail = value;
              },
            ),
          ));
        },
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addTickTile();
            setState(() {});
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add)),
    );
  }
}
