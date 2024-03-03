import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class JoinParallaxController extends GetxController {
  RxDouble pageOffset = 0.0.obs;
  void updatePageOffset(
    JoinParallaxController offsetController,
    PageController pageController,
    int index,
  ) {
    if (pageController.position.haveDimensions) {
      offsetController.pageOffset.value = pageController.page! - index;
    }
  }

  double calculateGauss(double pageOffsetValue) {
    return math.exp(-(math.pow(pageOffsetValue.abs() - 0.5, 2) / 0.08));
  }
}
