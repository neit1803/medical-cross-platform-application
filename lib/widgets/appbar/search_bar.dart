import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/config/colors.dart';

class CustomSearchBar extends StatefulWidget {

  CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBar();
}

class _CustomSearchBar extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    return SearchAnchor(
      builder: (BuildContext ctx, SearchController searchBarController) {
        return SearchBar(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12))),
          backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
          side: WidgetStatePropertyAll(BorderSide(width: 0.5, color: gray1Light)),
          elevation: const WidgetStatePropertyAll<double>(0),
          textStyle: WidgetStatePropertyAll<TextStyle>(Theme.of(context).textTheme.bodyMedium!),
          controller: searchBarController,
          padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16)),
          onTap: () {
            searchBarController.openView();
          },
          onChanged: (_) {
            searchBarController.openView();
          },
          leading: Icon(ic_search),
          trailing: <Widget>[
            Tooltip(
              message: 'Change brightness mode',
              textStyle: Theme.of(context).textTheme.bodySmall,
              child: IconButton(
                isSelected: isDark,
                onPressed: () {
                  setState(() {
                    isDark = !isDark;
                  });
                },
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            )
          ],
        );
      },
      suggestionsBuilder: (BuildContext ctx, SearchController search_bar_controller) {
        return List<ListTile>.generate(3, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState() {
                search_bar_controller.closeView(item);
              }
            },
          );
        });
      }    
    );
  }
}