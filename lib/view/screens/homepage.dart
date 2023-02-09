import 'dart:math';

import 'package:company_location_app/helper/ceo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  locationpermission() async {
    PermissionStatus status = await Permission.location.request();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${status}"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationpermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView.builder(
            itemCount: Company.length,
            itemBuilder: (context, i) {
              return Card(
                shadowColor: Colors.grey,
                child: ListTile(
                  isThreeLine: true,
                  onTap: () {
                    Navigator.pushNamed(context, "details",
                        arguments: Company[i]);
                  },
                  title: Text(Company[i]["comapany"]),
                  leading: Container(
                      height: 40,
                      width: 50,
                      child: Image.network(Company[i]["logo"])),
                  subtitle: Text(Company[i]["Ceo"]),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(Company[i]["image"]),
                    radius: 30,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
