import 'package:first_step/core/di/depndency_injection.dart';
import 'package:first_step/core/helper/constants.dart';
import 'package:first_step/core/helper/shared_pref.dart';
import 'package:first_step/first_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/routing/app_router.dart';

bool isUserLogged=false;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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