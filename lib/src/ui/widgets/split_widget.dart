import 'package:flutter/widgets.dart' hide Split;
import 'package:devtools_app_shared/ui.dart';

class SplitWidget extends StatelessWidget {
  const SplitWidget({
    super.key,
    required this.axis,
    required this.children,
    required this.initialFractions,
  });

  final Axis axis;
  final List<Widget> children;
  final initialFractions;

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: axis,
      initialFractions: initialFractions,
      children: children,
    );
  }
}
