import 'package:budget_sheet/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:sqlite_jornals_test/home.dart';
import 'intro_page.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final introDate = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introDate.writeIfNull('displayed', false);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: introDate.read('displayed')
          ? HomePage(
              budgetList: [],
            )
          : const IntroPage(),
    );
  }
}
