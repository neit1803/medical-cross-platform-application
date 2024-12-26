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
  bool isSmall;
  final VoidCallback onPressed;

  DashBoardCard({
    super.key, 
    required this.context, 
    required this.icon,
    required this.title,
    required this.value,    
    required this.color,
    this.growth,
    this.dropdown = false,
    required this.isSmall, 
    required this.onPressed,
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(
                    widget.icon,
                    size: 30,
                  ),
                  title: Text(
                    widget.title, 
                    style: widget.isSmall? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    widget.value, 
                    style: widget.isSmall? Theme.of(context).textTheme.displaySmall : Theme.of(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    "View All   >",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.isSmall? 8:12
                    ),
                  ),
                ),
              ),
            if (widget.growth != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: widget.isSmall? 4:8, vertical: widget.isSmall? 2:4),
                  decoration: BoxDecoration(
                    color: widget.growth! > 0? Colors.green[100]: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.growth! > 0?
                        Icon(ic_increase, color: Theme.of(context).colorScheme.secondary, size: widget.isSmall? 12: 14,)
                        : Icon(ic_decrase, color: Theme.of(context).colorScheme.error, size: widget.isSmall? 12: 14),
                      Text(
                        " ${(widget.growth!.abs() * 100).toStringAsFixed(0)}%", 
                        style: TextStyle(
                          color: widget.growth! > 0? 
                            Theme.of(context).colorScheme.onError
                            : Theme.of(context).colorScheme.error,
                          fontSize: widget.isSmall? 10:12,
                        ),
                      ),
                    ],
                  ),
                ),
            if (widget.dropdown)
              DropdownButton<String>(
                value: "Month",
                items: ["Day", "Month", "Year"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: widget.isSmall? TextStyle(fontSize: 10): TextStyle(fontSize: 12),),
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