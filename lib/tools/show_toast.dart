import 'package:flutter/material.dart';

extension ToastExtension on BuildContext {
  void showToast(
    String text, {
    Duration duration = const Duration(seconds: 3),
    Duration transitionDuration = const Duration(milliseconds: 250),
  }) {
    // Get the OverlayState
    final overlayState = Overlay.of(this);
    // Create an OverlayEntry with your custom widget
    final toast = OverlayEntry(
      builder: (_) => _ToastWidget(
        text: text,
        transitionDuration: transitionDuration,
        duration: duration,
      ),
    );
    overlayState.insert(toast);
    Future.delayed(duration, toast.remove);
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.text,
    this.duration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 250),
  });
  final String text;
  final Duration duration;
  final Duration transitionDuration;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
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
              )),
        ),
      ),
    );
  }
}
