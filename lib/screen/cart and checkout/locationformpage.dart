import 'package:flutter/material.dart';
import 'package:litshelf/screen/provider/locationprovider.dart';
import 'package:litshelf/widget/customformfield.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:provider/provider.dart';

class LocationFormPage extends StatefulWidget {
  const LocationFormPage({super.key});

  @override
  State<LocationFormPage> createState() => _LocationFormPageState();
}

class _LocationFormPageState extends State<LocationFormPage> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final governorateController = TextEditingController();
  final cityController = TextEditingController();
  final blockController = TextEditingController();
  final streetController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider =
          Provider.of<LocationProvider>(context, listen: false);

      /// ✅ LOAD SAVED DATA FIRST
      await provider.loadLocations();

      final homeData = provider.getLocation("home");

      /// ✅ UPDATE UI
      setState(() {
        phoneController.text = homeData["phone"] ?? "";
        nameController.text = homeData["name"] ?? "";
        governorateController.text = homeData["governorate"] ?? "";
        cityController.text = homeData["city"] ?? "";
        blockController.text = homeData["block"] ?? "";
        streetController.text = homeData["street"] ?? "";
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    governorateController.dispose();
    cityController.dispose();
    blockController.dispose();
    streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Location",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),

            CustomFormField(label: "Phone", controller: phoneController),
            CustomFormField(label: "Name", controller: nameController),
            CustomFormField(label: "Governorate", controller: governorateController),
            CustomFormField(label: "City", controller: cityController),
            CustomFormField(label: "Block", controller: blockController),
            CustomFormField(label: "Street name / number", controller: streetController),

            SizedBox(height: size.height * 0.04),

            PurpleButton(
              text: "Confirmation",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Save Address"),
                    content: const Text("Save this address as?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final provider =
                              Provider.of<LocationProvider>(context,
                                  listen: false);

                          await provider.saveLocation("home", {
                            "phone": phoneController.text,
                            "name": nameController.text,
                            "governorate": governorateController.text,
                            "city": cityController.text,
                            "block": blockController.text,
                            "street": streetController.text,
                          });

                          provider.setSelectedType("home");

                          Navigator.pop(context);
                          Navigator.pop(context, "Home");
                        },
                        child: const Text("Home"),
                      ),

                      TextButton(
                        onPressed: () async {
                          final provider =
                              Provider.of<LocationProvider>(context,
                                  listen: false);

                          await provider.saveLocation("office", {
                            "phone": phoneController.text,
                            "name": nameController.text,
                            "governorate": governorateController.text,
                            "city": cityController.text,
                            "block": blockController.text,
                            "street": streetController.text,
                          });

                          provider.setSelectedType("office");

                          Navigator.pop(context);
                          Navigator.pop(context, "Office");
                        },
                        child: const Text("Office"),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}