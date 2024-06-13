import 'package:first_step/core/di/depndency_injection.dart';
import 'package:first_step/first_step.dart';
import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';

void main() {
  setupGetIt();
  runApp(FirstStep(appRouter:
  AppRouter()));
}
