import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class mainDrawer extends StatefulWidget {
  @override
  _mainDrawerState createState() => _mainDrawerState();
}

class _mainDrawerState extends State<mainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xff1fbfb7),
                    child: Text(
                      'Ahmed'.toUpperCase().substring(0, 1) +
                          'Afridee'.toUpperCase().substring(0, 1),
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Text(
                      'Ahmed Afridee',
                      style: TextStyle(color: Color(0xff1fbfb7), fontSize: 24),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(color: Color(0xff1fbfb7)),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(
                    'Music',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.movie),
                  title: Text(
                    'Movie',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(
                    'Shopping',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.apps),
                  title: Text(
                    'Apps',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.note),
                  title: Text(
                    'Docs',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () async {},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Setting',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () async {},
                ),
                ListTile(
                  leading: Icon(Icons.report),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () async {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onTap: () async {},
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
