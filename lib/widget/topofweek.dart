import 'package:flutter/material.dart';
import 'package:litshelf/screen/homescreen/productbottomsheet.dart';

import 'package:litshelf/theme/text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TopOfWeekWidget extends StatelessWidget {
  final Future<List<dynamic>> booksFuture;
  final double height;
  TopOfWeekWidget({
    super.key,
    required this.booksFuture,
    this.height = 220,
  });
   final supabase = Supabase.instance.client;
  Future<List<dynamic>> fetchProducts() async {
  final response = await supabase
      .from('products')
      .select('name, price, image');

  return response;
}
final List<Map<String, dynamic>> productRatings = [
  {'rating': 5, 'reviews': 120},
  {'rating': 4, 'reviews': 80},
  {'rating': 3, 'reviews': 45},
  {'rating': 5, 'reviews': 200},
  {'rating': 2, 'reviews': 20},
  {'rating': 5, 'reviews': 200},
  {'rating': 4, 'reviews': 180},
];

 @override
Widget build(BuildContext context) {
  final Size size = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Top of Week",
        style: AppTextStyles.des18bb,
      ),

      SizedBox(height: size.height * 0.02),

      FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          return SizedBox(
            height: size.height*0.40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];

                return GestureDetector( onTap: () {
   final details = productRatings[index];

  showModalBottomSheet(
    context: context,
     isScrollControlled: true,
  isDismissible: true,
   enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => ProductBottomSheet(
      name: item['name'],
      image: item['image'],
      rating: details['rating'],          
      ratingCount: details['reviews'],
       price: item['price'],   
    ),
  );
},
                  child: Container(
                    width: size.width*0.5,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                    
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image'],
                            height: size.height*0.3,
                            width: size.width*0.99,
                            fit: BoxFit.cover,
                          ),
                        ),
                  
                         SizedBox(height: size.height*0.02),
                  
                       
                        Text(
                          item['name'],
                          style: AppTextStyles.text14bb,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                         SizedBox(height: size.height*0.0),                     
                        Text(
                          "₹${item['price']}",
                          style: AppTextStyles.text14pb
                        ),
                      ],
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
}}