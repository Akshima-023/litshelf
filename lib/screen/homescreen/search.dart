import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';
import 'package:litshelf/widget/customtextfield.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final Size size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                           onPressed: () {
                            Navigator.pop(context);
                            },
                            icon: Icon(
                            Icons.arrow_back,
                            ),
                          ),
                          SizedBox(width: size.width*0.26),
                          Text("Search",
                            style: AppTextStyles.des18bb
                          ),   
                        ]
                      ),
                    SizedBox(height: size.height*0.05,),
                    CustomTextField(
                    hintText: "Search",
                    icon: Icons.search,
                    obscureText: false,
                    
                  ),
                  ]
                )
              )
            )
          )         

    );
  }
}