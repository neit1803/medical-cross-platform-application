import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';

class DashBoardCard extends StatefulWidget {
  BuildContext context;
  IconData icon;
  String title;
  String value;
  double? growth;
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
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
              backgroundColor: widget.color,
              child: Icon(
                widget.icon,
                size: 30,
              ),
            ),
            title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(widget.value, style: Theme.of(context).textTheme.displayLarge,),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All   >",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (widget.growth != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.growth! > 0? Colors.green[100]: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.growth! > 0?
                        Icon(ic_increase, color: Theme.of(context).colorScheme.secondary,)
                        : Icon(ic_decrase, color: Theme.of(context).colorScheme.error,),
                      Text(" ${(widget.growth!.abs() * 100).toStringAsFixed(0)}%", style: TextStyle(color: widget.growth! > 0? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error),),
                    ],
                  ),
                ),
            if (widget.dropdown)
              DropdownButton<String>(
                style: Theme.of(context).textTheme.bodyLarge,
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