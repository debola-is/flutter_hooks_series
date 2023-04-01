import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// This demo is basically a countdown
/// The actual logic will be in a class
///   CountDown of type ValueNotifier<int>
///
/// We'll be using a new hook called useListenable
///   which does as its name implies - it allows you to consume
///     listenables and calls the build function whenever the value
///       of the listenable changes.
/// Since ValueNotifier  and ChangeNotifier are both listenables
///
/// In this demo, we'll also have to make use of useMemoized
///   to cache our instance of the CountDown class
///     without using it every time the build function is called
///       a new instance of out CountDown class will be created.
/// We don't want this.

class HooksDemo4 extends HookWidget {
  const HooksDemo4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          notifier.value.toString(),
          style: const TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}

/// CountDown class which will be our listenable
///
class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    )
        .takeWhile(
      (value) => value >= 0,
    )
        .listen((value) {
      this.value = value;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
