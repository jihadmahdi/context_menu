import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'context_menu.dart';
import 'context_menu_builder.dart';

/// Show a [ContextMenu] on the given [BuildContext]. For other parameters, see [ContextMenu].
void showContextMenu(
  Offset offset,
  BuildContext context,
  ContextMenuBuilder builder,
  verticalPadding,
  width,
) {
  showModal(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (context) => ContextMenu(
      position: offset,
      builder: builder,
      verticalPadding: verticalPadding,
      width: width,
    ),
  );
}

/// The [ContextMenuArea] is the way to use a [ContextMenu]
///
/// It listens for right click and long press and executes [showContextMenu]
/// with the corresponding location [Offset].

class ContextMenuArea extends StatelessWidget {
  final Widget child;
  final ContextMenuBuilder builder;
  final double verticalPadding;
  final double width;
  final VoidCallback? onSecondaryTapDown;

  const ContextMenuArea({
    Key? key,
    required this.child,
    required this.builder,
    this.verticalPadding = 8,
    this.width = 320,
    this.onSecondaryTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        onSecondaryTapDown?.call();
        showContextMenu(
          details.globalPosition,
          context,
          builder,
          verticalPadding,
          width,
        );
      },
      onLongPressStart: (details) {
        onSecondaryTapDown?.call();
        showContextMenu(
          details.globalPosition,
          context,
          builder,
          verticalPadding,
          width,
        );
      },
      child: child,
    );
  }
}
