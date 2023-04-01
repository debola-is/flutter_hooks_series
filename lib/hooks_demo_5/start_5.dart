import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

const url = "https://bit.ly/3MeURmF";
const imageHeight = 300.0;

/// We need to normalize our values
///   this is simply taking a value and expressing it as
///     its equivalent value with the range of 0 - 1

extension Normalize on num {
  // class num is an abstract class that doubles implement
  num normalise(
    num selfRangeMin,
    num selfRangeMax, [
    num normalisedRangeMin = 0.0,
    num normalisedRangeMax = 1.0,
  ]) =>
      (normalisedRangeMax - normalisedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalisedRangeMin;
}

class HooksDemo5 extends HookWidget {
  const HooksDemo5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// We need two animation controllers
    /// We have a hook for this (useAnimationController)
    ///   one for the height of the image
    ///     and the other for the opacity
    /// We also need a scroll controller, conveniently there is
    ///   a hook for this (useScrollController)
    final opacityAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final heightAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    final scrollController = useScrollController();

    // in order to add a listener to our scrollController and
    //  hook it to our scrollable widget, we need useEffect()
    useEffect(() {
      scrollController.addListener(
        () {
          final newOpacity =
              math.max(imageHeight - scrollController.offset, 0.0);
          final normalised = newOpacity.normalise(0.0, imageHeight).toDouble();
          opacityAnimationController.value = normalised;
          heightAnimationController.value = normalised;
        },
      );
      return null;
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(children: [
        SizeTransition(
          sizeFactor: heightAnimationController,
          axis: Axis.vertical,
          axisAlignment: -1.0,
          child: FadeTransition(
            opacity: opacityAnimationController,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  "Person ${index + 1}",
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
