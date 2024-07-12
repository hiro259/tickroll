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
    setState(() {
      TickTitleList.add(TickTitle(
        title: "",
        detail: "",
      ));
    });
  }

  _MyHomePageState() {
    print('MyHomePageState Start');
    TickTitleList.add(TickTitle(
      title: '朝リスト',
      detail: '起きてやること',
    ));

    TickTitleList.add(TickTitle(
      title: '昼リスト',
      detail: 'ランチ後にやること',
    ));

    TickTitleList.add(TickTitle(
      title: '夜リスト',
      detail: '寝る前にやること',
    ));
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
        actions: [],
      ),
      body: ReorderableListView.builder(
          itemCount: TickTitleList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              key: Key('item $index'),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.mp),
                  title: Text(TickTitleList[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  subtitle: Text(TickTitleList[index].detail,
                      style: TextStyle(fontSize: 12)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TickRoll(TickTitleList[index].title)),
                    );
                  },
                  trailing:
                      IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit)),
                  // trailing: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: const Text('Delete Confirmation'),
                  //               content: const Text(
                  //                   'Are you sure you want to delete this item?'),
                  //               actions: <Widget>[
                  //                 TextButton(
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop(); // ダイアログを閉じる
                  //                   },
                  //                   child: const Text('Cancel'),
                  //                 ),
                  //                 TextButton(
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       TickTitleList.removeAt(index);
                  //                     });
                  //                     Navigator.of(context).pop(); // ダイアログを閉じる
                  //                   },
                  //                   child: const Text('OK'),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //       },
                  //       icon: Icon(Icons.delete),
                  //     ),
                  //     IconButton(onPressed: () {}, icon: Icon(Icons.mode_edit))
                  //   ],
                  // ),
                ),
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final item = TickTitleList.removeAt(oldIndex);
              TickTitleList.insert(newIndex, item);
            });
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addTickTile();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add)),
    );
  }
}
