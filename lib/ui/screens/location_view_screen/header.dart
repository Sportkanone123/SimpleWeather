import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/utils/weather_profile.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.weatherProfile});

  final WeatherProfile weatherProfile;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool hasLoaded = false;
  bool isSaved = false;

  late SharedPreferences prefs;


  @override
  Future<void> initState() async {
    super.initState();

    prefs = await SharedPreferences.getInstance();

    setState(() {
      isSaved = prefs.containsKey(widget.weatherProfile.location.name);
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(kDefaultPadding, 65, kDefaultPadding, 41),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.keyboard_arrow_left, color: kTextSecondaryColor, size: 12),
          ),
          (hasLoaded)
              ? (isSaved)
                  ? InkWell(
                      child: Container(
                        height: 39,
                        width: 110,
                        color: kPrimaryColor,
                        child: Row(
                          children: const [
                            Text("Add to List", style: TextStyle(color: kTextThirdColor, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),),
                            Icon(Icons.add_circle_outline, color: kTextThirdColor, size: 14,)
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          prefs.setString(widget.weatherProfile.location.name.toLowerCase(), widget.weatherProfile.location.latLng.toJson().toString());
                          isSaved = true;
                        });
                      },
                    )
                  : InkWell(
                      child: Container(
                        height: 39,
                        width: 110,
                        color: const Color(0xFF009456),
                        child: Row(
                          children: const [
                            Text("Added to List", style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),),
                            Icon(Icons.done, color: Colors.white, size: 14,)
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          prefs.remove(widget.weatherProfile.location.name.toLowerCase());
                          isSaved = false;
                        });
                      },
                    )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}