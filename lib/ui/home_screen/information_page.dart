import 'package:flutter/material.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  final pages = List.generate(3,
          (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: SizedBox(
          height: 1000,
          child: Center(
              child: Text(
                "Page $index",
                style: const TextStyle(color: Colors.indigo),
              )),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 22,
          width: pages.length * 20 + 18,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: pages.length,
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
            itemCount: pages.length,
            itemBuilder: (_, index) {
              return SingleChildScrollView(child: pages[index % pages.length]);
            },
          ),
        ),
      ],
    );
  }
}