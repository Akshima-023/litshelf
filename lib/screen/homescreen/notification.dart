import 'package:flutter/material.dart';
import 'package:litshelf/theme/text.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    List<String> notifications = [];
    final Size size = MediaQuery.of(context).size;
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
                          Text("Notification",
                            style: AppTextStyles.des18bb
                          ),   
                        ]
                      ),
                      SizedBox(height: size.height * 0.20),
                    notifications.isEmpty
                    ? Center(
                    child: Column(
                    children: [
                      Icon(
                      Icons.notifications_none,
                      size: size.height * 0.16,
                      color: Colors.grey,
                      ),
                       SizedBox(height: size.height*0.01),
                       Text(
                        "There is no notifications",
                        style: AppTextStyles.text18bg
                        ),
                        ],
                      ),
                    )
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                    return ListTile(
                   leading: Icon(Icons.notifications),
                  title: Text(notifications[index]),
                  );
                   },
                  ),
                  ]
                )
              )
            )
          )

    );
  
  }
}