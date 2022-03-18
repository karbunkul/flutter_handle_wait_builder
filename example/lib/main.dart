import 'package:flutter/material.dart';
import 'package:wait_builder/wait_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WaitBuilder(
          builder: (context, onTap) {
            return ElevatedButton(
              onPressed: onTap,
              child: onTap == null ? Text('...') : Text('123'),
            );
          },
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 1000));
          },
        ),
      ),
    );
  }
}
