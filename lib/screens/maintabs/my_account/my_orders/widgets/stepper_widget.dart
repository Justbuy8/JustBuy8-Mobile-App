// ignore_for_file: unnecessary_new, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  final double _width;
  final List<IconData> _icons;

  final int _curStep;
  final Color _activeColor;
  final Color? _inactiveColor = Colors.grey[100];
  final double lineWidth = 4.0;

  StepProgressView(
      {required List<IconData> icons,
      required int curStep,
      required double width,
      required Color color})
      : _icons = icons,
        _curStep = curStep,
        _width = width,
        _activeColor = color,
        assert(curStep > 0 == true && curStep <= icons.length),
        assert(width > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 24.0,
          right: 24.0,
        ),
        width: _width,
        child: Column(
          children: <Widget>[
            Row(
              children: _iconViews(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _icons.asMap().forEach((i, icon) {
      //colors according to state
      var circleColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

      var iconColor =
          (i == 0 || _curStep > i + 1) ? _inactiveColor : _activeColor;

      list.add(
        //dot with icon view
        Container(
          width: 35.0,
          height: 35.0,
          child: Icon(
            icon,
            color: iconColor,
            size: 22.0,
          ),
          decoration: new BoxDecoration(
            color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            border: new Border.all(
              color: _activeColor,
              width: 2.0,
            ),
          ),
        ),
      );

      //line between icons
      if (i != _icons.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }
}
