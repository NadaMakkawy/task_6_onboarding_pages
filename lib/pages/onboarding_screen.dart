import 'package:flutter/material.dart';

import 'first_page.dart';
import '../widgets/onboarding_page_decoration.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            children: [
              Switch(
                value: isDarkMode,
                activeColor: Colors.amber,
                onChanged: (bool value) {
                  widget.themeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              TextButton(
                onPressed: () {
                  _pageController.jumpToPage(4);
                },
                child: const Text("Skip", style: TextStyle(color: Colors.grey)),
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
                  image: 'assets/certificate.png',
                  title: 'Certification and Badges',
                  description:
                      'Earn a certificate after completion of every course',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: 'assets/progress.png',
                  title: 'Progress Tracking',
                  description: 'Check your progress of every course',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: 'assets/access.png',
                  title: 'Offline Access',
                  description: 'Make your course available offline',
                  isDarkMode: isDarkMode,
                ),
                OnboardingPageDecoration(
                  image: 'assets/catalog.png',
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
                        ? Colors.amber
                        : (isDarkMode ? Colors.white12 : Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
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
                        backgroundColor: Colors.amber,
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
                                backgroundColor: Colors.grey,
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
                          backgroundColor: Colors.amber,
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
