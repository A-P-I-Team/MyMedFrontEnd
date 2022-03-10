import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/components/button.dart';
import 'package:my_med/src/core/routing/router.dart';
import 'package:my_med/src/modules/intro/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
      create: (_) => OnboardingProvider(),
      child: _OnboardingPage(),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 5,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider.pageCount,
                controller: provider.controller,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .2,
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              [
                                "Picture 1",
                                "Picture 2",
                                "Picture 3",
                              ][index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6!.merge(
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: SmoothPageIndicator(
                  effect: JumpingDotEffect(
                    spacing: 12,
                    verticalOffset: 16,
                    activeDotColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                  ),
                  count: provider.pageCount,
                  controller: provider.controller,
                  onDotClicked: provider.onDotClicked,
                ),
              ),
            ),
            const SizedBox(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  getButton(
                    context: context,
                    route: const LoginRoute(),
                    buttonType: ButtonType.primary,
                    child: const Text(
                      "Sign up & Get your prescriptions fast!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  getButton(
                    context: context,
                    route: const LoginRoute(),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: 'Have an account?  ',
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getButton({
    required BuildContext context,
    required Widget child,
    required PageRouteInfo<dynamic> route,
    Color? color,
    ButtonType buttonType = ButtonType.secondary,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: const Alignment(0, .8),
        child: FractionallySizedBox(
          widthFactor: .8,
          child: DefaultButton(
            color: (color == null) ? null : color,
            onPressed: () => context.router.push(route),
            buttonType: buttonType,
            child: child,
          ),
        ),
      ),
    );
  }
}
