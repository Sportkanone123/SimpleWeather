import 'dart:ui';

import 'package:latlong2/latlong.dart';

class AirPollutionProfile {
  late int time;
  late LatLng location;

  late int airPollutionIndex;

  late double carbonMonoxide;
  late double carbonMonoxideIndex;

  late double nitrogenMonoxide;

  late double nitrogenDioxide;
  late double nitrogenDioxideIndex;

  late double ozone;
  late double ozoneIndex;

  late double sulphurDioxide;
  late double sulphurDioxideIndex;

  late double fineParticlesMatter;
  late double fineParticlesMatterIndex;

  late double coarseParticlesMatter;
  late double coarseParticlesMatterIndex;

  late double ammonia;
  late double ammoniaIndex;


  AirPollutionProfile(
      this.time,
      this.location,
      this.airPollutionIndex,
      this.carbonMonoxide,
      this.carbonMonoxideIndex,
      this.nitrogenMonoxide,
      this.nitrogenDioxide,
      this.nitrogenDioxideIndex,
      this.ozone,
      this.ozoneIndex,
      this.sulphurDioxide,
      this.sulphurDioxideIndex,
      this.fineParticlesMatter,
      this.fineParticlesMatterIndex,
      this.coarseParticlesMatter,
      this.coarseParticlesMatterIndex,
      this.ammonia,
      this.ammoniaIndex);

  AirPollutionProfile.fromJSON(Map<String, dynamic> jsonResponse){
    Map<String, dynamic> subJsonResponse = jsonResponse['list'][0] as Map<String, dynamic>;

    time = subJsonResponse['dt'] as int;
    location = LatLng(jsonResponse['coord']['lat'] as double, jsonResponse['coord']['lon'] as double);
    airPollutionIndex = subJsonResponse['main']['aqi'] as int;
    carbonMonoxide = (subJsonResponse['components']['co'] as num).toDouble();
    nitrogenMonoxide = (subJsonResponse['components']['no'] as num).toDouble();
    nitrogenDioxide = (subJsonResponse['components']['no2'] as num).toDouble();
    ozone = (subJsonResponse['components']['o3'] as num).toDouble();
    sulphurDioxide = (subJsonResponse['components']['so2'] as num).toDouble();
    fineParticlesMatter = (subJsonResponse['components']['pm2_5'] as num).toDouble();
    coarseParticlesMatter = (subJsonResponse['components']['pm10'] as num).toDouble();
    ammonia = (subJsonResponse['components']['nh3'] as num).toDouble();

    _convertValuesToIndex();
  }

  String getIndexName(int index){
    switch (index){
      case 1:
        return "GOOD";
      case 2:
        return "FAIR";
      case 3:
        return "MODEST";
      case 4:
        return "POOR";
      case 5:
        return "BAD";
      default:
        return "UNKNOWN";
    }
  }

  Color getIndexColor(int index){
    switch (index){
      case 1:
        return const Color(0xFFB6F37B);
      case 2:
        return const Color(0xFF79B2F1);
      case 3:
        return const Color(0xFFF6EA7D);
      case 4:
        return const Color(0xFFF5C37C);
      case 5:
        return  const Color(0xFFF67C7C);
      default:
        return  const Color(0xFFC9CCC4);
    }
  }

  void _convertValuesToIndex(){
    //Carbon Monoxide
    if(carbonMonoxide >= 0 && carbonMonoxide <= 4400){
      carbonMonoxideIndex = 1;
    }else if(carbonMonoxide > 4400 && carbonMonoxide <= 9400){
      carbonMonoxideIndex = 2;
    }else if(carbonMonoxide > 9400 && carbonMonoxide <= 12400){
      carbonMonoxideIndex = 3;
    }else if(carbonMonoxide > 12400 && carbonMonoxide <= 15400){
      carbonMonoxideIndex = 4;
    }else if(carbonMonoxide > 15400){
      carbonMonoxideIndex = 5;
    }

    //Sulfur dioxide
    if(sulphurDioxide >= 0 && sulphurDioxide <= 20){
      sulphurDioxideIndex = 1;
    }else if(sulphurDioxide > 20 && sulphurDioxide <= 80){
      sulphurDioxideIndex = 2;
    }else if(sulphurDioxide > 80 && sulphurDioxide <= 250){
      sulphurDioxideIndex = 3;
    }else if(sulphurDioxide > 250 && sulphurDioxide <= 350){
      sulphurDioxideIndex = 4;
    }else if(sulphurDioxide > 350){
      sulphurDioxideIndex = 5;
    }

    //Nitrogen dioxide
    if(nitrogenDioxide >= 0 && nitrogenDioxide <= 40){
      nitrogenDioxideIndex = 1;
    }else if(nitrogenDioxide > 40 && nitrogenDioxide <= 70){
      nitrogenDioxideIndex = 2;
    }else if(nitrogenDioxide > 70 && nitrogenDioxide <= 150){
      nitrogenDioxideIndex = 3;
    }else if(nitrogenDioxide > 150 && nitrogenDioxide <= 200){
      nitrogenDioxideIndex = 4;
    }else if(nitrogenDioxide > 200){
      nitrogenDioxideIndex = 5;
    }

    //Coarse particulate matter
    if(coarseParticlesMatter >= 0 && coarseParticlesMatter <= 20){
      coarseParticlesMatterIndex = 1;
    }else if(coarseParticlesMatter > 20 && coarseParticlesMatter <= 50){
      coarseParticlesMatterIndex = 2;
    }else if(coarseParticlesMatter > 50 && coarseParticlesMatter <= 100){
      coarseParticlesMatterIndex = 3;
    }else if(coarseParticlesMatter > 100 && coarseParticlesMatter <= 200){
      coarseParticlesMatterIndex = 4;
    }else if(coarseParticlesMatter > 200){
      coarseParticlesMatterIndex = 5;
    }

    //Fine particles matter
    if(fineParticlesMatter >= 0 && fineParticlesMatter <= 10){
      fineParticlesMatterIndex = 1;
    }else if(fineParticlesMatter > 10 && fineParticlesMatter <= 25){
      fineParticlesMatterIndex = 2;
    }else if(fineParticlesMatter > 25 && fineParticlesMatter <= 50){
      fineParticlesMatterIndex = 3;
    }else if(fineParticlesMatter > 50 && fineParticlesMatter <= 75){
      fineParticlesMatterIndex = 4;
    }else if(fineParticlesMatter > 75){
      fineParticlesMatterIndex = 5;
    }

    //Ozone
    if(ozone >= 0 && ozone <= 60){
      ozoneIndex = 1;
    }else if(ozone > 60 && ozone <= 100){
      ozoneIndex = 2;
    }else if(ozone > 100 && ozone <= 140){
      ozoneIndex = 3;
    }else if(ozone > 140 && ozone <= 180){
      ozoneIndex = 4;
    }else if(ozone > 180){
      ozoneIndex = 5;
    }
  }
}