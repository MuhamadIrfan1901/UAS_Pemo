import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard.dart';
import 'setting.dart';
import 'users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BottomNavigationBarProvider()),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Product'),
              onTap: () {
                Provider.of<BottomNavigationBarProvider>(context, listen: false).currentIndex = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Category'),
              onTap: () {
                Provider.of<BottomNavigationBarProvider>(context, listen: false).currentIndex = 1;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Tag'),
              onTap: () {
                Provider.of<BottomNavigationBarProvider>(context, listen: false).currentIndex = 2;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getPage(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _getPage(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);
    switch (provider.currentIndex) {
      case 0:
        return ProfileScreen();
      case 1:
        return HomeScreen();
      case 2:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);
    return BottomNavigationBar(
      currentIndex: provider.currentIndex,
      onTap: (index) => provider.currentIndex = index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
