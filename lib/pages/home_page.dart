import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:diofluttercep/pages/history_page.dart';
import 'package:diofluttercep/pages/search_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController(initialPage: 0);
  int page = 0;

  void handlePageChange(int value) {
    setState(() {
      page = value;
    });
  }

  void handleNavigationClick(int value) {
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: handlePageChange,
            children: const [
              SearchPage(),
              HistoryPage(),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
            items: const [
              TabItem(icon: Icons.search, title: 'Consulta'),
              TabItem(icon: Icons.history, title: 'Histórico'),
            ],
            onTap: handleNavigationClick,
          )),
    );
  }
}
