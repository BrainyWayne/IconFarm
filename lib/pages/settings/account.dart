import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(LineIcons.long_arrow_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.headset_mic),
            onPressed: () => Navigator.of(context).pushNamed('/help_center'),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
