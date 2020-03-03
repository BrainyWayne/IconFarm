import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:iconfarm/services/firebase_auth.dart';

import 'package:iconfarm/services/settings_provider.dart';

class Preferences extends StatelessWidget {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    SettingsProvider _prefs = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Preferences'),
        centerTitle: true,
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
        children: <Widget>[
          ListTile(
            title: Text('Dark Mode'),
            subtitle: Text('For low light conditions'),
            trailing: Switch.adaptive(
              onChanged: (bool value) => _prefs.darkMode = value,
              value: _prefs.darkMode,
            ),
          ),
          ListTile(
            title: Text('Notifications'),
            subtitle: Text('subscribe to receive notifications'),
            trailing: Switch.adaptive(
              onChanged: (bool value) => _prefs.enableNotification = value,
              value: _prefs.enableNotification,
            ),
          ),
          ListTile(
            title: Text('Delete User Informations'),
            subtitle: Text('This will delete all your data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Warning'),
                  content: Text(
                    'Proceeding will delete your account informations from our system but a backup of it will be kept for 3 months before permanent deletion ',
                    style: _theme.textTheme.body1.copyWith(
                      height: 1.5,
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () =>
                          _auth.deleteUserProfile().then((onValue) {
                        Navigator.of(context).pushNamed('/login');
                      }),
                      child: Text('CANCEL'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('PROCEED'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
