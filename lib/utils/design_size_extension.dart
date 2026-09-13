import 'package:flutter/widgets.dart';

/// 將設計稿（以 375px 寬為基準）的尺寸換算成目前螢幕的 logical pixels。
///
/// 例如：`SizedBox(width: 50.w(context), height: 50.w(context))`。
extension DesignSizeExtension on num {
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  /// 依螢幕寬度換算，適合元件的寬度、間距和正方形尺寸。
  double w(BuildContext context) =>
      toDouble() * MediaQuery.sizeOf(context).width / _designWidth;

  /// 依螢幕高度換算，適合需要依設計稿高度定位的垂直尺寸。
  double h(BuildContext context) =>
      toDouble() * MediaQuery.sizeOf(context).height / _designHeight;
}
