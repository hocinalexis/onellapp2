import 'package:flutter/material.dart';
import 'package:onellapp2/screens/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onellapp2/constants.dart' as constants;

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    box.write(constants.name, 'Alexis');
    box.write(constants.nameai, 'Onell');
    box.write(constants.xp, '10');
    box.write(constants.food, 50);
    box.write(constants.shower, 25);
    box.write(constants.sleep, 100);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
