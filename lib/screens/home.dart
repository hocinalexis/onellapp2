import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onellapp2/constants.dart' as constants;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int intFood = 0;
  int intShower = 0;
  int intSleep = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addFood() {
    final box = GetStorage();
    intFood = box.read(constants.food);
    intFood++;
    box.write(constants.food, intFood);
  }

  void _addShower() {
    final box = GetStorage();
    intShower = box.read(constants.shower);
    intShower++;
    box.write(constants.shower, intShower);
  }

  void _addSleep() {
    final box = GetStorage();
    intSleep = box.read(constants.sleep);
    intSleep++;
    box.write(constants.sleep, intSleep);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
              width: 200,
              child: RiveAnimation.asset('assets/test_oeil_v2.riv'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () { _addShower(); },
                      child: const Text('SHOWER'),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () { _addFood(); },
                      child: const Text('FOOD'),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () { _addSleep(); },
                      child: const Text('SLEEP'),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(24),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}