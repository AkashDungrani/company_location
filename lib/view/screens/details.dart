import 'package:company_location_app/helper/ceo.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Placemark? placemarks;
  
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> akash =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text("${akash["comapany"]} Details"),
      ),
      body: StreamBuilder(
        stream: Geolocator.getPositionStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Position? data = snapshot.data;
            placemarkFromCoordinates(akash["latitude"], akash["longitude"])
                .then((List<Placemark> placemark) {
              setState(() {
                placemarks = placemark[0];
              });
            });
            return (data != null)
                ? SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                        
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        NetworkImage(akash["image"])),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      akash["Ceo"],
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "CEO",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "Company Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(akash["logo"]),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    akash["comapany"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: Text(
                              "Company Description",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87),
                            )),
                            SizedBox(height: 10,),
                            Text(akash["description"]),
                          SizedBox(height: 20,),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: Text(
                              "Company Address",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87),
                            )),
                            SizedBox(height: 10,),
                
                            Text(
                                "Name : ${(placemarks != null) ? placemarks!.name : Container()}"),
                            Text(
                                "Street : ${(placemarks != null) ? placemarks!.street : Container()}"),
                            Text(
                                "Locality : ${(placemarks != null) ? placemarks!.locality : Container()}"),
                            Text(
                                "Country : ${(placemarks != null) ? placemarks!.country : Container()}"),
                            Text(
                                "Postal Code : ${(placemarks != null) ? placemarks!.postalCode : Container()}"),
                            Text(
                                "Administrative : ${(placemarks != null) ? placemarks!.administrativeArea : Container()}"),
                            Text(
                                "Thoroughfare : ${(placemarks != null) ? placemarks!.thoroughfare : Container()}"),
                
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "location",
                                      arguments: akash);
                                },
                                child: Text("Go To Map"))
                          ]),
                    ),
                )
                : Center(
                    child: Text("Data Not FOund!!!!!!!!!"),
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
