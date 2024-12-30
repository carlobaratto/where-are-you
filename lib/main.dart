import 'package:flutter/material.dart';
import 'package:where_are_you/credits.dart';
import 'locationService.dart';
import 'location_page.dart';
import 'map.dart';
import 'settings.dart';
import 'globals.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  LocationService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Where are you?';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = global.selectedIndex;
  String name = '';
  String apiUrl = '';
  String apikey = '';

  static final List<Widget> _widgetOptions = <Widget>[
    const MyListScreenPosition(),
    const LocationPage(),
    const settings(),
    credits(),
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carica i dati da SharedPreferences
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      apiUrl = prefs.getString('api_url') ?? '';
      apikey = prefs.getString('apikey') ?? '';
    });
  }

  void _onItemTapped(int index) {
    if (index == 2){
      global.selectedIndex = 2;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: Column( // Usa Column o Row per fornire restrizioni
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Where are you\nOpen source location sharing software',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded( // Utilizza Expanded per occupare lo spazio rimanente
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: const Text('Map'),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      _onItemTapped(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Location tools'),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Settings'),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Credits'),
                    selected: _selectedIndex == 3,
                    onTap: () {
                      _onItemTapped(3);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}

