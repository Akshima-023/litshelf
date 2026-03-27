import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:litshelf/screen/cart%20and%20checkout/locationformpage.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/buildtag.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';


class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  LatLng selectedLocation = LatLng(11.2588, 75.7804);

  String titleAddress = "Tap to add address";
  String subAddress = "";

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadAddressByType(); // ✅ ONLY THIS
  }

  // ✅ LOAD BASED ON HOME / OFFICE
  void loadAddressByType() async {
    final prefs = await SharedPreferences.getInstance();

    String type = selectedIndex == 0 ? "home" : "office";

    setState(() {
      titleAddress =
          prefs.getString("${type}_street") ?? "Tap to add address";
      subAddress = prefs.getString("${type}_sub") ?? "";
    });

    // ✅ Move map to saved location
    if (titleAddress != "Tap to add address") {
      try {
        List<Location> locations =
            await locationFromAddress(titleAddress);

        if (locations.isNotEmpty) {
          setState(() {
            selectedLocation = LatLng(
              locations.first.latitude,
              locations.first.longitude,
            );
          });
        }
      } catch (e) {}
    }
  }

  // ✅ MAP CLICK → GET ADDRESS + SAVE
  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      String street = place.street ?? "Unknown place";
      String sub =
          "${place.locality}, ${place.administrativeArea}, ${place.country}";

      String type = selectedIndex == 0 ? "home" : "office";

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("${type}_street", street);
      await prefs.setString("${type}_sub", sub);

      setState(() {
        titleAddress = street;
        subAddress = sub;
      });
    } catch (e) {
      setState(() {
        titleAddress = "Unable to get address";
        subAddress = "";
      });
    }
  }

  // ✅ SAVE BUTTON
  Future<void> saveAddress() async {
    final prefs = await SharedPreferences.getInstance();

    String type = selectedIndex == 0 ? "home" : "office";

    await prefs.setString("${type}_street", titleAddress);
    await prefs.setString("${type}_sub", subAddress);
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

              // 🔹 HEADER
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

              // 🔹 MAP
              SizedBox(
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
                            width: 40,
                            height: 40,
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

              Text("Detail Address", style: AppTextStyles.text16bb),

              SizedBox(height: size.height * 0.03),

              // 🔹 ADDRESS DISPLAY
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Colors.deepPurple),
                  SizedBox(width: size.width * 0.08),

                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LocationFormPage(),
                          ),
                        );

                        if (result == "home") {
                          setState(() => selectedIndex = 0);
                        } else if (result == "office") {
                          setState(() => selectedIndex = 1);
                        }

                        loadAddressByType(); // 🔥 refresh
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(titleAddress,
                              style: AppTextStyles.text16bb),
                          Text(subAddress,
                              style: AppTextStyles.text14g),

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

              Text("Save Address As", style: AppTextStyles.text16bb),

              SizedBox(height: size.height * 0.02),

              Row(
                children: [
                  BuildTag(
                    text: "Home",
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      setState(() => selectedIndex = 0);
                      loadAddressByType();
                    },
                  ),
                  SizedBox(width: size.width * 0.02),
                  BuildTag(
                    text: "Office",
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setState(() => selectedIndex = 1);
                      loadAddressByType();
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
              ),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}