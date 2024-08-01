import 'package:flutter/material.dart';
import 'package:task_6_onboarding_pages/utils/color.utility.dart';

import 'first_page.dart';
import '../widgets/onboarding_page_decoration.dart';
import '../utils/images.utility.dart';

class OnboardingScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const OnboardingScreen({super.key, required this.themeNotifier});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ColorUtility.scaffoldBackground,
        elevation: 0,
        actions: [
          Row(
            children: [
              Switch(
                value: isDarkMode,
                activeColor: ColorUtility.deepYellow,
                onChanged: (bool value) {
                  widget.themeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              TextButton(
                onPressed: () {
                  _pageController.jumpToPage(4);
                },
                child: const Text("Skip",
                    style: TextStyle(color: ColorUtility.grey)),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                FirstPage(pageController: _pageController),
                OnboardingPageDecoration(
                  image: ImageUtility.certificate,
                  title: 'Certification and Badges',
                  description:
                      'Earn a certificate after completion of every course',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: ImageUtility.progress,
                  title: 'Progress Tracking',
                  description: 'Check your progress of every course',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: ImageUtility.access,
                  title: 'Offline Access',
                  description: 'Make your course available offline',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: ImageUtility.catalog,
                  title: 'Course Catalog',
                  description: 'View in which courses you are enrolled',
                  isDarkMode: isDarkMode,
                  isFinalPage: true,
                ),
              ],
            ),
          ),
          if (_currentPage != 0) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5 - 1, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 10,
                  width: 45,
                  decoration: BoxDecoration(
                    color: _currentPage == index + 1
                        ? ColorUtility.deepYellow
                        : (isDarkMode
                            ? ColorUtility.darkBackground
                            : Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorUtility.shadows,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(40),
              child: _currentPage == 4
                  ? ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtility.deepYellow,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage != 1
                            ? CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorUtility.grey,
                                child: IconButton(
                                  onPressed: () {
                                    if (_currentPage > 1) {
                                      _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white, size: 30),
                                ),
                              )
                            : const SizedBox(),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: ColorUtility.deepYellow,
                          child: IconButton(
                            onPressed: () {
                              if (_currentPage < 4) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            icon: const Icon(Icons.arrow_forward,
                                color: Colors.white, size: 30),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
