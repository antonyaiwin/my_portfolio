import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/greetings_controller.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/core/constants/string_constants.dart';
import 'package:provider/provider.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('build');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 1)).then(
        (value) => context.read<GreetingsController>().initAnimation(context),
      );
    });
    return Column(
      children: [
        Consumer<GreetingsController>(
          builder: (BuildContext context, GreetingsController value,
                  Widget? child) =>
              AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutQuart,
            decoration: const BoxDecoration(
              color: ColorConstants.greetingsBackground,
            ),
            height: value.containerHeight ?? MediaQuery.of(context).size.height,
            child: Center(
              child: AnimatedOpacity(
                opacity: value.textOpacity,
                duration: Duration(milliseconds: value.opacityDuration),
                child: Text(
                  '• ${greetings[value.index]}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: ColorConstants.primaryWhite,
                      ),
                ),
                onEnd: () {
                  value.initTextTimer();
                },
              ),
            ),
          ),
        ),
        Consumer<GreetingsController>(
          builder: (BuildContext context, GreetingsController value,
                  Widget? child) =>
              ClipPath(
            clipper: BottomRounded(),
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 1000,
              ),
              height: value.roundedContainerHeight,
              width: double.infinity,
              color: ColorConstants.greetingsBackground,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomRounded extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 2,
      size.width,
      0,
    );
    path.quadraticBezierTo(
      size.width / 2,
      -size.height,
      0,
      0,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
