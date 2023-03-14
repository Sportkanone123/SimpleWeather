import 'package:flutter/material.dart';
import 'package:simple_weather/ui/screens/search_screen/search_screen.dart';

import '../../constants.dart';

class SearchBar extends StatelessWidget{
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(kDefaultPadding, 44, kDefaultPadding, 17),
        padding: const EdgeInsets.only(left: 20, right: 14),
        height: 46,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Search Location", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Poppins", color: kTextPrimaryColor)),
              Icon(Icons.search, color: kTextPrimaryColor, size: 17.49, weight: 17.49,),
            ],
          ),
          onTap: (){
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const SearchScreen(),
              ),
            );
          },
        ),
    );
  }
}