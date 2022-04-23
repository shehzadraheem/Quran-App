
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


 void snackMessage(msg){
   Get.snackbar("Alert", msg,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.all(16));
}
