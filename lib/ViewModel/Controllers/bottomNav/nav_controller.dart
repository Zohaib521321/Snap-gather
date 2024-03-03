import 'package:get/get.dart';
class NavController extends GetxController{
  RxInt selectedIndex=0.obs;
  void changeIndex(int index){
    selectedIndex.value=index;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  selectedIndex.close();
  }
}