import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:student_management_system/file_handling/settings.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingsPage> {
  String filePath = " ";

  @override
  void initState() {
    super.initState();
    _loadFilePath();
  }

  Future<void> _loadFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String filePath = prefs.getString("file_path") ?? "No file";
    setState(() {
      this.filePath = filePath;
    });
  }


  @override
  Widget build(BuildContext context) {
    _loadFilePath();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Settings(filePath: filePath, fileExtension: ".txt"),
    );
  }
}