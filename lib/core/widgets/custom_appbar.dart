import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../routing/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.isFromHome = true});
  final String title;
  final bool isFromHome;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(10), // Height of the AppBar

      child: Container(
        padding: EdgeInsets.only(top: 45.h, right: 16.0.w, left: 16.0.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        child: isFromHome
            ? Center(
                child: FittedBox(
                  child: Text(
                    title,
                    maxLines: 2,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        title,
                        // minFontSize: 25,
                        // maxFontSize: 30,
                        // stepGranularity: 1,
                        maxLines: 2,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        predicate: (route) => false,
                        arguments: {'index': 2},
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_basket_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // The size of the AppBar
}
