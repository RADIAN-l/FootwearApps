import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/user/user.dart';
import '../pages/home-page.dart';
import 'login_controller.dart';

class PurchaseController extends GetxController{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName='';
  String orderAddress='';

  void onInit() {
    orderCollection = firestore.collection('orders');

    super.onInit();
  }

  submitOrder({
    required double price,
    required String item,
    required String description
}){
    orderPrice=price;
    itemName=item;
    orderAddress = addressController.text;
    orderSuccess(orderAddress: orderAddress);
  }

  Future<void> orderSuccess({required String ? orderAddress}) async{
    User ? loginUse = Get.find<LoginController>().loginUser;
    try{
      if(orderAddress!=null){
        DocumentReference documentReference = await orderCollection.add(
          {
            'customer':loginUse?.name ?? "",
            'phone':loginUse?.number ?? "",
            'item':itemName,
            'price':orderPrice,
            'address':orderAddress,
            'dateTime':DateTime.now().toString(),
          }
        );
        Get.to(HomePage());
        Get.snackbar('Success', "You order is successful");
      }else{
        Get.snackbar('failure', 'Your order is unsuccessful');
      }
    }catch(error){
      Get.snackbar('Error', 'Error:$error');
    }
  }

}