
import 'package:flutter/material.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/ui/desgin/design.dart';

import '../../../routes.dart';
import '../../common/App_sharedPreference.dart';
import 'ArrowButton.dart';
import 'DotIndicator.dart';
import 'OnBoardingData.dart';
import 'PageViewItem.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    List<OnBoardingData> onBoardingList = [
      OnBoardingData(
        title: l10n.titleIntro1,
        description:
        l10n.introDesc1,
        image: App_icons.intro1,
      ),
      OnBoardingData(
        title: l10n.titleIntro2,
        description:
        l10n.introDesc2,
        image: App_icons.intro2,
      ),
      OnBoardingData(
        title: l10n.titleIntro3,
        description:
        l10n.introDesc3,
        image: App_icons.intro3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(App_icons.app_logo),
            SizedBox(width: 10),
            Text(AppLocalizations.of(context)!.appTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      currentSelectedIndex = index;
                    });
                  },
                  controller: pageController,
                  itemCount: onBoardingList.length,
                  itemBuilder: (context, index) {
                    var data = onBoardingList;
                    return PageViewItem(data: data[index]);
                  },
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentSelectedIndex != 0
                          ? ArrowButton(
                        icon: Icons.arrow_back,
                        onTap: () {
                          pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                          : SizedBox(width: 20),
                      ArrowButton(
                        icon: Icons.arrow_forward,
                        onTap: () {
                          if (currentSelectedIndex <
                              onBoardingList.length - 1) {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            AppSharedPreferences.getInstance().onboardingCheck(
                              false,
                            );
                            Navigator.pushReplacementNamed(
                              context,
                              App_routes.LoginScreen.name,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return DotIndicator(
                        isSelected: currentSelectedIndex == index,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}