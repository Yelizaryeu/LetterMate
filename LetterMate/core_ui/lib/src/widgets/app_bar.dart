import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final Color? bgColor;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title,
    this.bgColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: _CustomAppBarWidget(
        title: title,
      ),
    );
  }
}

class _CustomAppBarWidget extends StatelessWidget {
  final String? title;
  final Color? bgColor;

  const _CustomAppBarWidget({
    Key? key,
    this.title,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      backgroundColor: bgColor,
      leading: Row(
        children: <Widget>[
          if (AutoRouter.of(context).current.path != '/')
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
