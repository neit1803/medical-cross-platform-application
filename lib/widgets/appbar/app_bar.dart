import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_icons.dart';
import 'package:flutter_application_1/widgets/appbar/search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBar({Key? key}): super(key: key);

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
          automaticallyImplyLeading: false ,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: CustomSearchBar(),
          actions: [
            IconButton(onPressed: (){}, icon: ic_notifi, color: Theme.of(context).colorScheme.onSurface,),
            InkWell(
              child: Row(        
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
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