import 'package:flutter/material.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/ui/templates/location_skeleton_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  final List<Widget> _pages = List.generate(3,
          (index) => const LocationSkeletonPage());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 22,
          width: _pages.length * 20 + 18,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: _pages.length,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              spacing: 12,
              type: WormType.normal,
              // strokeWidth: 5,
            ),
          ),
        ),

        const SizedBox(height: 41),

        SizedBox(
          height: MediaQuery.of(context).size.height - 170,
          child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: _pages.length,
            padEnds: true,
            pageSnapping: true,
            itemBuilder: (context, index) {
              return SingleChildScrollView(child: _pages[index]);
            },
          ),
        ),
      ],
    );
  }
}