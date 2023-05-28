import 'package:flutter/material.dart';
import 'package:wtf_gym/home/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:wtf_gym/home/viewModel/home_viewModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) =>  HomeViewModel(),),
    ],child: MaterialApp(
      title: 'Flutter Gym Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    ),);

  }
}
