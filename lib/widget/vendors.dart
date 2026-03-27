import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class VendorsWidget extends StatelessWidget {
   VendorsWidget({super.key});
  final supabase = Supabase.instance.client;
Future<List<dynamic>> fetchVendors() async {
  final response = await supabase
      .from('vendor_images')
      .select('image');

  return response;
}
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(height: size.height * 0.02),

   GestureDetector(
  onTap: () {
    // Navigate to Vendor Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  VendorsWidget()),
    );
  },
  child: Text(
    "Best Vendors",
    style: AppTextStyles.des18bb,
  ),
),

    SizedBox(height: size.height * 0.02),

    FutureBuilder(
      future: fetchVendors(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final vendors = snapshot.data!;

        return SizedBox(
          height: size.height * 0.12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final item = vendors[index];

              return Container(
                width: size.width * 0.3,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 238, 237, 237)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item['image'], 
                    height: size.height*0.02,
                    
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
  ],
);
  }
}


  