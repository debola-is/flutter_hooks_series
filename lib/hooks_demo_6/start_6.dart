import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A simple application that contains an image
///   at the centre of the scaffold with
///     a rotation value of zero.
/// Each time user taps on the image, the rotation value is
///   incremented, and the effect is rendered by hooks

const url = "https://bit.ly/3MeURmF";
const imageHeight = 300.0;

// We'll create a streamcontroller that holds in to our rotation value

class HooksDemo6 extends HookWidget {
  const HooksDemo6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(
      onListen: () {
        // set the default value of our rotation to 0
        controller.sink.add(0.0);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 6'),
        centerTitle: true,
      ),
      body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                onTap: () {
                  controller.sink.add(rotation + 10.0);
                },
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(rotation / 360),
                  child: Center(
                    child: Image.network(url),
                  ),
                ),
              );
            }
          }),
    );
  }
}
