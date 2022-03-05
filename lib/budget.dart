//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Budget {
  // ignore: prefer_const_constructors
  late Icon slectedIcon = Icon(Icons.access_alarm_outlined);
  DateTime selectedDate = DateTime.now();
  String note = '';
  int price = 0;
  Budget(this.price, this.note, this.selectedDate, this.slectedIcon);
  /*List<Object> budgetList = [
    {
      'price': price,
      'note': '',
      'selectedDate': DateTime.now,
      'icon_budget': slectedIcon
    }
  ];*/
}
