import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_weather/ui/screens/home_screen/home_screen.dart';
import 'package:simple_weather/ui/screens/location_view_screen/location_view_screen.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/utils/profile/air_pollution_profile.dart';
import 'package:simple_weather/utils/profile/location_profile.dart';
import 'package:simple_weather/utils/profile/weather_profile.dart';

import 'ui/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.transparent)
  );

  await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge
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
