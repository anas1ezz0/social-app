import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_social_app/style/theme.dart';
import 'package:new_social_app/view/login_screen.dart';

import 'CashHelper/cash_helper.dart';
import 'const/const.dart';
import 'cubit/app_cubit.dart';
import 'dio/dio_helper.dart';
import 'firebase_options.dart';
import 'login_bloc/bloc_observ.dart';
import 'view/home_layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const HomePage();
  } else {
    widget = SocialLoginScreen();
  }
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // String? token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getPost(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: startWidget),
    );
  }
}
