import 'package:flutter/material.dart';
import 'package:litshelf/widget/customformfield.dart';
import 'package:litshelf/widget/purplebutton.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  loadSavedData();
}
void loadSavedData() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    phoneController.text = prefs.getString("phone") ?? "";
    nameController.text = prefs.getString("name") ?? "";
    governorateController.text = prefs.getString("governorate") ?? "";
    cityController.text = prefs.getString("city") ?? "";
    blockController.text = prefs.getString("block") ?? "";
    streetController.text = prefs.getString("street") ?? "";
  });
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
        title: const Text(
          "Location",
          style: TextStyle(color: Colors.black),
        ),
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
  onTap: () async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Save Address"),
        content: const Text("Save this address as?"),
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setString("home_phone", phoneController.text);
              await prefs.setString("home_name", nameController.text);
              await prefs.setString("home_governorate", governorateController.text);
              await prefs.setString("home_city", cityController.text);
              await prefs.setString("home_block", blockController.text);
              await prefs.setString("home_street", streetController.text);

              
              Navigator.pop(context); 
              Navigator.pop(context, "Home");// go back
            },
            child: const Text("Home"),
          ),

          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setString("office_phone", phoneController.text);
              await prefs.setString("office_name", nameController.text);
              await prefs.setString("office_governorate", governorateController.text);
              await prefs.setString("office_city", cityController.text);
              await prefs.setString("office_block", blockController.text);
              await prefs.setString("office_street", streetController.text);

             
              Navigator.pop(context);
              Navigator.pop(context, "office");
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