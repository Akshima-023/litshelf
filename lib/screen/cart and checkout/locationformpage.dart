import 'package:flutter/material.dart';
import 'package:litshelf/widget/customformfield.dart';
import 'package:litshelf/widget/purplebutton.dart';

class LocationFormPage extends StatelessWidget {
  const LocationFormPage({super.key});

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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.my_location, color: Colors.purple),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           SizedBox(height: size.height * 0.02),

CustomFormField(
  label: "Phone",
  keyboardType: TextInputType.phone,
),

CustomFormField(
  label: "Name",
),

CustomFormField(
  label: "Governorate",
),

CustomFormField(
  label: "City",
),

CustomFormField(
  label: "Block",
),

CustomFormField(
  label: "Street name / number",
),
            SizedBox(height: size.height * 0.04),
PurpleButton(text: "Confirmation", onTap: (){}),
           SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }

 }