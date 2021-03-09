import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'fonts.dart';
import 'metrics.dart';
import 'named_colors.dart';

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: unnecessary_getters_setters

class Style {
  static FlavorStyle _current;

  static FlavorStyle get current => _current ?? FlavorStyle();

  static set current(FlavorStyle value) => _current = value;
}

class FlavorStyle {
  FlavorStyle({
    Color appBarColor = NamedColors.weirdPeacock,
    Color backgroundColor = NamedColors.scruffyPorcelain,
    Color positiveButtonColor = NamedColors.weirdPeacock,
    Color neutralButtonColor = NamedColors.compensatoryPearl,
    Color textColor = NamedColors.unsupportedEarth,
    Color contrastTextColor = NamedColors.white,
    Color headingTextColor = NamedColors.white,
    Color dividerColor = NamedColors.compensatoryPearl,
    Color tabBarActiveColor = NamedColors.white,
    Color tabBarInactiveColor = NamedColors.semiTransparentWhite,
    Color destructiveTextColor = NamedColors.invigoratingHazel,
  })  : appBar = _AppBar(appBarColor),
        background = _Background(backgroundColor),
        button = _Button(positiveButtonColor, neutralButtonColor),
        text = _Text(textColor, contrastTextColor, headingTextColor),
        divider = _Divider(dividerColor),
        tabBar = _TabBar(tabBarActiveColor, tabBarInactiveColor),
        dialog = _Dialog(destructiveTextColor);

  final _AppBar appBar;
  final _Background background;
  final _Button button;
  final _Text text;
  final _Divider divider;
  final _TabBar tabBar;
  final _Dialog dialog;
}

class _AppBar {
  _AppBar(this.color);

  final Color color;
}

class _Background {
  _Background(this.color);

  final Color color;
}

class _Button {
  _Button(this.positiveColor, this.neutralColor);

  final Color positiveColor;
  final Color neutralColor;

  final BorderRadius borderRadius = BorderRadius.circular(12.0);
  final EdgeInsets padding = Metrics.layout.mdPadding;

  final TextStyle textStyle = TextStyle(fontSize: Fonts.body.textSize.lg);
}

class _Text {
  _Text(
    this.color,
    this.contrastColor,
    this.headingTextColor,
  )   : xsTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.xs,
          color: color,
        ),
        smTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.sm,
          color: color,
        ),
        mdTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.md,
          color: color,
        ),
        lgTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.lg,
          color: color,
        ),
        xlTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.xl,
          color: color,
        ),
        mdBoldTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.md,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        lgBoldTextStyle = TextStyle(
          fontSize: Fonts.body.textSize.lg,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        boldTextStyle = TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
        italicTextStyle = TextStyle(
          fontStyle: FontStyle.italic,
          color: color,
        ),
        heading1TextStyle = TextStyle(
          fontSize: Fonts.heading1.textSize,
          fontWeight: FontWeight.bold,
          color: headingTextColor,
        ),
        heading2TextStyle = TextStyle(
          fontSize: Fonts.heading2.textSize,
          fontWeight: FontWeight.bold,
          color: headingTextColor,
        ),
        heading3TextStyle = TextStyle(
          fontSize: Fonts.heading3.textSize,
          fontWeight: FontWeight.bold,
          color: headingTextColor,
        ),
        heading4TextStyle = TextStyle(
          fontSize: Fonts.heading4.textSize,
          fontWeight: FontWeight.bold,
          color: headingTextColor,
        ),
        heading5TextStyle = TextStyle(
          fontSize: Fonts.heading5.textSize,
          fontWeight: FontWeight.bold,
        );

  final Color color;
  final Color contrastColor;
  final Color headingTextColor;

  final TextStyle xsTextStyle;
  final TextStyle smTextStyle;
  final TextStyle mdTextStyle;
  final TextStyle lgTextStyle;
  final TextStyle xlTextStyle;

  final TextStyle mdBoldTextStyle;
  final TextStyle lgBoldTextStyle;

  final TextStyle boldTextStyle;
  final TextStyle italicTextStyle;

  final TextStyle heading1TextStyle;
  final TextStyle heading2TextStyle;
  final TextStyle heading3TextStyle;
  final TextStyle heading4TextStyle;
  final TextStyle heading5TextStyle;
}

class _Divider {
  _Divider(this.color);

  final Color color;
}

class _TabBar {
  _TabBar(this.activeColor, this.inactiveColor);

  final Color activeColor;
  final Color inactiveColor;
}

class _Dialog {
  _Dialog(this.destructiveTextColor);

  final Color destructiveTextColor;
}
