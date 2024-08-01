import 'package:flutter/material.dart';
import 'package:task_6_onboarding_pages/utils/color.utility.dart';

class OnboardingPageDecoration extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isFinalPage;
  final bool isDarkMode;

  const OnboardingPageDecoration({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.isFinalPage = false,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 180,
          left: 20,
          right: 20,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              color: isDarkMode
                  ? ColorUtility.darkModeBackground
                  : ColorUtility.scaffoldBackground,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(image),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          top: 500,
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorUtility.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
