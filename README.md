![banner](https://i.imgur.com/ppKK1L0.jpeg)

# Flutter Animated Book Widget

![build](https://github.com/the-d-velopers/animated_book_widget/actions/workflows/code_metrics.yml/badge.svg)
[![animated_book_widget](https://img.shields.io/pub/v/animated_book_widget?label=animated_book_widget)](https://pub.dev/packages/animated_book_widget)

A Flutter package allows you to effortlessly create a animated book widget UI with dynamic content rendering.

## Preview

<img src="https://github.com/the-d-velopers/animated_book_widget/blob/main/screenshots/animated_book_widget.gif?raw=true" width="250" height="470" />

<img src="https://github.com/the-d-velopers/animated_book_widget/blob/main/screenshots/animated_book_widget1.gif?raw=true" width="250" height="470" />

## Installation 
Add `animated_book_widget` to your `pubspec.yaml` dependencies. And import it:

```dart
dependencies:
    animated_book_widget: <latest_version>
```
Import:

```dart
import 'package:animated_book_widget/animated_book_widget.dart';
```

## How to use

```dart   
AnimatedBookWidget(
  cover: _Cover,
  content: _Content,
  size: const Size.fromWidth(160),
);
``` 

## Params

```dart   
AnimatedBookWidget(
  cover: _Cover,
  content: _Content,
  size: const Size.fromWidth(160),
  padding: const EdgeInsets.only(right: 10),
  blurRadius: 8,
  spreadRadius: .1,
  backgroundBlurOffset: Offset.zero,
  backgroundColor: color.withOpacity(.5),
  backgroundShadowColor: color.withOpacity(.075),
  curve: Curves.linear,
  animationDuration: Duration(milliseconds: 500),
  reverseAnimationDuration: Duration(milliseconds: 500),
);
``` 

## Builder

```dart   
AnimatedBookWidget.builder(
  cover: _Cover,
  size: Size(200, 300),
  contentChild: _Content,
  contentBuilder: (context, animation, child) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(animation.value),
      alignment: Alignment.center,
      child: child,
    );
  },
);
``` 

## Examples

Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.

## Credit

- This package's book animation is inspired from this [Dribbble](https://dribbble.com/shots/6607801-) art.

## Main Contributors

<a href="https://github.com/the-d-velopers/animated_book_widget/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=the-d-velopers/animated_book_widget" />
</a>

## Awesome Mobile Libraries
- Check out our other available [d-veloper libraries](https://github.com/the-d-velopers)


## License

```
MIT License

Copyright (c) 2024 D-velopers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
