import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks_series/hooks_demo_1/start_1.dart';
import 'package:flutter_hooks_series/hooks_demo_2/start_2.dart';
import 'package:flutter_hooks_series/hooks_demo_3/start_3.dart';
import 'package:flutter_hooks_series/hooks_demo_4/start_4.dart';
import 'package:flutter_hooks_series/hooks_demo_5/start_5.dart';
import 'package:flutter_hooks_series/hooks_demo_6/start_6.dart';

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
      body: ListView.separated(
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
        separatorBuilder: (context, index) => const Divider(
          thickness: 5,
        ),
      ),
    );
  }
}

Map<Widget, String> _demos = {
  const HooksDemo1():
      "Demo 1: useStream, consuming a stream without the need for a stream builder",
  const HooksDemo2():
      "Demo 2: useState and useEffect to update Text Widget using a text field without using a statefull widget ",
  const HooksDemo3():
      "Demo 3: loading image into memory asyncronously without making use of a Future.builder",
  const HooksDemo4():
      "Demo 4: useListenable a hook tied to a listenable that triggers the rebuild of the widget whenver the value of the listenable changes",
  const HooksDemo5():
      "Demo 5: using useAnimationController  and useScrollontroller",
  const HooksDemo6(): "useStreamController"
};
