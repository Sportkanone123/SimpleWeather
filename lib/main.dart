import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_weather/ui/screens/home_screen/home_screen.dart';
import 'package:simple_weather/ui/screens/location_view_screen/location_view_screen.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/utils/air_pollution_profile.dart';
import 'package:simple_weather/utils/location_profile.dart';
import 'package:simple_weather/utils/weather_profile.dart';

import 'ui/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
  );

  await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartFinance',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextPrimaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
