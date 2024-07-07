import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'crawler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: MainUi()));
  }
}

class MainUi extends StatefulWidget {
  const MainUi({super.key});

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> with TickerProviderStateMixin {
  String bbcurl = "https://www.espn.co.uk/";
  String skyurl = "https://www.marca.com/en/";
  late List bbclist;
  late List skylist;

  List<Widget> tabs = [
    Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('Sky')), Icon(Icons.skateboarding)],
      ),
    ),
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('BBC'), Icon(Icons.snowboarding_rounded)],
      ),
    )
  ];
  int j = 0;
  late TabController controller;
  @override
  void initState() {
    bbclist = [];
    skylist = [];
    // TODO: implement initState
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          bottom: TabBar(
            tabs: tabs,
            controller: controller,
            onTap: (i) async {
              WebCrawler bbccrawler = WebCrawler(bbcurl);
              WebCrawler skycrawler = WebCrawler(skyurl);
              print(bbclist);
              i == 0
                  ? bbclist = await bbccrawler.fetchData()
                  : skylist = await skycrawler.fetchData();
              setState(() {
                j = i;
              });
            },
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) {
            return j == 0
                ? ListTile(
                    leading: Icon(CupertinoIcons.sportscourt_fill),
                    title: Text(bbclist[index]),
                  )
                : ListTile(
                    leading: Icon(CupertinoIcons.sportscourt_fill),
                    title: Text(skylist[index]),
                  );
          },
          itemCount: j == 0 ? bbclist.length : skylist.length,
        )
      ],
    );
  }
}
