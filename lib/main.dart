import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghost_counter/app.dart';
import 'package:ghost_counter/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GhostCounterApp());
}
