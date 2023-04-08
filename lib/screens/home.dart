import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onellapp2/utils/constants.dart' as constants;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int intFood = 0;
  int _intFood = 0;
  int intShower = 0;
  int _intShower = 0;
  int intSleep = 0;
  int _intSleep = 0;
  final box = GetStorage();
  bool isStopped = false;

  @override
  initState() {
    super.initState();

    sec5Timer();

    _intFood = box.read(constants.food) >= 0 ? box.read(constants.food) : 0;
    _intShower = box.read(constants.shower) >= 0 ? box.read(constants.shower) : 0;
    _intSleep = box.read(constants.sleep) >= 0 ? box.read(constants.sleep) : 0;

    box.listenKey(constants.food, (value) {
      setState(() {
        _intFood = value >= 0 ? value : 0;
      });
    });

    box.listenKey(constants.shower, (value) {
      setState(() {
        _intShower = value >= 0 ? value : 0;
      });
    });

    box.listenKey(constants.sleep, (value) {
      setState(() {
        _intSleep = value >= 0 ? value : 0;
      });
    });
  }

  void _addFood() {
    intFood = box.read(constants.food);
    if (intFood < 100) {
      intFood++;
      box.write(constants.food, intFood);

      setState(() {
        _intFood = intFood;
      });
    }
  }

  void _pullAllNeed() {
    intFood = box.read(constants.food);
    intFood = intFood - 3 <= 0 ? 0 : intFood - 3;
    box.write(constants.food, intFood);

    intShower = box.read(constants.shower);
    intShower = intShower - 2 <= 0 ? 0 : intShower - 2;
    box.write(constants.shower, intShower);

    intSleep = box.read(constants.sleep);
    intSleep = intSleep - 1 <= 0 ? 0 : intSleep - 1;
    box.write(constants.sleep, intSleep);
    //go
  }

  void _addShower() {
    intShower = box.read(constants.shower);
    if (intShower < 100) {
      intShower++;
      box.write(constants.shower, intShower);

      setState(() {
        _intShower = intShower;
      });
    }
  }

  void _addSleep() {
    intSleep = box.read(constants.sleep);

    if (intSleep < 100) {
      intSleep++;
      box.write(constants.sleep, intSleep);

      setState(() {
        _intSleep = intSleep;
      });
    }
  }

  sec5Timer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (isStopped) {
        timer.cancel();
      }
      _pullAllNeed();
    });
  }

  @override
  Widget build(BuildContext context) {
    progressColor(int intBesoin) {
      if (intBesoin >= 33 && intBesoin < 66) {
        return Colors.orange;
      }
      if (intBesoin >= 66) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Informations et réglages',
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent:
                          _intShower <= 0 ? 0 : _intShower.toDouble() / 100,
                      animationDuration: 1500,
                      progressColor: progressColor(_intShower),
                      center: ElevatedButton(
                        onPressed: () {
                          _addShower();
                        },
                        child: Text('SHOWER : ' + _intShower.toString()),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(40),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 10,
                        percent: _intFood <= 0 ? 0 : _intFood.toDouble() / 100,
                        animationDuration: 1500,
                        progressColor: progressColor(_intFood),
                        center: ElevatedButton(
                          onPressed: () {
                            _addFood();
                          },
                          child: Text('FOOD : ' + _intFood.toString()),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(40),
                          ),
                        ),
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: _intSleep <= 0 ? 0 : _intSleep.toDouble() / 100,
                      animationDuration: 1500,
                      progressColor: progressColor(_intSleep),
                      center: ElevatedButton(
                        onPressed: () {
                          _addSleep();
                        },
                        child: Text('SLEEP : ' + _intSleep.toString()),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
