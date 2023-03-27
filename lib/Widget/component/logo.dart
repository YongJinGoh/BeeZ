import 'package:flutter/material.dart';
import 'logo/logo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleFadeAnimation;
  late Animation<Offset> _circleSlideAnimation;
  late Animation<double> _ovalAnimation;
  late Animation<double> _wingFadeAnimation;
  late Animation<Offset> _wingSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;

  static double defaultOffsetTop = 20;
  static double defaultOffsetWingTop = 13;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();

    _circleFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.15),
      ),
    );
    _circleSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0.055, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.25, curve: Curves.linear),
      ),
    );
    _ovalAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.275, 0.45, curve: Curves.linear),
      ),
    );
    _wingFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.65),
      ),
    );
    _wingSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0.046, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.75, curve: Curves.linear),
      ),
    );
    _titleFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.95, curve: Curves.linear),
      ),
    );
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(0, -0.75),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 350,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          logoPosition(
            top: defaultOffsetTop,
            child: FadeTransition(
              opacity: _circleFadeAnimation,
              child: SlideTransition(
                position: _circleSlideAnimation,
                textDirection: TextDirection.rtl,
                child: const LogoCicle(),
              ),
            ),
          ),
          logoPosition(
            top: defaultOffsetTop,
            child: FadeTransition(
              opacity: _circleFadeAnimation,
              child: SlideTransition(
                position: _circleSlideAnimation,
                child: const LogoCicle(imageFile: 'right-round.png'),
              ),
            ),
          ),
          logoPosition(
            top: defaultOffsetTop + 5,
            child: FadeTransition(
              opacity: _ovalAnimation,
              child: const Align(
                alignment: Alignment.center,
                child: LogoOval(),
              ),
            ),
          ),
          logoPosition(
            top: defaultOffsetTop + defaultOffsetWingTop,
            child: FadeTransition(
              opacity: _wingFadeAnimation,
              child: SlideTransition(
                position: _wingSlideAnimation,
                textDirection: TextDirection.rtl,
                child: const LogoWing(),
              ),
            ),
          ),
          logoPosition(
            top: defaultOffsetTop + defaultOffsetWingTop + 10,
            child: FadeTransition(
              opacity: _wingFadeAnimation,
              child: SlideTransition(
                position: _wingSlideAnimation,
                child: const LogoWing(imageFile: 'white-right.png'),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _titleFadeAnimation,
              child: SlideTransition(
                position: _titleSlideAnimation,
                child: const LogoTitle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoPosition({required double top, required Widget child}) =>
      Positioned(left: 0, right: 0, top: top, child: child);
}
