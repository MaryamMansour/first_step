import 'package:first_step/core/di/depndency_injection.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/core/networking/api_constants.dart';
import 'package:first_step/first_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/networking/fcm.dart';
import 'firebase_options.dart';
import 'core/routing/app_router.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

bool isUserLogged=false;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: ApiConstants.GEMINI_API_KEY);
  await Firebase.initializeApp();

  FcmManager fcmManager= FcmManager();
  await fcmManager.initFirebaseMessaging();

  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkIfUseLoggedIn();
  runApp(FirstStep(appRouter:
  AppRouter()));
}

checkIfUseLoggedIn() async{
  String? userToken=
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (userToken!=null && userToken.isNotEmpty) {
    isUserLogged=true;
  }
  else{
    isUserLogged=false;
  }

  }