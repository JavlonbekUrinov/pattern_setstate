import 'package:flutter/material.dart';
import 'pages/add_post.dart';
import 'pages/home_page.dart';
import 'pages/update_post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        AddPostPage.id: (context) => const AddPostPage(),
        UpdatePostPage.id: (context) => UpdatePostPage(),
      },
    );
  }
}
