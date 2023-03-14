import 'package:flutter/material.dart';
import 'package:simple_weather/ui/screens/search_screen/search_body.dart';

import '../../constants.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SearchBody()
    );
  }
}