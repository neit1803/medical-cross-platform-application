import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/widgets/appbar/search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  bool showSearchBar;
  CustomAppBar({super.key, this.showSearchBar = true});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
    double.maxFinite,
    80,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AppBar(
          toolbarHeight: preferredSize.height,
          automaticallyImplyLeading: showSearchBar? false : true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: showSearchBar? CustomSearchBar() : SizedBox.shrink(),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(ic_notifi), color: Theme.of(context).colorScheme.onSurface,),
            InkWell(
              child: Row(        
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('https://cdn.create.vista.com/api/media/medium/211941270/stock-photo-beautiful-adult-female-doctor-stethoscope-neck-using-digital-tablet-looking?token='),
                    ),
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mark Ferdinand", style: Theme.of(context).textTheme.titleMedium,),
                      Text("mkferdinand@gmail.com", style: Theme.of(context).textTheme.labelLarge,),
                    ],
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}