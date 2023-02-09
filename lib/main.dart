import 'package:company_location_app/view/screens/details.dart';
import 'package:company_location_app/view/screens/homepage.dart';
import 'package:company_location_app/view/screens/location.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/":(context) => HomePage(),
      "details":(context) => DetailsPage(),
      "location":(context) => LocationPage(),
    },
  ));
}
