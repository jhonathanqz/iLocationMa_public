import 'package:flutter/widgets.dart';

class DialogButtonAction {
  DialogButtonAction(
    this.text, {
    @required this.type,
    @required this.onExecuted,
  });

  final String text;
  final DialogButtonActionType type;
  final VoidCallback onExecuted;
}

enum DialogButtonActionType {
  destructive,
  positive,
  neutral,
}

extension DialogButtonActionTypeEx<T> on DialogButtonActionType {
  T when({
    T destructive,
    T positive,
    T neutral,
  }) {
    if (this == DialogButtonActionType.destructive) return destructive;
    if (this == DialogButtonActionType.positive) return positive;
    return neutral;
  }
}

DialogButtonAction destructiveAction(String text, [VoidCallback onExecuted]) =>
    DialogButtonAction(
      text,
      type: DialogButtonActionType.destructive,
      onExecuted: onExecuted,
    );

DialogButtonAction positiveAction(String text, [VoidCallback onExecuted]) =>
    DialogButtonAction(
      text,
      type: DialogButtonActionType.positive,
      onExecuted: onExecuted,
    );

DialogButtonAction neutralAction(String text, [VoidCallback onExecuted]) =>
    DialogButtonAction(
      text,
      type: DialogButtonActionType.neutral,
      onExecuted: onExecuted,
    );
