class Fonts {
  Fonts._();

  static final _Heading1 heading1 = _Heading1();
  static final _Heading2 heading2 = _Heading2();
  static final _Heading3 heading3 = _Heading3();
  static final _Heading4 heading4 = _Heading4();
  static final _Heading5 heading5 = _Heading5();
  static final _Heading6 heading6 = _Heading6();

  static final _Body body = _Body();

  static final _SubTitle1 subTitle1 = _SubTitle1();
  static final _SubTitle2 subTitle2 = _SubTitle2();

  static final _Link link = _Link();
}

class _Heading1 {
  final double textSize = 28.0;
}

class _Heading2 {
  final double textSize = 25.0;
}

class _Heading3 {
  final double textSize = 20.0;
}

class _Heading4 {
  final double textSize = 18.0;
}

class _Heading5 {
  final double textSize = 16.0;
}

class _Heading6 {
  final double textSize = 14.0;
}

class _Body {
  final _BodyTextSize textSize = _BodyTextSize();
}

class _BodyTextSize {
  final double xs = 12.0;
  final double sm = 14.0;
  final double md = 16.0;
  final double lg = 18.0;
  final double xl = 20.0;
}

class _SubTitle1 {
  final double textSize = 20.0;
}

class _SubTitle2 {
  final double textSize = 18.0;
}

class _Link {
  final double textSize = 14.0;
}
