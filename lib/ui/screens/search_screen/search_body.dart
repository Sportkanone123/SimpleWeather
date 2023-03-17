import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/ui/screens/home_screen/home_screen.dart';
import 'package:simple_weather/ui/screens/location_view_screen/location_view_screen.dart';
import 'package:simple_weather/ui/templates/simple_location_page.dart';
import 'package:simple_weather/utils/simple_weather_profile.dart';
import 'package:simple_weather/utils/string_extension.dart';

import '../../../utils/air_pollution_profile.dart';
import '../../../utils/api/open_weather_api.dart';
import '../../../utils/debouncer.dart';
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
  List<Widget> quickRoutes = List.generate(1, (index) => Container());

  bool isLoading = false;
  late SharedPreferences prefs;


  @override
  void initState() {
    super.initState();

    refreshQuickRoutes();
  }

  Future<void> refreshRecommendations(String value) async {
    if(value.isNotEmpty && value.replaceAll(" ", "").isNotEmpty){
      setState(() {
        searchResults.clear();
        searchResults = List.generate(3, (index) =>
            CardLoading(
              height: 106,
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              margin: const EdgeInsets.only(right: 10, bottom: 20),
              cardLoadingTheme: CardLoadingTheme(
                colorOne: kPrimaryColor,
                colorTwo: kPrimaryColor.withOpacity(0.5),
              ),
            ),
        );
      });

      List<Widget> recomWidgets = [];

      List<LocationProfile> locations = await OpenWeatherAPI().getLocationProfile(value, 10);

      if(locations.isEmpty){
        recomWidgets.add(const Text("No results found.", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: "Poppins", color: kTextThirdColor),));
      }

      for(LocationProfile location in locations){
        SimpleWeatherProfile weatherProfile = await OpenWeatherAPI().getSimpleWeatherProfile(location);
        recomWidgets.add(InkWell(
          onTap: () async {
            AirPollutionProfile airPollutionProfile = await OpenWeatherAPI()
                .getAirPollution(location.latLng);
            WeatherProfile weatherProfile = await OpenWeatherAPI()
                .getWeatherProfile(location, airPollutionProfile);

            if (context.mounted) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();

              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      LocationViewScreen(profile: weatherProfile),
                ),
              );
            }
          },
          child: SimpleLocationPage(simpleWeatherProfile: weatherProfile)
        ));
      }

      setState(() {
        searchResults.clear();
        searchResults.addAll(recomWidgets);
      });
    }
  }

  Future<void> refreshQuickRoutes() async {
    prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();

    setState(() {
      quickRoutes.clear();
      quickRoutes = List.generate(keys.length, (index) =>
          CardLoading(
            height: 31,
            width: 85,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            margin: const EdgeInsets.only(right: 10),
            cardLoadingTheme: CardLoadingTheme(
              colorOne: kPrimaryColor,
              colorTwo: kPrimaryColor.withOpacity(0.5),
            ),
          ),
      );
    });


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
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();

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
          width: key.length * 6,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: kPrimaryColor
          ),
          alignment: Alignment.center,
          child: AutoSizeText(key.capitalize(), maxLines: 1,
              maxFontSize: 15,
              minFontSize: 5,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kTextSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins")),
        ),
      ));
    }

    if(context.mounted){
      setState(() {
        quickRoutes.clear();
        quickRoutes.addAll(recomWidgets);
      });
    }
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
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();

                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen(),
                    ),
                  );
                }
              ),
              const SizedBox(width: 5,),
              SearchInput(textController: searchController, width: (MediaQuery.of(context).size.width - 102), onEditingComplete: refreshRecommendations,)
            ],
          ),

          const SizedBox(height: 16,),

          SizedBox(
            height: 31,
            child: Container(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: quickRoutes,
                ),
              ),
            )
          ),

          const SizedBox(height: 23,),

          Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: searchResults,
                ),
              )
          ),
        ],
      ),
    );
  }

}


class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final _debouncer = Debouncer(milliseconds: 1000);
  final Function onEditingComplete;
  final double width;

  SearchInput(
      {Key? key,
        required this.textController,
        required this.width,
        required this.onEditingComplete})
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
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          autofocus: true,
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
            hintText: "Search Location",
            hintStyle: TextStyle(
                color: kTextThirdColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins"),
          ),
          onChanged: (string) {
            _debouncer.run(() {
              onEditingComplete(string);
            });
          }
        ));
  }
}