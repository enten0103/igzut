import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 250),
  });
  final String text;
  final Duration duration;
  final Duration transitionDuration;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController opacity;

  @override
  void initState() {
    super.initState();
    opacity = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    )..forward();

    final startFadeOutAt = widget.duration - widget.transitionDuration;

    Future.delayed(startFadeOutAt, opacity.reverse);
  }

  @override
  void dispose() {
    opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          shape: StadiumBorder(),
          color: Theme.of(context).colorScheme.primaryFixed,
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).size.height * .125,
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Text(
                widget.text,
                style: GoogleFonts.notoSerif(),
              )),
        ),
      ),
    );
  }
}
