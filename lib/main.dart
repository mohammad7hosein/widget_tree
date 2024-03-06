import 'dart:math';

import 'package:flutter/material.dart';

import 'box_around_text.dart';
import 'circle_dots_widget.dart';
import 'circle_layout_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.purpleAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.pinkAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Widget Tree'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),

          /*******   CircleLayoutWidget   *******/
          child: CircleLayoutWidget(
            children: [
              for (int i = 0; i < 50; i++)
                Container(
                  width: 50,
                  height: 50,
                  color: colors[Random().nextInt(colors.length)],
                )
            ],
          ),

          /*******   CircleDotsWidget   *******/
          // child: const CircleDotsWidget(numberOfDots: 5),

          /*******   BoxAroundText   *******/
          // child: const BoxAroundText(
          //   padding: 20,
          //   text: Text('Hello, World! dhfhqae rth rwhwthwrhwrthwrtrhwrgfhgshghshbgnbfgn'),
          // ),
        ),
      ),
    );
  }
}
