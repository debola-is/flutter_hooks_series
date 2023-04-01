import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HooksDemo1 extends HookWidget {
  const HooksDemo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The useStream function returns an async snapshot
    // So it no longer requires you to even use a stream builder
    final dateTime = useStream(getTime()).data;
    return Scaffold(
      appBar: AppBar(
        title: Text(dateTime ?? 'Home Page'),
        centerTitle: true,
      ),
    );
  }
}

// Stream function that returns the iso string representation of the current time every second.
Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );

/// To use flutter hooks the consumer widget of your hooks should be
/// of type HookWidget which is in itself a special representation of stateless widgets
/// conventionsally, all your hooks should be named with the
/// prefix "use-" e.g "useHooks"
