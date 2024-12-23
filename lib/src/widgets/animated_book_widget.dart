import 'package:animated_book_widget/src/src.dart';
import 'package:flutter/material.dart';

/// A customizable animated book widget with
/// cover, content, and animation control.
///
class AnimatedBookWidget extends StatefulWidget {
  /// Creates an [AnimatedBookWidget] with fixed content.
  ///
  /// The [cover] is the widget representing the book cover.
  ///
  /// The [size] is the size of the book.
  ///
  /// The [content] is the fixed content inside the book.
  ///
  /// The [padding] is the padding around the book.
  ///
  /// The [blurRadius] is the blur radius applied to the background.
  ///
  /// The [spreadRadius] is how far the shadow is spread.
  ///
  /// The [backgroundBlurOffset] is the offset of the background blur effect.
  ///
  /// The [backgroundColor] is the background color of the book.
  ///
  /// The [backgroundShadowColor] is the color of the shadow
  /// applied to the background.
  ///
  /// The [curve] is the animation curve used for opening/closing the book.
  ///
  /// The [animationDuration] is the duration of the opening animation.
  ///
  /// The [reverseAnimationDuration] is the duration of the closing animation.
  ///
  /// The [backgroundBorderRadius] is the border radius
  /// applied to the background.
  ///
  AnimatedBookWidget({
    required this.cover,
    required this.size,
    required Widget content,
    super.key,
    this.padding = EdgeInsets.zero,
    this.blurRadius = 4,
    this.spreadRadius = 0.5,
    this.backgroundBlurOffset = Offset.zero,
    this.backgroundColor,
    this.backgroundShadowColor,
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 500),
    this.reverseAnimationDuration = const Duration(milliseconds: 500),
    this.backgroundBorderRadius = BorderRadius.zero,
    this.horinzontalFlipDirection = HorinzontalFlipDirection.left,
  }) : contentDelegate = DefaultAnimatedContentDelegate(contentChild: content);

  /// Creates an [AnimatedBookWidget] with dynamic content
  /// using a builder function.
  ///
  /// The [cover] is the widget representing the book cover.
  ///
  /// The [size] is the size of the book.
  ///
  /// The [contentBuilder] is a function that builds
  /// the dynamic content inside the book.
  ///
  /// The optional [contentChild] is used as a
  /// fallback if [contentBuilder] is null.
  ///
  /// The [padding] is the padding around the book.
  ///
  /// The [blurRadius] is the blur radius applied to the background.
  ///
  /// The [spreadRadius] is how far the shadow is spread.
  ///
  /// The [backgroundBlurOffset] is the offset of the background blur effect.
  ///
  /// The [backgroundColor] is the background color of the book.
  ///
  /// The [backgroundShadowColor] is the color of the
  /// shadow applied to the background.
  ///
  /// The [curve] is the animation curve used for opening/closing the book.
  ///
  /// The [animationDuration] is the duration of the opening animation.
  ///
  /// The [reverseAnimationDuration] is the duration of the closing animation.
  ///
  /// The [backgroundBorderRadius] is the border
  /// radius applied to the background.
  ///
  /// The [horinzontalFlipDirection] is the flip direction applied to the book.
  AnimatedBookWidget.builder({
    required this.cover,
    required this.size,
    required AnimatedBookContentBuilder contentBuilder,
    Widget? contentChild,
    super.key,
    this.padding = EdgeInsets.zero,
    this.blurRadius = 4,
    this.spreadRadius = 0.5,
    this.backgroundBlurOffset = Offset.zero,
    this.backgroundColor,
    this.backgroundShadowColor,
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 500),
    this.reverseAnimationDuration = const Duration(milliseconds: 500),
    this.backgroundBorderRadius = BorderRadius.zero,
    this.horinzontalFlipDirection = HorinzontalFlipDirection.left,
  }) : contentDelegate = BuilderAnimatedContentDelegate(
          contentBuilder: contentBuilder,
          contentChild: contentChild,
        );

  /// The duration of the opening animation.
  final Duration animationDuration;

  /// The offset of the background blur effect.
  final Offset backgroundBlurOffset;

  /// The border radius applied to the background.
  final BorderRadius backgroundBorderRadius;

  /// The background color of the book.
  final Color? backgroundColor;

  /// The color of the shadow applied to the background.
  final Color? backgroundShadowColor;

  /// The blur radius applied to the background.
  final double blurRadius;

  /// The delegate responsible for building the animated content.
  final AnimatedContentDelegate contentDelegate;

  /// The widget representing the book cover.
  final Widget cover;

  /// The animation curve used for opening/closing the book.
  final Curve curve;

  /// Padding applied to the book.
  final EdgeInsets padding;

  /// The duration of the closing animation.
  final Duration reverseAnimationDuration;

  /// The size of the book.
  final Size size;

  /// How far the shadow is spread.
  final double spreadRadius;

  /// The horizontal flip direction applied to the book.
  final HorinzontalFlipDirection horinzontalFlipDirection;

  @override
  State<AnimatedBookWidget> createState() => _AnimatedBookWidgetState();
}

class _AnimatedBookWidgetState extends State<AnimatedBookWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation = animationController.curvedAnimation(
    curve: widget.curve,
  );

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
    reverseDuration: widget.reverseAnimationDuration,
  )..addStatusListener(statusListener);

  late Offset backgroundBlurOffset = widget.backgroundBlurOffset;
  late BorderRadius backgroundBorderRadius = widget.backgroundBorderRadius;
  late Color backgroundColor =
      widget.backgroundColor ?? context.theme.scaffoldBackgroundColor;

  late Color backgroundShadowColor = widget.backgroundShadowColor ??
      context.defaultTextStyle.color!.withOpacity(0.075);

  late double blurRadius = widget.blurRadius;
  AnimatedBookStatus bookStatus = AnimatedBookStatus.dismissed;
  late AnimatedContentDelegate contentDelegate = widget.contentDelegate;
  late Widget cover = widget.cover;
  late EdgeInsets padding = widget.padding;
  late Size size = widget.size;
  late double spreadRadius = widget.spreadRadius;
  late HorinzontalFlipDirection horinzontalFlipDirection =
      widget.horinzontalFlipDirection;
  late Matrix4 directionMatrix;

  @override
  Widget build(BuildContext context) {
    if (horinzontalFlipDirection == HorinzontalFlipDirection.left) {
      directionMatrix = Matrix4.identity()..scale(1.0, 1, 1);
    }
    if (horinzontalFlipDirection == HorinzontalFlipDirection.rigth) {
      directionMatrix = Matrix4.identity()..scale(-1.0, 1, 1);
    }

    return Padding(
      padding: padding,
      child: SizedBox.fromSize(
        size: size,
        child: GestureDetector(
          onTap: onPressed,
          child: Transform(
            transform: directionMatrix,
            alignment: Alignment.center,
            child: Stack(
              fit: StackFit.expand,
              children: [
                BackgroundBlur(
                  backgroundColor: backgroundColor,
                  backgroundShadowColor: backgroundShadowColor,
                  blurRadius: blurRadius,
                  spreadRadius: spreadRadius,
                  offset: backgroundBlurOffset,
                  borderRadius: backgroundBorderRadius,
                ),
                AnimatedContentWidget(
                  bookAnimation: animation,
                  delegate: contentDelegate,
                  borderRadius: backgroundBorderRadius,
                ),
                AnimatedCoverWidget(
                  listenable: animation,
                  cover: cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(AnimatedBookWidget oldWidget) {
    size = widget.size != size ? widget.size : size;
    cover = widget.cover != cover ? widget.cover : cover;
    contentDelegate = widget.contentDelegate != contentDelegate
        ? widget.contentDelegate
        : contentDelegate;
    padding = widget.padding != padding ? widget.padding : padding;
    backgroundColor = widget.backgroundColor != backgroundColor
        ? widget.backgroundColor ?? backgroundColor
        : backgroundColor;
    backgroundShadowColor =
        widget.backgroundShadowColor != backgroundShadowColor
            ? widget.backgroundShadowColor ?? backgroundShadowColor
            : backgroundShadowColor;
    blurRadius =
        widget.blurRadius != blurRadius ? widget.blurRadius : blurRadius;
    spreadRadius = widget.spreadRadius != spreadRadius
        ? widget.spreadRadius
        : spreadRadius;
    backgroundBlurOffset = widget.backgroundBlurOffset != backgroundBlurOffset
        ? widget.backgroundBlurOffset
        : backgroundBlurOffset;
    animationController
      ..duration = widget.animationDuration != oldWidget.animationDuration
          ? widget.animationDuration
          : animationController.duration
      ..reverseDuration =
          widget.reverseAnimationDuration != oldWidget.reverseAnimationDuration
              ? widget.reverseAnimationDuration
              : animationController.reverseDuration;
    animation = oldWidget.curve != widget.curve
        ? animationController.curvedAnimation(curve: widget.curve)
        : animation;
    backgroundBorderRadius =
        oldWidget.backgroundBorderRadius != widget.backgroundBorderRadius
            ? widget.backgroundBorderRadius
            : backgroundBorderRadius;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController
      ..removeStatusListener(statusListener)
      ..dispose();
    super.dispose();
  }

  void statusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        bookStatus = AnimatedBookStatus.dismissed;
      case AnimationStatus.completed:
        bookStatus = AnimatedBookStatus.completed;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        bookStatus = AnimatedBookStatus.animated;
    }
  }

  void onPressed() {
    switch (bookStatus) {
      case AnimatedBookStatus.dismissed:
        animationController.forward(from: 0);
      case AnimatedBookStatus.completed:
        animationController.reverse(from: 1);
      case AnimatedBookStatus.animated:
        break;
    }
  }
}
