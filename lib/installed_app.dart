import 'dart:core';
import 'dart:core';

import 'package:app1/app_installation.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class Installed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Installed Apps Example")),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: const Text("Installed Apps"),
                subtitle: const Text(
                    "Get installed apps on device. With options to exclude system app, get app icon & matching package name prefix."),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstalledAppsScreen(),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ElevatedButton(
              child: Text('Install screen'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => app_launch(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class InstalledAppsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Installed Apps")),
      body: FutureBuilder<List<AppInfo>>(
        future: InstalledApps.getInstalledApps(true, true),
        builder:
            (BuildContext buildContext, AsyncSnapshot<List<AppInfo>> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        AppInfo app = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.memory(app.icon!),
                            ),
                            title: Text(app.name!),
                            subtitle: Text(app.getVersionInfo()),
                            onTap: () =>
                                InstalledApps.startApp(app.packageName!),
                            onLongPress: () =>
                                InstalledApps.openSettings(app.packageName!),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                          "Error occurred while getting installed apps ...."))
              : const Center(child: Text("Getting installed apps ...."));
        },
      ),
    );
  }
}

class AppInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Info")),
      body: FutureBuilder<AppInfo>(
        future: InstalledApps.getAppInfo("com.google.android.gm"),
        builder: (BuildContext buildContext, AsyncSnapshot<AppInfo> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? Center(
                      child: Column(
                        children: [
                          Image.memory(snapshot.data!.icon!),
                          Text(
                            snapshot.data!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          Text(snapshot.data!.getVersionInfo())
                        ],
                      ),
                    )
                  : Center(child: Text("Error while getting app info ...."))
              : Center(child: Text("Getting app info ...."));
        },
      ),
    );
  }
}
