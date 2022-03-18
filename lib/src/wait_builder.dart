import 'package:flutter/widgets.dart';

typedef WaitChildBuilder = Widget Function(
    BuildContext context, VoidCallback? onTap);

class WaitBuilder extends StatefulWidget {
  final VoidCallback onTap;
  final WaitChildBuilder builder;

  const WaitBuilder({
    required this.onTap,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _WaitBuilderState createState() => _WaitBuilderState();
}

class _WaitBuilderState extends State<WaitBuilder> {
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
      _blocked.value = true;
      await Future.delayed(Duration.zero, widget.onTap);
      _blocked.value = false;
    };
  }
}
