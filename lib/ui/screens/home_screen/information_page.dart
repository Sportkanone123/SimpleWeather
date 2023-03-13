import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/ui/templates/location_skeleton_page.dart';
import 'package:simple_weather/utils/air_pollution_profile.dart';
import 'package:simple_weather/utils/location_profile.dart';
import 'package:simple_weather/utils/weather_profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  final List<Widget> _pages = List.generate(3,
          (index) => LocationPage(weatherProfile: WeatherProfile.fromJson(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":9.14,"feels_like":5.93,"temp_min":7.4,"temp_max":9.8,"pressure":1013,"humidity":70},"visibility":10000,"wind":{"speed":6.69,"deg":240},"clouds":{"all":40},"dt":1678641403,"sys":{"type":2,"id":2043407,"country":"DE","sunrise":1678599683,"sunset":1678641633},"timezone":3600,"id":2870795,"name":"Mittelbiberach","cod":200}')
              , AirPollutionProfile.fromJSON(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"list":[{"main":{"aqi":1},"components":{"co":210.29,"no":0.05,"no2":3.64,"o3":54.36,"so2":0.3,"pm2_5":0.5,"pm10":0.69,"nh3":5.19},"dt":1678640657}]}'))
              , LocationProfile.fromJSON(jsonDecode('{"name":"Mittelbiberach","lat":48.0877864,"lon":9.7479621,"country":"DE","state":"Baden-Württemberg"}')))));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 22,
          width: _pages.length * 20 + 18,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: _pages.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 12,
              type: WormType.normal,
              // strokeWidth: 5,
            ),
          ),
        ),

        const SizedBox(height: 41),

        SizedBox(
          height: MediaQuery.of(context).size.height - 170,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: _pages.length,
            padEnds: true,
            pageSnapping: true,
            itemBuilder: (context, index) {
              return SingleChildScrollView(child: _pages[index]);
            },
          ),
        ),
      ],
    );
  }
}