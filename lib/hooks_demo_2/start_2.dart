import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// useTextEditingController handles the creating of the textEditingController and its disposal
///

class HooksDemo2 extends HookWidget {
  const HooksDemo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    // In order to have access of the current value of the textEditingController
    // We need another hook (useState)
    // use state returns a ValueNotifier
    final text = useState('');

    /// use Effect is used to effect changes
    /// It accepts a void call back and an array of keys
    /// Note that in the build function of hook widgets,
    /// whenever we hot reload, ideally we would be rebuilding
    /// everything (the controller, text) in our build function
    /// because that is how flutter works
    /// However, because of how hook widgets are implemented
    /// using indexing and keys to perform equality and identify
    /// what needs to be rebuilt and what not
    /// But because the useEffect does not have any identifiers,
    /// it will get rebuilt whenever we hot reload
    /// Hence, why we need to supply the second parameter,
    /// an array of keys
    ///
    /// In this instance we are using our controller as a key
    useEffect(() {
      controller.addListener(() {
        /// Recall that in the sc of ValueNotifier,
        /// The setter method calls notifyListeners
        text.value = controller.text;
      });
      // The function has a nullable return type
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text('You typed: ${text.value}'),
        ],
      ),
    );
  }
}
