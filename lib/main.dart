import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_fit/pages/intro_screen/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  runApp(const HealthFit());
}

class HealthFit extends StatelessWidget {
  const HealthFit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthFit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
