import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'platform_info.dart';

typedef PlatformBuilder<T> = T Function(BuildContext context);

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  PlatformWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isAndroid(context)) {
      return createAndroidWidget(context);
    } else if (isIOS(context)) {
      return createIosWidget(context);
    }

    return throw UnsupportedError(
      'This platform is not supported: $defaultTargetPlatform',
    );
  }

  A createAndroidWidget(BuildContext context);

  I createIosWidget(BuildContext context);
}
