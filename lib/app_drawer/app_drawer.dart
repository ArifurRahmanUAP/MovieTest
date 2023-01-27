import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movietest/bookmarks/page/bookmark_page.dart';
import 'package:movietest/home/page/home_page.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppDrawarState();
}

class AppDrawarState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 60,),

            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              },
            ),
            ListTile(
              title: const Text('Bookmarks',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const BookmarkPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
