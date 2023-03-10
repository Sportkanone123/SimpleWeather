import 'package:flutter/material.dart';

import '../constants.dart';
import './information_page.dart';
import './search_bar.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: const [
          SearchBar(),
          InformationPage(),
        ],
      ),
    );
  }
}