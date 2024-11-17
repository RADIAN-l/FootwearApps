import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/login_controller.dart';
import '../widgets/otp_txt_field.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Create Your Account!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: ctrl.registerNameCtrl,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefix: Icon(Icons.phone_android),
                  labelText: 'Your Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: ctrl.registerNumberCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefix: Icon(Icons.phone_android),
                  labelText: 'Mobile Number',
                  hintText: 'Enter Your Mobile Number',
                ),
              ),
              SizedBox(height: 20,),
              OtpTextField(otpController: ctrl.otpController,visible: ctrl.otpFieldShow,
                onComplete: (otp) {
                  ctrl.otpEnter = int.tryParse(otp ?? '0000');
                },),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                if(ctrl.otpFieldShow){
                  ctrl.addUser();
                }else{
                  ctrl.sendOtp();
                }
              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(ctrl.otpFieldShow ? 'Register' :'Send OTP')
              ),
              SizedBox(height: 10),
              TextButton(onPressed: () {
                Get.to(LoginPage());
              },
                child: Text(
                  'Login', style: TextStyle(color: Colors.deepPurple),),
              ),
            ],
          ),
        ),
      );
    });
  }
}

