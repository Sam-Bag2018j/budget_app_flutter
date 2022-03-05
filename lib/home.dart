// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget_sheet/database.dart';
import 'package:budget_sheet/edit_page.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.budgetList});
  // ignore: prefer_typing_uninitialized_variables
  List budgetList = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static const color1 = Color(0x004fbb57);
  // static const kActiveCardColour = Color(0xFF1D1E33);
  //static const color2 = Color(0x00ED6863);
  //static const color3 = Color(0x00EEAC65);
  //static const color4 = Color.fromRGBO(79, 187, 87, 0);

  //static const color1=Color(0x00000004FBB57);
  // static const accentColor = Color(0xFFC28E60);
  static const primColor = Color(0xFF626589);
  static const redColor = Color(0xffD41E00);
  static const orangeColor = Color(0XFFF5631A);
  static const yellowColor = Color(0xFFE1A71D);

  final lightColors = [
    // redColor,
    // orangeColor,
    // Colors.pink.shade400,
    //Colors.purple.shade500,
    // Colors.teal.shade500,
    // Colors.cyan,
    // primColor
    // Colors.green,
    // Colors.red[300],
    //Colors.orange.shade200,
    // Colors.cyan[700],
    // Colors.orange[200],
    // primColor,
    // Colors.yellow[200],
    // accentColor,
    // Colors.red[100],
    // Colors.teal,
    // Colors.white54,
    Color(0xFF68AAA9),
    Color(0XFFDBD4DA),
    Color(0XFFEAC085),
    Color(0XFFB1C7D5),

    //Color(0XFF8BA083),
    // Color.fromARGB(255, 146, 148, 175),
    Color(0xFFF4F0AD),
    Color(0xFF88BF75)
  ];

  TextStyle styleDark(index, double fontNum) {
    var myTextStyle = TextStyle(
        fontSize: fontNum,
        fontWeight: FontWeight.bold,
        color: Color(0xFF183441)); //lightColors[index % lightColors.length]);
    return myTextStyle;
  }

  TextStyle styleLight(double fontNum) {
    var myTextStyle = TextStyle(
        fontSize: fontNum,
        fontWeight: FontWeight.bold,
        color: Colors.white); //lightColors[index % lightColors.length]);
    return myTextStyle;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  //bool isLaoding = true;
  void refresh() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      widget.budgetList = data;
      //  isLaoding = false;
    });
  }

  IconData toIconIndex(String iconReference) {
    //IconData iconRefrence = Icons.bedroom_baby_rounded;
    IconData iconResult = Icons.shopping_bag;
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
    print('this is toiconindex $iconReference');
    return iconResult;
  }

  String priceSign = '\$';

  var appbarColor = Color(0xFF172049);

  @override
  Widget build(BuildContext context) {
    (() {
      refresh();
    });
    return
        //debugShowCheckedModeBanner: false,
        // ignore: duplicate_ignore
        Scaffold(
      backgroundColor: Color(0XFF332C39),
      appBar: AppBar(
          backgroundColor: Color(0XFF332C39),
          leading:
              // actions: [
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailsPage())),
                  icon: Icon(
                    Icons.add,
                    size: 35,
                    color: Color(0xFFf55951),
                  ))
          //],
          ),
      body: widget.budgetList.isEmpty
          ? Center(
              child: Text(
                ' Press \+  To Enter New Budget ',
                style: styleLight(23),
              ),
            )
          : LayoutBuilder(builder: (context, constraints) {
              return GridView.builder(
                  padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                  itemCount: widget.budgetList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //  crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.budgetList[index] != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPage(
                                        budegetElement: widget.budgetList
                                            .elementAt(index)!, // [index],
                                        id: widget.budgetList[index]['id'],
                                        date: widget.budgetList[index]['date'],
                                        icon: widget.budgetList[index]['icon']
                                            .toString(),
                                        note: widget.budgetList[index]['note'],
                                        price: widget.budgetList[index]
                                            ['price'],
                                      )));
                          print(widget.budgetList[index]);
                        } else {
                          Center(
                            child: CircleAvatar(),
                          );
                        }
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(40.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: lightColors[
                                index % lightColors.length] //Color(0xFFDBD4DA),
                            ), //lightColors[index % lightColors.length], //Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$priceSign'
                                        '${widget.budgetList[index]['price']}'
                                    .toString(),
                                overflow: TextOverflow.ellipsis,

                                // softWrap: true,
                                style: styleDark(index, 26),
                              ),
                              Text(widget.budgetList[index]['note'],
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: styleDark(index, 20)
                                  // styleDark(index, 24),
                                  ),
                              Icon(
                                toIconIndex(widget.budgetList[index]['icon']
                                    .toString()),

                                color: Color(0xFF183441), // Colors.black,
                                size: 26,
                                // style: myStyle(index, 17),
                              ),
                              Text(widget.budgetList[index]['date'],
                                  //softWrap: true,
                                  style: styleDark(index, 20)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } //)
              ),
      // ),
    );
  }
}
