import 'package:flutter/widgets.dart';

class Metrics {
  Metrics._();

  static final _Spacing spacing = _Spacing();
  static final _Layout layout = _Layout();
}

const _xxs = 4.0;
const _xs = 8.0;
const _sm = 12.0;
const _md = 16.0;
const _lg = 20.0;
const _xl = 24.0;
const _xxl = 28.0;

class _Spacing {
  double get xxs => _xxs;

  double get xs => _xs;

  double get sm => _sm;

  double get md => _md;

  double get lg => _lg;

  double get xl => _xl;

  double get xxl => _xxl;
}

class _Layout {
  EdgeInsets get noPadding => EdgeInsets.zero;

  EdgeInsets get xsPadding => const EdgeInsets.all(_xs);

  EdgeInsets get smPadding => const EdgeInsets.all(_sm);

  EdgeInsets get mdPadding => const EdgeInsets.all(_md);

  EdgeInsets get lgPadding => const EdgeInsets.all(_lg);

  EdgeInsets get xlPadding => const EdgeInsets.all(_xl);

  EdgeInsets get mdLeftRightPadding =>
      const EdgeInsets.fromLTRB(_md, 0, _md, 0);

  EdgeInsets get xsLeftRightPadding =>
      const EdgeInsets.fromLTRB(_xs, 0, _xs, 0);

  EdgeInsets get smTopBottomPadding =>
      const EdgeInsets.fromLTRB(0, _sm, 0, _sm);

  BorderRadius get cardBaseBorderRadius =>
      const BorderRadius.all(Radius.circular(20.0));
}
