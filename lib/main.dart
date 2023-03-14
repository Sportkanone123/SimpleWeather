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
      //home: const HomeScreen(),
      home: LocationViewScreen(profile: WeatherProfile.fromJson(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":6.69,"feels_like":1.45,"temp_min":5.62,"temp_max":8.05,"pressure":1006,"humidity":59},"visibility":10000,"wind":{"speed":11.62,"deg":259},"clouds":{"all":75},"dt":1678809694,"sys":{"type":2,"id":2035370,"country":"DE","sunrise":1678772238,"sunset":1678814610},"timezone":3600,"id":2870795,"name":"Mittelbiberach","cod":200}')
          , AirPollutionProfile.fromJSON(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"list":[{"main":{"aqi":1},"components":{"co":210.29,"no":0.05,"no2":3.64,"o3":54.36,"so2":0.3,"pm2_5":0.5,"pm10":0.69,"nh3":5.19},"dt":1678640657}]}'))
          , LocationProfile.fromJSON(jsonDecode('{"name":"Mittelbiberach","lat":48.0877864,"lon":9.7479621,"country":"DE","state":"Baden-Württemberg"}')))),
    );
  }
}
