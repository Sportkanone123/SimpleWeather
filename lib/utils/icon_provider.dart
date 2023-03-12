import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconProvider {
  Widget getWeatherIcon(int weatherID){
    switch(weatherID) {
      case 200:
      case 201:
      case 202:
      case 230:
      case 231:
      case 232:
        return SvgPicture.asset('assets/weather_icons/thunderstorm_rain.svg');
      case 210:
      case 211:
      case 212:
      case 221:
        return SvgPicture.asset('assets/weather_icons/thunderstorm.svg');
      case 300:
      case 301:
      case 302:
      case 310:
      case 311:
      case 312:
      case 313:
      case 314:
      case 321:
        return SvgPicture.asset('assets/weather_icons/drizzle.svg');
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        if(_isDay()) {
          return SvgPicture.asset('assets/weather_icons/rain_day.svg');
        }else{
          return SvgPicture.asset('assets/weather_icons/rain_night.svg');
        }
      case 511:
        return SvgPicture.asset('assets/weather_icons/freezing_rain.svg');
      case 520:
      case 521:
      case 522:
      case 531:
        return SvgPicture.asset('assets/weather_icons/heavy_rain.svg');
      case 600:
      case 601:
      case 602:
        return SvgPicture.asset('assets/weather_icons/snow.svg');
      case 611:
      case 612:
      case 613:
      case 615:
      case 616:
        return SvgPicture.asset('assets/weather_icons/freezing_rain.svg');
      case 620:
      case 621:
      case 622:
        return SvgPicture.asset('assets/weather_icons/shower_snow.svg');
      case 701:
      case 711:
      case 721:
      case 731:
      case 741:
      case 751:
      case 761:
      case 762:
        return SvgPicture.asset('assets/weather_icons/foggy.svg');
      case 771:
      case 781:
        return SvgPicture.asset('assets/weather_icons/storm.svg');
      case 800:
        if(_isDay()) {
          return SvgPicture.asset('assets/weather_icons/clear_day.svg');
        }else{
          return SvgPicture.asset('assets/weather_icons/clear_night.svg');
        }
      case 801:
        if(_isDay()) {
          return SvgPicture.asset('assets/weather_icons/few_clouds_day.svg');
        }else{
          return SvgPicture.asset('assets/weather_icons/few_clouds_night.svg');
        }
      case 802:
      case 803:
      case 804:
        return SvgPicture.asset('assets/weather_icons/clouds.svg');
      default:
        return SvgPicture.asset('assets/weather_icons/fetch_failed.svg');
    }
  }

  bool _isDay(){
    return true;
  }
}