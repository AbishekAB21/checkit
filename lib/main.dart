import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/common/methods/notification_service.dart';
import 'package:checkit/features/splash/container/splash_screen_container.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  if(await Permission.notification.isDenied){
    await Permission.notification.request();
  }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'Check It!',
      debugShowCheckedModeBanner: false,
      home: const SplashScreenContainer(),
    );
  }
}
