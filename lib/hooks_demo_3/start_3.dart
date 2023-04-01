import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer' as dev;

/// This demo is going to demonstrate
/// using hooks to load an image into memory
/// however, we are going to avoid using an
/// empty container while the user is
/// awaiting the images to be loaded
///
///
/// In order to avoid using an empty container, we will create an extension on iterables that will return
/// a version of the iterable that contains no null values.
/// This function is known as "CompactMap" in other languages
///

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((element) => element != null).cast();
}

const url = "https://bit.ly/3ZymzO0";

class HooksDemo3 extends HookWidget {
  const HooksDemo3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final image = NetworkAssetBundle(Uri.parse(url))
    //     .load(url)
    //     .then((value) => value.buffer.asUint8List())
    //     .then((value) => Image.memory(value));
    // image above is of type Future<Image>
    // In order to consume this image data in our application
    // We would then need to use a future builder

    // Image.network does all the heavy lifting above for us typically

    /// image here is now of type Async snapshot
    /// However, the problem with this approach which causes the
    /// flickering effect observed is since our Hook widget has no state
    /// and the image created is not persisted in any way
    /// This, is triggering a rebuild of the widget
    /// The build method is being recalled, hence the flickers
    ///

    // ignore: unused_local_variable
    // final image = useFuture(NetworkAssetBundle(Uri.parse(url))
    //     .load(url)
    //     .then((value) => value.buffer.asUint8List())
    //     .then((value) => Image.memory(value)));

    /// To persist the image in memory and prevent its rebuild
    /// there is another hook called useMemoized
    /// It caches the instance of any complex object
    /// (such as an Image object in this case)
    /// It  has a required parameter of a function whose output is of any type T
    /// The output of this function should be the cached object
    final cachedImage = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((value) => value.buffer.asUint8List())
          .then(
            (value) => Image.memory(value),
          ),
    );
    // We can then consume the cached image with the useFuture hook
    final image = useFuture(cachedImage);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        // children: [
        //   image.hasData ? image.data! : null,
        // ].compactMap().toList(),
        children: [image.data].compactMap().toList(),
      ),
    );
  }
}
