library flutter_sweet_alert;

import 'package:flutter/material.dart';

import 'src/cancel.dart';
import 'src/confirm.dart';
import 'src/enums/flutter_sweet_alert_style.dart';
import 'src/models/flutter_sweet_alert_options.dart';
import 'src/success.dart';
import 'src/typedef/flutter_sweet_alert_callback.dart';

export 'src/enums/flutter_sweet_alert_style.dart';
export 'src/typedef/flutter_sweet_alert_callback.dart';

class FlutterSweetAlertDialog extends StatefulWidget {
  /// animation curve when showing,if null,default value is `SweetAlert.showCurve`
  final Curve? curve;

  final FlutterSweetAlertOptions options;

  FlutterSweetAlertDialog({
    required this.options,
    this.curve,
  });

  @override
  State<StatefulWidget> createState() {
    return new FlutterSweetAlertDialogState();
  }
}

class FlutterSweetAlertDialogState extends State<FlutterSweetAlertDialog>
    with SingleTickerProviderStateMixin, FlutterSweetAlert {
  late AnimationController controller;

  late Animation<double> tween;

  late FlutterSweetAlertOptions _options;

  @override
  void initState() {
    _options = widget.options;
    controller = new AnimationController(vsync: this);
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(
      1.0,
      duration: new Duration(milliseconds: 300),
      curve: widget.curve ?? FlutterSweetAlert.showCurve,
    );

    FlutterSweetAlert._state = this;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    FlutterSweetAlert._state = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(FlutterSweetAlertDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void confirm() {
    if (_options.onPress != null && _options.onPress!(true) == false) return;
    Navigator.pop(context);
  }

  void cancel() {
    if (_options.onPress != null && _options.onPress!(false) == false) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfChildren = [];

    switch (_options.style) {
      case FlutterSweetAlertStyle.success:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new SuccessView(),
        ));
        break;
      case FlutterSweetAlertStyle.confirm:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new ConfirmView(),
        ));
        break;
      case FlutterSweetAlertStyle.error:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new CancelView(),
        ));
        break;
      case FlutterSweetAlertStyle.loading:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        ));
        break;
    }

    listOfChildren.add(
      new Text(
        _options.title,
        style: new TextStyle(
          fontSize: 25.0,
          color: new Color(0xff575757),
        ),
      ),
    );

    listOfChildren.add(
      new Padding(
        padding: new EdgeInsets.only(top: 10.0),
        child: new Text(
          _options.subtitle ?? '',
          style: new TextStyle(
            fontSize: 16.0,
            color: new Color(0xff797979),
          ),
        ),
      ),
    );

    //we do not render buttons when style=loading
    if (_options.style != FlutterSweetAlertStyle.loading) {
      if (_options.showCancelButton) {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.only(top: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new ElevatedButton(
                onPressed: cancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _options.cancelButtonColor ??
                      FlutterSweetAlert.cancel, // Background color
                ),
                child: new Text(
                  _options.cancelButtonText ?? FlutterSweetAlert.cancelText,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              new SizedBox(
                width: 10.0,
              ),
              new ElevatedButton(
                onPressed: confirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _options.confirmButtonColor ??
                      FlutterSweetAlert.danger, // Background color
                ),
                child: new Text(
                  _options.confirmButtonText ?? FlutterSweetAlert.confirmText,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ));
      } else {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.only(top: 10.0),
          child: new ElevatedButton(
            onPressed: confirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: _options.confirmButtonColor ??
                  FlutterSweetAlert.success, // Background color
            ),
            child: new Text(
              _options.confirmButtonText ?? FlutterSweetAlert.successText,
              style: new TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ));
      }
    }

    return new Center(
        child: new AnimatedBuilder(
            animation: controller,
            builder: (c, w) {
              return new ScaleTransition(
                scale: tween,
                child: new ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  child: new Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: listOfChildren,
                        ),
                      )),
                ),
              );
            }));
  }

  void update(FlutterSweetAlertOptions options) {
    setState(() {
      _options = options;
    });
  }
}

abstract class FlutterSweetAlert {
  static Color success = new Color(0xffAEDEF4);
  static Color danger = new Color(0xffDD6B55);
  static Color cancel = new Color(0xffD0D0D0);

  static String successText = "OK";
  static String confirmText = "Confirm";
  static String cancelText = "Cancel";

  static Curve showCurve = Curves.bounceOut;

  static FlutterSweetAlertDialogState? _state;

  static void show({
    required BuildContext context,
    required String title,
    required FlutterSweetAlertStyle style,
    required FlutterSweetAlertOnPress? onPress,
    String? subtitle,
    bool showCancelButton = false,
    Color? cancelButtonColor,
    Color? confirmButtonColor,
    String? cancelButtonText,
    String? confirmButtonText,
    Curve? curve,
  }) {
    FlutterSweetAlertOptions options = new FlutterSweetAlertOptions(
      showCancelButton: showCancelButton,
      title: title,
      subtitle: subtitle,
      style: style,
      onPress: onPress,
      confirmButtonColor: confirmButtonColor,
      confirmButtonText: confirmButtonText,
      cancelButtonText: cancelButtonText,
      cancelButtonColor: confirmButtonColor,
    );
    if (_state != null) {
      _state?.update(options);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new Container(
              color: Colors.transparent,
              child: new Padding(
                padding: new EdgeInsets.all(40.0),
                child: new Scaffold(
                  backgroundColor: Colors.transparent,
                  body: new FlutterSweetAlertDialog(
                    curve: curve,
                    options: options,
                  ),
                ),
              ),
            );
          });
    }
  }
}
