import 'dart:math';
import 'package:flutter/material.dart';

class SilverAppbar extends StatelessWidget {
  const SilverAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  final rnd = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            title: Text(
              'SliverAppBar',
            ),
            centerTitle: true,
            expandedHeight: 150.0,
            flexibleSpace: Image.network(
                "https://weloversize.com/wp-content/uploads/2020/08/shutterstock_1805348128.jpg",
                fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
