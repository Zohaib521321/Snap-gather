import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinTabChangeIndexController extends GetxController with GetTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  void onChange(int index) {
    selectedIndex.value = index;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  selectedIndex.close();
  }
}
