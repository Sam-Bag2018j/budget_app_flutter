import 'package:budget_sheet/home.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introDate = GetStorage();

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset(
            'assets/pngwing.png',
            width: 150,
          ),
          title: 'Welcom To Budget Sheet',
          body:
              "Budget Sheet is an useful app that helps you to manage and track your budget.",
          footer: const Text(''),
          decoration: PageDecoration(
            pageColor: Colors.yellow[50],
          )),
      PageViewModel(
          image: Image.asset(
            'assets/pngwing.png',
            width: 150,
          ),
          title: ' ',
          body:
              'To get started, click the plus sign at the top to begin and enter your price, note, date and prefer icon then click save and you\'re done.',
          footer: const Text(''),
          // ignore: prefer_const_constructors
          decoration: PageDecoration(
            pageColor: Colors.yellow[50],
          )),
      PageViewModel(
          image: Image.asset(
            'assets/pngwing.png',
            width: 150,
          ),
          title: ' ',
          body:
              'You Can see any sheet\'s detail , edit or delete any sheet by clicking from the list',
          footer: const Text(' '),
          // ignore: prefer_const_constructors
          decoration: PageDecoration(
            pageColor: Colors.yellow[50],
          )),
    ];
  }

  void _endWelcomingPage(context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  budgetList: [],
                )));
    introDate.write('displayed', true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: SafeArea(
        // left: false,
        // top: false,
        // right: false,
        // bottom: false,
        child: IntroductionScreen(
          showDoneButton: true,
          showSkipButton: true,
          showNextButton: true,
          // next: Text('Next',style: TextStyle(height: 20)),
          // skip: Text('Skip',style: TextStyle(height: 20)),
          // done: Text('Done',style: TextStyle(height: 20)),
          next: Text('Next'),
          skip: Text('Skip'),
          done: Text('Done'),
          
          onSkip: () {
            _endWelcomingPage(context);
          },
          onDone: () {
            _endWelcomingPage(context);
          },
          pages: getPages(),
        ),
      ),
    );
  }
}
