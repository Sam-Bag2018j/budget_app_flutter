// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budget_sheet/database.dart';
import 'package:budget_sheet/home.dart';

import 'constants.dart';

class EditPage extends StatefulWidget {
  EditPage(
      {Key? key,
      required this.budegetElement,
      required this.id,
      required this.note,
      required this.icon,
      required this.date,
      required this.price})
      : super(key: key);
  String note;
  String date;
  String icon;
  int price;
  // ignore: prefer_typing_uninitialized_variables
  var budegetElement;
  int id;
  static const style_text2 = TextStyle(
      fontWeight: FontWeight.normal, color: Color(0xFFf1e8e6), fontSize: 22.0);
  //static const lightWhiteColor = Color(0xFFedd2cb);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController price_controller = TextEditingController();
  TextEditingController note_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  TextEditingController icon_controller = TextEditingController();
  List<IconData> myIcons = [
    Icons.shopping_bag,
    Icons.restaurant,
    Icons.house,
    Icons.wallet_giftcard,
    Icons.fitness_center,
    Icons.phone,
    Icons.car_repair
  ];

  String iconToStrg(iconPicked) {
    String iconRefrence = '';
    // print("this is function icon");
    if (iconPicked == Icons.shopping_bag) {
      iconRefrence = '1';
    } else if (iconPicked == Icons.house) {
      iconRefrence = '2';
    } else if (iconPicked == Icons.restaurant) {
      iconRefrence = '3';
    } else if (iconPicked == Icons.wallet_giftcard) {
      iconRefrence = '4';
    } else if (iconPicked == Icons.phone) {
      iconRefrence = '5';
    } else if (iconPicked == Icons.fitness_center) {
      iconRefrence = '6';
    } else if (iconPicked == Icons.car_repair) {
      iconRefrence = '7';
    }
    return iconRefrence;
  }

  IconData toIconIndex(String iconReference) {
    //IconData iconRefrence = Icons.bedroom_baby_rounded;
    IconData? iconResult = Icons.shopping_bag;
    // print("this is function icon");
    if (iconReference == '1') {
      iconResult = Icons.shopping_bag;
    } else if (iconReference == '2') {
      iconResult = Icons.house;
    } else if (iconReference == '3') {
      iconResult = Icons.restaurant;
    } else if (iconReference == '4') {
      iconResult = Icons.wallet_giftcard;
    } else if (iconReference == '5') {
      iconResult = Icons.phone;
    } else if (iconReference == '6') {
      iconResult = Icons.fitness_center;
    } else if (iconReference == '7') {
      iconResult = Icons.car_repair;
    }
    return iconResult;
  }

  DateTime selectedDate = DateTime.now();
  String str_date = '';
  static const primColor = Color(0XFF332C39);

  //str_date = selectedDate.toString().split(' ')[0];
  String icon_ref = '';
  IconData item_picked = Icons.shopping_bag;
  int index = 0;
  // late int? price = 0;
  List budgetList = [];
  void refresh() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      budgetList = data;
    });
  }

  Widget buildPicker() => SizedBox(
        height: 250,
        child: CupertinoPicker(
          itemExtent: 35,
          looping: true,
          children: myIcons
              .map((item) => Center(
                    child: Icon(
                      item,
                      size: 42,
                      color: accentColor,
                    ),
                  ))
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() {
              this.index = index;
              item_picked = myIcons[index];
              // print("my item is...  $item_picked");
            });
          },
        ),
      );

  _datePicked(BuildContext context) async {
    final DateTime? pickedDate = (await showDatePicker(
        context: context,
        lastDate: DateTime(2024),
        firstDate: DateTime(2020),
        // initialDate: selectedDate,
        initialEntryMode: DatePickerEntryMode.input,
        initialDate: selectedDate,
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: ColorScheme.dark(
                      primary: primeColor,
                      onPrimary: accentColor,
                      surface: accentColor,
                      onSurface: lightColor),
                  dialogBackgroundColor: Colors.yellow[50]),
              child: child!,
            )));

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  //static const primeColor = Color(0XFF332C39);
  //static const accentColor = Color(0xFFf55951);
  // static const lightWhiteColor = Color(0xFFedd2cb);
  var color = Colors.red[300];
  late String note;
  late String date;
  late String icon;
  late int price;
  late int id;
  static const hintStyle = TextStyle(color: lightColor);
  static const labelText =
      TextStyle(color: accentColor, fontSize: 20, fontWeight: FontWeight.bold);

  // ignore: prefer_typing_uninitialized_variables
  var budegetElement;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    date = widget.date;
    icon = widget.icon;
    price = widget.price;
    budegetElement = widget.budegetElement;
    id = widget.id;
    selectedDate = DateTime.parse(widget.budegetElement['date']);
    item_picked = toIconIndex(icon);
  }

  Future<void> deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          //  key: _scaffoldKey,
          backgroundColor: primeColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: accentColor),
            backgroundColor: primeColor,
            bottom: TabBar(
              indicatorColor: lightColor,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.edit,
                    color: accentColor,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.delete, color: accentColor),
                )
              ],
            ),
          ),
          //),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 20),
            child: TabBarView(
              children: [
                Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                          style: EditPage.style_text2,
                          controller: price_controller,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightColor)),
                              hintText:
                                  widget.budegetElement['price'].toString(),
                              hintStyle: hintStyle),
                          onChanged: (value) {
                            //   setState(() {
                            price = int.parse(value);
                            // });
                          }),
                      TextField(
                        style: EditPage.style_text2,
                        controller: note_controller,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: lightColor)),
                            hintText: widget.budegetElement['note'],
                            hintStyle: hintStyle),
                        onChanged: (value) {
                          setState(() {
                            note = note_controller.text;
                          });
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Edit Date', style: labelText),

                            // ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton(
                              onPressed: () {
                                _datePicked(context);
                                setState(() {
                                  date = selectedDate.toString().split(' ')[0];
                                });
                              },
                              child: Text(
                                //'${//selectedDate.toLocal()}'.split(' ')[0]
                                '${selectedDate.toLocal()}}'.split(' ')[0],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: lightColor),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Choose Icon ', style: labelText),
                            /*Icon(
                            item_picked,
                            size: 50,
                            color: Colors.orangeAccent,
                          ),*/
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: CupertinoButton(
                                child: Icon(
                                  item_picked,
                                  size: 50,
                                  color: lightColor,
                                ),
                                // ),
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                            actions: [buildPicker()],
                                          ));
                                  // setState(() {
                                  icon_ref = iconToStrg(item_picked);
                                  // });
                                  print(icon_ref);
                                },
                              ),
                            ),
                          ]),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 2, color: lightColor),
                            fixedSize: const Size(150, 50),
                            primary: primeColor,
                            onPrimary: lightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () async {
                            str_date = selectedDate.toString().split(' ')[0];
                            icon_ref = iconToStrg(item_picked);
                            if (widget.budegetElement['price'] != price ||
                                widget.budegetElement['note'] != note ||
                                widget.budegetElement['icon'] != icon_ref ||
                                widget.budegetElement['date'] != date) {
                              await updateItem(widget.id);
                              print(budegetElement['id']);
                              refresh();
                              final snackbarEdit = SnackBar(
                                content: Text('Budget Has Been Edited'),
                                backgroundColor: accentColor,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbarEdit);
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(budgetList: budgetList)));
                              });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(budgetList: budgetList)));
                            }
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: 22, letterSpacing: 2),
                          )),
                    ]),
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('The Price is   ' + price.toString(),
                            style: EditPage.style_text2),
                        Text('The Note is:  ' + note,
                            style: EditPage.style_text2),
                        Text('Chosen Date:   $date',
                            style: EditPage.style_text2),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Chosen Icon:   ',
                                  style: EditPage.style_text2),
                              Icon(
                                item_picked,
                                size: 50,
                                color: lightColor,
                              )
                            ]),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(width: 2, color: lightColor),
                                fixedSize: const Size(150, 50),
                                primary: primeColor,
                                onPrimary: lightColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              deleteItem(id);
                              final snackbar = SnackBar(
                                content: Text('Budget Has Been Deleted'),
                                backgroundColor: accentColor,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(budgetList: [])));
                              });
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(fontSize: 22, letterSpacing: 2),
                            )),
                      ]),
                )
              ],
            ),
          )),
      // ),
    );
  }

  Future<void> updateItem(int id) async {
    id = widget.id;
    await DatabaseHelper.updateItem(widget.id, price, note, icon_ref, str_date);
  }
}
