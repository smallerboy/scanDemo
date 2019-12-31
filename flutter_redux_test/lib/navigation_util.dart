
import 'package:flutter/cupertino.dart';

class NavigatorUtil {
  static void pushPage(
      BuildContext context,
      Widget page,
      {
        String pageName,
        bool needLogin = false,
      })

  {
    if (context == null || page == null) return;
    Navigator.push(context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }
}

