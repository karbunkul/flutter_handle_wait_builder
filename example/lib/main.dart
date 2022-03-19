import 'package:flutter/material.dart';
import 'package:handle_wait_builder/handle_wait_builder.dart';

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
        child: HandleWaitBuilder(
          handler: () => Future.delayed(const Duration(milliseconds: 2000)),
          // handler: () => Future.delayed(const Duration(milliseconds: 2000),
          //     () => throw UnimplementedError()),
          builder: (context, onTap) {
            return ElevatedButton(
              onPressed: onTap,
              child: onTap == null ? const Text('...') : const Text('CLICK'),
            );
          },
        ),
      ),
    );
  }
}
