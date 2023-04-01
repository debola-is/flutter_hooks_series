import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_series/hooks_demo_1/start_1.dart';
import 'package:flutter_hooks_series/hooks_demo_2/start_2.dart';
import 'package:flutter_hooks_series/hooks_demo_3/start_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _demos.length,
        itemBuilder: (context, index) {
          final Widget page = _demos.keys.toList()[index];
          final String text = _demos[page]!;
          return ListTile(
            title: Text(text),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => page,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Map<Widget, String> _demos = {
  const HooksDemo1(): "Demo 1: useStream",
  const HooksDemo2():
      "Demo 2: useState and useEffect to update Text Widget using a text field without using a statefull widget ",
  const HooksDemo3():
      "Demo 3: loading image into memory asyncronously without making use of a Future.builder",
};
