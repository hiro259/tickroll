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

class EditItemDialog extends StatefulWidget {
  final String initialTitle;
  final String initialDetail;
  final Function(String, String) onSave;

  const EditItemDialog({
    super.key,
    required this.initialTitle,
    required this.initialDetail,
    required this.onSave,
  });

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _detailController = TextEditingController(text: widget.initialDetail);
  }

  @override
  //メモリ管理用らしい
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _detailController,
            decoration: const InputDecoration(
              labelText: 'Detail',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(
              _titleController.text,
              _detailController.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
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
      TickTitleList.add(TickTitle(title: "", detail: ""));
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditItemDialog(
              initialTitle: TickTitleList.last.title,
              initialDetail: TickTitleList.last.detail,
              onSave: (title, detail) {
                setState(() {
                  TickTitleList.last.title = title;
                  TickTitleList.last.detail = detail;
                });
              });
        });
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
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditItemDialog(
                                  initialTitle: TickTitleList[index].title,
                                  initialDetail: TickTitleList[index].detail,
                                  onSave: (title, detail) {
                                    setState(() {
                                      TickTitleList[index].title = title;
                                      TickTitleList[index].detail = detail;
                                    });
                                  });
                            });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Confirmation'),
                            content: const Text(
                                'Are you sure you want to delete this item?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // ダイアログを閉じる
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    TickTitleList.removeAt(index);
                                  });
                                  Navigator.of(context).pop(); // ダイアログを閉じる
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete),
                  )
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
