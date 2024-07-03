import 'package:first_step/core/routing/routes.dart';
import 'package:first_step/features/chat/ui/chat_screen.dart';
import 'package:first_step/features/chatbot/ui/screen/chatbot_screen.dart';
import 'package:first_step/features/chatbot/ui/screen/selection_Screen.dart';
import 'package:first_step/features/home/logic/home_cubit.dart';
import 'package:first_step/features/home/ui/home_layout_screen.dart';
import 'package:first_step/features/profile/logic/profile_cubit.dart';
import 'package:first_step/features/profile/ui/screens/profile_screen.dart';
import 'package:first_step/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/SignUp/logic/cubit/sign_up_cubit.dart';
import '../../features/SignUp/ui/screen/signup_screen.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/login/ui/screen/login_screen.dart';
import '../../features/profile/ui/screens/change_password.dart';
import '../../features/profile/ui/screens/profile_details.dart';
import '../../features/project/ui/screens/upload_screen.dart';
import '../di/depndency_injection.dart';

class AppRouter {
  Route generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child:  ProfileScreen(),
          ),
        );
      case Routes.profileDetailsScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (context) => getIt<ProfileCubit>()..getProfile(),
          child:  ProfileDetailsScreen(),
        ),);
        case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (context) => getIt<ProfileCubit>(),
          child:  ChangePasswordScreen(),
        ),);
        case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => ChatScreen(),);

        case Routes.chatbotSelectionScreen:
        return MaterialPageRoute(builder: (_) => SelectionScreen(),);

        case Routes.chatbotScreen:
        return MaterialPageRoute(builder: (_) => ChatbotScreen(),);

        case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_) =>  BlocProvider(
              create: (context) => getIt<HomeCubit>(),
              child:  HomeScreen(),
            ));

        case Routes.uploadScreen:
        return MaterialPageRoute(builder: (_) => UploadScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Text("ERROR"),
                ));
     }
  }
}
