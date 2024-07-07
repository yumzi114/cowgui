import 'dart:io' show Platform;
import 'package:cowtest/src/rust/api/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'assets.dart';
import 'title_screen/title_screen.dart';
// import 'package:window_size/window_size.dart';
import 'package:cowtest/src/rust/api/simple.dart';
import 'package:cowtest/src/rust/frb_generated.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<void> main() async {
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.setFullScreen(true);
  Animate.restartOnHotReload = true;
  // if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   setWindowTitle("TESTTT");
  //   // setWindowMinSize(const Size(800, 500));
  // }

  // runApp(const MyApp());
  runApp(
    FutureProvider<FragmentPrograms?>(
      create: (context) => loadFragmentPrograms(),
      initialData: null,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const TitleScreen(),
      // home: Scaffold(
      //   appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
      //   body: Center(
      //     child: Text(
      //         'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`'),
      //   ),
      // ),
    );
  }
}
