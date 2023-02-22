import 'dart:ui';

import '../enums/flutter_sweet_alert_style.dart';
import '../typedef/flutter_sweet_alert_callback.dart';

class FlutterSweetAlertOptions {
  final String title;

  final String? subtitle;

  /// Callback when confirm or cancel button is pressed
  final FlutterSweetAlertOnPress? onPress;

  /// if null,
  /// default value is `SweetAlert.success` when `showCancelButton`=false
  /// and `SweetAlert.danger` when `showCancelButton` = true
  final Color? confirmButtonColor;

  /// if null,default value is `SweetAlert.cancel`
  final Color? cancelButtonColor;

  /// if null,default value is `SweetAlert.successText` when `showCancelButton`=false
  ///  and `SweetAlert.dangerText` when `showCancelButton` = true
  final String? confirmButtonText;

  /// if null,default value is `SweetAlert.cancelText`
  final String? cancelButtonText;

  /// If set to true, two buttons will be displayed.
  final bool showCancelButton;

  final FlutterSweetAlertStyle style;

  FlutterSweetAlertOptions({
    required this.title,
    required this.onPress,
    required this.style,
    required this.showCancelButton,
    this.subtitle,
    this.cancelButtonColor,
    this.cancelButtonText,
    this.confirmButtonColor,
    this.confirmButtonText,
  });
}
