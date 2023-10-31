import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold(
      {super.key, required this.body, this.bottomNavigationBar});
  final Widget body;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    final columns = getBreakpointEntry(context).columns;
    final flex = (columns - 6) ~/ 2;
    return Scaffold(
      body: Row(
        children: [
          if (flex > 0) Spacer(flex: flex),
          Expanded(flex: 6, child: body),
          if (flex > 0) Spacer(flex: flex),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
