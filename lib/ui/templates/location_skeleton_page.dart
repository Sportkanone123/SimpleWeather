import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LocationSkeletonPage extends StatelessWidget {
  const LocationSkeletonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardLoading(
          height: 113,
          width: 123,
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          margin: const EdgeInsets.only(bottom: 32, left: kDefaultPadding, right: kDefaultPadding),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        CardLoading(
          height: 30,
          width: 172,
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          margin: const EdgeInsets.only(bottom: 16, left: kDefaultPadding, right: kDefaultPadding),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        CardLoading(
          height: 70,
          width: 105,
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          margin: const EdgeInsets.only(bottom: 35, left: kDefaultPadding, right: kDefaultPadding),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        CardLoading(
          height: 59,
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          margin: const EdgeInsets.only(bottom: 11, left: kDefaultPadding, right: kDefaultPadding),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        CardLoading(
          height: 229,
          borderRadius: const BorderRadius.all(Radius.circular(11)),
          margin: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
          cardLoadingTheme: CardLoadingTheme(
            colorOne: kPrimaryColor,
            colorTwo: kPrimaryColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}