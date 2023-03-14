import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/ui/screens/home_screen/home_screen.dart';
import 'package:simple_weather/ui/screens/location_view_screen/location_view_screen.dart';

import '../../../utils/air_pollution_profile.dart';
import '../../../utils/api/open_weather_api.dart';
import '../../../utils/location_profile.dart';
import '../../../utils/weather_profile.dart';
import '../../constants.dart';

class SearchBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateSearchBody();
}

class _StateSearchBody extends State<SearchBody> {
  TextEditingController searchController = TextEditingController();

  List<Widget> searchResults = [];
  List<Widget> recommendations = List.generate(1, (index) => Container());

  final resultsController = PageController(viewportFraction: 1, keepPage: true);

  final recomController = PageController(viewportFraction: 1, keepPage: true);

  bool isLoading = false;
  late SharedPreferences prefs;


  @override
  void initState() {
    super.initState();

    refreshRecommendations();
  }

  Future<void> refreshRecommendations() async {
    prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();

    recommendations = List.generate(keys.length, (index) =>
        CardLoading(
          height: 31,
          width: 78,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          margin: const EdgeInsets.only(right: 10),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
    );

    List<Widget> recomWidgets = [];

    for (String key in keys) {
      recomWidgets.add(InkWell(
        onTap: () async {
          LocationProfile locationProfile = LocationProfile.fromJSON(
              jsonDecode(prefs.getString(key)!));
          AirPollutionProfile airPollutionProfile = await OpenWeatherAPI()
              .getAirPollution(locationProfile.latLng);
          WeatherProfile weatherProfile = await OpenWeatherAPI()
              .getWeatherProfile(locationProfile, airPollutionProfile);

          if (context.mounted) {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    LocationViewScreen(profile: weatherProfile),
              ),
            );
          }
        },
        child: Container(
          height: 31,
          width: 78,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: kPrimaryColor
          ),
          child: AutoSizeText(key, maxLines: 1,
              maxFontSize: 10,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kTextSecondaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins")),
        ),
      ));
    }

    setState(() {
      recommendations.clear();
      recommendations.addAll(recomWidgets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(kDefaultPadding, 44, kDefaultPadding, 0),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: kPrimaryColor,
                  ),
                  child: const Icon(Icons.keyboard_arrow_left, color: kTextSecondaryColor, size: 32),
                ),
                onTap: (){
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen(),
                    ),
                  );
                }
              ),
              const SizedBox(width: 5,),
              SearchInput(textController: searchController, width: (MediaQuery.of(context).size.width - 102),)
            ],
          ),

          const SizedBox(height: 16,),

          SizedBox(
            height: 31,
            child: PageView.builder(
              controller: recomController,
              scrollDirection: Axis.horizontal,
              itemCount: recommendations.length,
              padEnds: true,
              pageSnapping: true,
              itemBuilder: (context, index) {
                return recommendations[index];
              },
            ),
          )
        ],
      ),
    );
  }

}


class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final double width;

  const SearchInput(
      {Key? key,
        required this.textController,
        required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46,
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kPrimaryColor,
        ),
        child: TextField(
          style: const TextStyle(
              color: kTextPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
          maxLines: 1,
          cursorColor: kBackgroundColor,
          controller: textController,
          keyboardType: TextInputType.text,
          obscureText: false,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "   Search Location",
            hintStyle: TextStyle(
                color: kTextThirdColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
        ));
  }
}