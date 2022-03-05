// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable, avoid_unnecessary_containers
import 'package:budget_sheet/componants/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:sqlite_jornals_test/budget.dart';
import 'package:budget_sheet/database.dart';
import 'package:budget_sheet/edit_page.dart';
import 'package:budget_sheet/home.dart';

import 'constants.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  // ignore: non_constant_identifier_names
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
    print('this from details page $iconRefrence');

    return iconRefrence;
  }

  String icon_ref = '';
  DateTime selectedDate = DateTime.now();
  String str_date = '';
  // ignore: non_constant_identifier_names
  TextEditingController price_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController note_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> budgetList = [];
  int price = 0;
  String note = '';
  // ignore: non_constant_identifier_names
  // Icon default_icon = Icon(Icons.access_alarm_outlined);
  DateTime date = DateTime.now().toLocal();

  /*List<IconData> myIcons = [
    Icons.shopping_bag,
    Icons.restaurant,
    Icons.house,
    Icons.wallet_giftcard,
    Icons.fitness_center,
    Icons.phone,
    Icons.car_repair,
  ];*/
//  IconData icon1 = Icons.shopping_bag;

  // ignore: non_constant_identifier_names
  IconData item_picked = Icons.shopping_bag;
  // static const orangeColor= Colors.orangeAccent[400];
  int index = 0;
  //static const primeColor = Color(0XFF332C39);
  //static const accentColor = Color(0xFFf55951);
  // static const primColor = Color(0xFF2D3043);
  //static const hintStyle = TextStyle(color: Color(0xFFedd2cb));
  //static const labelText =
  //  TextStyle(color: accentColor, fontSize: 20, fontWeight: FontWeight.bold);

  void refresh() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      budgetList = data;
    });
  }

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

  @override
  void initState() {
    super.initState();
    refresh();
  }

  // ignore: non_constant_identifier_names
  void addBudget(price, note, iconInd, str_date) async {
    await DatabaseHelper.creatItem(
        price, note, iconToStrg(item_picked), str_date);
    refresh();
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
  void reset() {
    price = 0;
    note = '';
    date = DateTime.now();
    price_controller.text = '';
    note_controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primeColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primeColor,
        iconTheme: IconThemeData(color: accentColor),
      ),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              style: EditPage.style_text2,
              controller: price_controller,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                price = int.parse(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: 'Please Enter Valid Number',
                errorStyle: hintStyle,
                hintText: 'Enter Price',
                hintStyle: hintStyle,
                label: Text(
                  'Enter Your Price',
                  style: hintStyle,
                ),
              ),
            ),
            TextField(
              style: EditPage.style_text2,
              controller: note_controller,
              onChanged: (value) => note = value,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: lightColor),
                ),
                //// focusColor: Colors.white,
                hintText: 'Enter Note',
                hintStyle: hintStyle,
                label: Text('Enter Your Note', style: hintStyle),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: labelText,
                ),
                // ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  onPressed: () {
                    _datePicked(context);
                  },
                  child: Text(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: lightColor),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('Choose Icon', style: labelText),
              SizedBox(
                width: 10,
              ),
              Container(
                  child: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                                  actions: [buildPicker()],
                                ));
                        // setState(() {
                        icon_ref = iconToStrg(item_picked);
                        // });
                      },
                      child: Icon(
                        item_picked,
                        size: 50,
                        color: lightColor,
                      ))),
            ]),
            /* Button(
                onPressed: () {
                  icon_ref = iconToStrg(item_picked);
                  refresh();
                  // ignore: avoid_print
                  print(icon_ref);
                  if (price != 0 && note != '') {
                    str_date = selectedDate.toString().split(' ')[0];
                    print('this is selected date $selectedDate');
                    print('this is string date $str_date');

                    addBudget(price, note, icon_ref, str_date.split(' ')[0]);
                    reset();
                    final addSnackbar = SnackBar(
                      content: Text('Budget Has Been Added'),
                      backgroundColor: accentColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(addSnackbar);
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(budgetList: budgetList)));
                    });
                    //  reset();
                  } /*else {
                    final addSnackbar = SnackBar(
                      content: Text('Please Complete All Fields'),
                      backgroundColor: accentColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(addSnackbar);
                    // Future.delayed(Duration(seconds: 2), () {
                    //   print('');
                    //  });
                  }*/
                },
                text: 'ADD')*/
            // SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2, color: lightColor),
                  fixedSize: const Size(150, 50),
                  primary: primeColor,
                  onPrimary: lightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  icon_ref = iconToStrg(item_picked);
                  refresh();
                  // ignore: avoid_print
                  print(icon_ref);
                  if (price != 0 && note != '') {
                    str_date = selectedDate.toString().split(' ')[0];
                    print('this is selected date $selectedDate');
                    print('this is string date $str_date');

                    addBudget(price, note, icon_ref, str_date.split(' ')[0]);
                    reset();
                    final addSnackbar = SnackBar(
                      content: Text('Budget Has Been Added'),
                      backgroundColor: accentColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(addSnackbar);
                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(budgetList: budgetList)));
                    });
                    //  reset();
                  } else {
                    final addSnackbar = SnackBar(
                      content: Text('Please Complete All Fields'),
                      backgroundColor: accentColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(addSnackbar);
                    Future.delayed(Duration(seconds: 2), () {
                      print('');
                    });
                  }
                },
                child: Text(
                  'Add ',
                  style: TextStyle(fontSize: 18, letterSpacing: 2),
                ))
            //GestureDetector(
            //  child:Text('ADD')
            //  )
          ],
        ),
      ),
    );
  }
}
