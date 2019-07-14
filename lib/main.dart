import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  var selectedSlide;

  List allSlids = [
    {'SlideName': 'Slideone', 'selected': false},
    {'SlideName': 'SlideTow', 'selected': false},
    {'SlideName': 'SlideThree', 'selected': false},
    {'SlideName': 'SlideFour', 'selected': false},
    {'SlideName': 'SlideFive', 'selected': false},
    {'SlideName': 'SlideSix', 'selected': false},
    {'SlideName': 'SlideSiven', 'selected': false},
    {'SlideName': 'SlideEight', 'selected': false},
    {'SlideName': 'SlideNine', 'selected': false},
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(changeSelector);
    setState(() {
      selectedSlide = allSlids[0];
      selectedSlide['selected'] = true;
    });
    super.initState();
  }

  changeSelector() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    var divisor = maxScroll / allSlids.length + 20;
    var scrollValue = _scrollController.offset.round();
    var slideSelected = (scrollValue / divisor).round();

    var currentSlide = allSlids.indexWhere((element) => element['selected']);

    setState(() {
      allSlids[currentSlide]['selected'] = false;

      selectedSlide = allSlids[slideSelected];
      selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Effects"),
      ),
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ListView(
              children: allSlids.map((slide) {
                return getTitle(slide);
              }).toList(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .58,
            child: ListView(
              controller: _scrollController,
              children: allSlids.map((slide) {
                return getCard(slide);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitle(slide) {
    return InkWell(
      onTap: () {
        var currentSlide = allSlids.indexWhere(
            (element) => element['SlideName'] == slide['SlideName']);
        var maxScroll = _scrollController.position.maxScrollExtent;
        var divisor = maxScroll / allSlids.length + 20;
        var scrollValue = currentSlide * divisor;

        _scrollController.animateTo(scrollValue,curve: Curves.easeIn,duration: Duration(microseconds: 500));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          slide['SlideName'],
          style: TextStyle(
              fontWeight:
                  slide['selected'] ? FontWeight.bold : FontWeight.normal,
              fontSize: 17),
        ),
      ),
    );
  }

  Widget getCard(slide) {
    return Padding(
      padding: EdgeInsets.only(top: 15, right: 10),
      child: Container(
        height: 200,
        width: 125,
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue, style: BorderStyle.solid, width: 1),
        ),
        child: Center(
          child: Text(
            slide['SlideName'],
            style: TextStyle(
                fontWeight:
                    slide['selected'] ? FontWeight.bold : FontWeight.normal,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
