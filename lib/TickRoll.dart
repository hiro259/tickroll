import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TickRoll extends StatefulWidget {
  TickRoll(this.rolltitle);
  @override
  State<TickRoll> createState() => _TickRoll(rolltitle);
  final String rolltitle;
}

class TickData {
  String title;
  bool value;
  bool istitleEditing;
  bool isdetailEditing;
  String detail;
  TextEditingController titleController;
  TextEditingController detailController;

  TickData({
    required this.title,
    required this.value,
    required this.detail,
    required this.istitleEditing,
    required this.isdetailEditing,
    required this.titleController,
    required this.detailController,
  });
}

class _TickRoll extends State<TickRoll> {
  List<TickData> TickDataList = [];
  String rolltitle;

  _TickRoll(this.rolltitle) {
    TickDataList.add(TickData(
        title: '水を飲む2',
        value: false,
        detail: '水分補給は大事だよ！',
        istitleEditing: false,
        isdetailEditing: false,
        titleController: TextEditingController(text: '水を飲む2'),
        detailController: TextEditingController(text: '水分補給は大事だよ！')));
    TickDataList.add(TickData(
        title: '布団をたたむ2',
        value: false,
        detail: '邪魔だからね！',
        istitleEditing: false,
        isdetailEditing: false,
        titleController: TextEditingController(text: '布団をたたむ2'),
        detailController: TextEditingController(text: '邪魔だからね！')));
    TickDataList.add(TickData(
        title: '大葉に水をやる2',
        value: false,
        detail: '枯れちゃうよ',
        istitleEditing: false,
        isdetailEditing: false,
        titleController: TextEditingController(text: '大葉に水をやる2'),
        detailController: TextEditingController(text: '枯れちゃうよ')));
  }

  void EdidingTextfieldfalse() {
    TickDataList.forEach((item) {
      item.istitleEditing = false;
    });
    TickDataList.forEach((item) {
      item.isdetailEditing = false;
    });
  }

  @override
  void dispose() {
    TickDataList.forEach((item) {
      item.titleController.dispose();
      item.detailController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(rolltitle),
        actions: [
          PopupMenuButton(
              onOpened: () {
                print('onOpned');
                setState(() {
                  EdidingTextfieldfalse();
                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text('all'),
                        onTap: () {
                          setState(() {
                            TickDataList.forEach((index) {
                              index.value = false;
                            });
                          });
                        }),
                    PopupMenuItem(
                      child: Text('add'),
                      onTap: () {
                        setState(() {
                          TickDataList.add(TickData(
                              title: "",
                              value: false,
                              detail: "",
                              istitleEditing: false,
                              isdetailEditing: false,
                              titleController: TextEditingController(text: ""),
                              detailController:
                                  TextEditingController(text: "")));
                          setState(() {
                            EdidingTextfieldfalse();
                            TickDataList.last.istitleEditing = true;
                          });
                        });
                      },
                    )
                  ])
        ],
      ),
      body: Center(
          child: ListView.builder(
        itemCount: TickDataList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: SwitchListTile(
              title: TickDataList[index].istitleEditing
                  ? TextFormField(
                      controller: TickDataList[index].titleController,
                      onFieldSubmitted: (newTitle) {
                        setState(() {
                          TickDataList[index].istitleEditing = false;
                        });
                        TickDataList[index].title = newTitle;
                      },
                    )
                  : Align(
                      alignment: Alignment.centerLeft, // 左寄せに設定
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0), // クリック範囲を狭める
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              EdidingTextfieldfalse();
                              TickDataList[index].istitleEditing = true;
                            });
                          },
                          child: Text(TickDataList[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                    ),
              subtitle: TickDataList[index].isdetailEditing
                  ? TextFormField(
                      style:
                          TextStyle(fontSize: 12), //detailの大きさのも同じだと不自然に見えるため
                      controller: TickDataList[index].detailController,
                      onFieldSubmitted: (newdetail) {
                        setState(() {
                          TickDataList[index].isdetailEditing = false;
                        });
                        TickDataList[index].detail = newdetail;
                      },
                    )
                  : Align(
                      alignment: Alignment.centerLeft, // 左寄せに設定
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0), // クリック範囲を狭める
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              EdidingTextfieldfalse();
                              TickDataList[index].isdetailEditing = true;
                            });
                          },
                          child: Text(
                            TickDataList[index].detail,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
              value: TickDataList[index].value,
              onChanged: (bool newValue) {
                setState(() {
                  EdidingTextfieldfalse();
                  TickDataList[index].value = newValue;
                });
              },
            ),
            onLongPress: () {
              setState(() {
                EdidingTextfieldfalse();
              });
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
                            TickDataList.removeAt(index);
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
          );
        },
      )),
    );
  }
}
