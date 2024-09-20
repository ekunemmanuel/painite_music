import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar(
      {super.key, this.title, this.hideback = false, this.actions}); 

  final Widget? title;
  final bool hideback;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: title,
      centerTitle: true,
      actions: actions,
      leading: hideback
          ? null
          : IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
