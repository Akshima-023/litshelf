import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:litshelf/screen/cart%20and%20checkout/locationformpage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/buildtag.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  int selectedIndex = 0;

  LatLng selectedLocation = LatLng(8.5241, 76.9366);

  String titleAddress = "Select location";
  String subAddress = "";

  @override
  void initState() {
    super.initState();
    getAddressFromLatLng(selectedLocation);
  }
  Future<void> saveAddress() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString("titleAddress", titleAddress);
  await prefs.setString("subAddress", subAddress);
  await prefs.setDouble("lat", selectedLocation.latitude);
  await prefs.setDouble("lng", selectedLocation.longitude);
  await prefs.setString(
    "type",
    selectedIndex == 0 ? "Home" : "Office",
  );
}

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        titleAddress = place.street ?? "Unknown place";
        subAddress =
            "${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        titleAddress = "Unable to get address";
        subAddress = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Location",
                        style: AppTextStyles.des18bb,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.1),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.30,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: selectedLocation,
                      initialZoom: 13,
                      onTap: (tapPosition, point) {
                        setState(() {
                          selectedLocation = point;
                        });

                        getAddressFromLatLng(point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.litshelf',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: selectedLocation,
                            width: size.width*0.03,
                            height: size.height*0.02,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.04),
              Text(
                "Detail Address",
                style: AppTextStyles.text16bb,
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on,
                      color: Colors.deepPurple),
                 SizedBox(width: size.width*0.08),

                  Expanded(
                    child: InkWell(onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationFormPage()
      ),
    );
    
  },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleAddress,
                            style: AppTextStyles.text16bb,
                          ),
                          Text(
                            subAddress,
                            style: AppTextStyles.text14g,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Container(
                            height: size.height * 0.001,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Save Address As",
                style: AppTextStyles.text16bb,
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  BuildTag(
                    text: "Home",
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  SizedBox(width: size.width * 0.02),
                  BuildTag(
                    text: "Office",
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),

              const Spacer(),
              PurpleButton(
             text: "Confirmation",
            onTap: () async {
           await saveAddress();
           ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
          content: Text("Address Saved Successfully"),
          ),
          );
          },
)
,SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}