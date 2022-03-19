import 'dart:async';

import 'package:flutter/widgets.dart';

typedef WaitHandler = FutureOr Function();

typedef WaitBuilder = Widget Function(
    BuildContext context, VoidCallback? onTap);

class HandleWaitBuilder extends StatefulWidget {
  final WaitHandler handler;
  final WaitBuilder builder;

  const HandleWaitBuilder({
    required this.handler,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _HandleWaitBuilderState createState() => _HandleWaitBuilderState();
}

class _HandleWaitBuilderState extends State<HandleWaitBuilder> {
  late ValueNotifier<bool> _blocked;

  @override
  void initState() {
    _blocked = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        return widget.builder(context, _onPressed());
      },
      valueListenable: _blocked,
    );
  }

  VoidCallback? _onPressed() {
    if (_blocked.value) {
      return null;
    }

    return () async {
      try {
        _blocked.value = true;
        await widget.handler();
        _blocked.value = false;
      } catch (e) {
        _blocked.value = false;
        rethrow;
      }
    };
  }
}
