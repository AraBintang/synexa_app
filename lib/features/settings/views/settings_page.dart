import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: Column(
        children: [

          SwitchListTile(
            title: const Text(
              "Dark Mode",
            ),

            secondary: const Icon(
              Icons.dark_mode,
            ),

            value: darkMode,

            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Developer"),
            subtitle: Text("Ara Bintang"),
          ),

          const ListTile(
            leading: Icon(Icons.flutter_dash),
            title: Text("Framework"),
            subtitle: Text("Flutter"),
          ),

          const ListTile(
            leading: Icon(Icons.code),
            title: Text("Project"),
            subtitle: Text("Synexa"),
          ),
        ],
      ),
    );
  }
}