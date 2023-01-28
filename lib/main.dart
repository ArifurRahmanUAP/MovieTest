
import 'package:flutter/material.dart';

import 'home/page/home_page.dart';
import 'home/resource/home_api_provider.dart';
import 'home/resource/home_api_repository.dart';

void main() {
  runApp(MyApp(
    repository: HomeApiRepository(ApiProvider()),
  ));
}

class MyApp extends StatelessWidget {
  final HomeApiRepository repository;

  const MyApp({required this.repository}) ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
