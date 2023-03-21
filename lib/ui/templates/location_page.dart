import 'package:auto_size_text/auto_size_text.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/utils/icon_provider.dart';
import 'package:simple_weather/utils/profile/weather_profile.dart';
import 'package:simple_weather/utils/string_extension.dart';

class LocationPage extends StatelessWidget {
  final WeatherProfile weatherProfile;

  const LocationPage({super.key, required this.weatherProfile});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(weatherProfile.sunrise * 1000, isUtc: true).toLocal();
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(weatherProfile.sunset * 1000, isUtc: true).toLocal();

    return Column(
      children: [
        Container(
          height: 113,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 32, left: kDefaultPadding, right: kDefaultPadding),
          child: IconProvider().getWeatherIcon(weatherProfile.weatherId),
        ),
        Container(
          height: 30,
          margin: const EdgeInsets.only(bottom: 16, left: kDefaultPadding, right: kDefaultPadding),
          child: AutoSizeText("${weatherProfile.location.name.capitalize()}, ${weatherProfile.location.country}", maxLines: 1, maxFontSize: 30, textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 30, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
        ),
        Container(
          height: 72,
          margin: const EdgeInsets.only(bottom: 35, left: kDefaultPadding, right: kDefaultPadding),
          child: Text("${weatherProfile.temperature.round()}°", textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 70, fontWeight: FontWeight.w500, fontFamily: "Poppins"),)
        ),
        Container(
          height: 59,
          margin: const EdgeInsets.only(bottom: 11, left: kDefaultPadding, right: kDefaultPadding),
          padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            color: kPrimaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("TIME", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
                  const SizedBox(height: 6,),
                  Text(DateFormat.Hm().format(DateTime.now()).toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: "Poppins", color: kTextPrimaryColor),),
                ],
              ),
              Column(
                children: [
                  const Text("% RAIN", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
                  const SizedBox(height: 6,),
                  Text("${weatherProfile.humidityPercent}%", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: "Poppins", color: kTextPrimaryColor),),
                ],
              ),
              Column(
                children: [
                  const Text("WIND", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
                  const SizedBox(height: 6,),
                  Text("${weatherProfile.windSpeed.round()} km/h", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: "Poppins", color: kTextPrimaryColor),),
                ],
              ),
              Column(
                children: [
                  const Text("AIR", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
                  const SizedBox(height: 6,),
                  Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.airPollutionIndex), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: "Poppins", color: kTextPrimaryColor),),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 229,
          margin: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, bottom: 11,),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            color: kPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 15, bottom: 32),
                child: const Text("SUNRISE & SUNSET", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.1075, right: size.width * 0.1075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Sunrise", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextThirdColor),),
                        Text("${sunrise.hour}:${sunrise.minute}", textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins", color: kTextPrimaryColor),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Sunset", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextThirdColor),),
                        Text("${sunset.hour}:${sunset.minute}", textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins", color: kTextPrimaryColor),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 18, right: 18),
                alignment: Alignment.topCenter,
                child: SvgPicture.asset('assets/weather_icons/sunset_rise_visual.svg', fit: BoxFit.fitWidth,),
              ),
              Container(
                margin: const EdgeInsets.only(left: 17, top: 16),
                child: Row(
                  children: [
                    const Text("Length of day: ", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextPrimaryColor),),
                    Text("${sunrise.difference(sunset).abs().inHours}H ${sunrise.difference(sunset).abs().inMinutes % 60}M", textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextSecondaryColor),),
                  ],
                )
              ),
              Container(
                margin: const EdgeInsets.only(left: 17, top: 4),
                child: Row(
                  children: [
                    const Text("Remaining daylight: ", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextPrimaryColor),),
                    (!DateTime.now().isAfter(sunset)) ?
                      Text("${sunset.difference(DateTime.now()).abs().inHours}H ${sunset.difference(DateTime.now()).abs().inMinutes % 60}M", textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextSecondaryColor),)
                      : const Text("---", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, fontFamily: "Poppins", color: kTextSecondaryColor),)
                  ],
                )
              ),
            ],
          ),
        ),
        Container(
          height: 258,
          margin: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
          padding: const EdgeInsets.only(left: 17, right: 17),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            color: kPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 16),
                child: const Text("AIR QUALITY INSIGHTS", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Poppins", color: kTextThirdColor),),
              ),

              const Text("Carbon Monoxide:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.carbonMonoxideIndex.toInt()),
                  value: weatherProfile.airPollutionIndex.carbonMonoxideIndex,
                  radius: BorderRadius.circular(10),
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.carbonMonoxideIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),

              const Text("Ozone:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.ozoneIndex.toInt()),
                  radius: BorderRadius.circular(10),
                  value: weatherProfile.airPollutionIndex.ozoneIndex,
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.ozoneIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),

              const Text("Fine Particles Matter:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.fineParticlesMatterIndex.toInt()),
                  value: weatherProfile.airPollutionIndex.fineParticlesMatterIndex,
                  radius: BorderRadius.circular(10),
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.fineParticlesMatterIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),

              const Text("Coarse Particles Matter:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.coarseParticlesMatterIndex.toInt()),
                  value: weatherProfile.airPollutionIndex.coarseParticlesMatterIndex,
                  radius: BorderRadius.circular(10),
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.coarseParticlesMatterIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),

              const Text("Nitrogen Dioxide:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.nitrogenDioxideIndex.toInt()),
                  value: weatherProfile.airPollutionIndex.nitrogenDioxideIndex,
                  radius: BorderRadius.circular(10),
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.nitrogenDioxideIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),

              const Text("Sulphur Dioxide:", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextThirdColor),),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                height: 15,
                child: DChartSingleBar(
                  forgroundColor: weatherProfile.airPollutionIndex.getIndexColor(weatherProfile.airPollutionIndex.sulphurDioxideIndex.toInt()),
                  value: weatherProfile.airPollutionIndex.sulphurDioxideIndex,
                  radius: BorderRadius.circular(10),
                  max: 5,
                  forgroundLabel: Text(weatherProfile.airPollutionIndex.getIndexName(weatherProfile.airPollutionIndex.sulphurDioxideIndex.toInt()), textAlign: TextAlign.start, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: "Poppins", color: kTextPrimaryColor)),
                  forgroundLabelAlign: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}