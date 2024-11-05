import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';

class DashBoardCard extends StatelessWidget {
  BuildContext context;
  IconData icon;
  String title;
  String value;
  String? growth;
  bool dropdown = false;
  Color color;

  DashBoardCard({
    super.key, 
    required this.context, 
    required this.icon,
    required this.title,
    required this.value,    
    required this.color,
    this.growth,
    this.dropdown = false  
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            title: Text(title, style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(value, style: Theme.of(context).textTheme.displayLarge,),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "View All   >",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (growth != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up_outlined, color: Theme.of(context).colorScheme.secondary,),
                    Text(" $growth", style: TextStyle(color: Theme.of(context).colorScheme.onError),),
                  ],
                ),
              ),
              if (dropdown)
                DropdownButton<String>(
                  value: "Month",
                  items: ["Day", "Month", "Year"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}