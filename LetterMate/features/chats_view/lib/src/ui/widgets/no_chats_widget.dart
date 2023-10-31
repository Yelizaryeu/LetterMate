import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class NoChatsWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const NoChatsWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.PADDING_25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.PADDING_10),
              child: GestureDetector(
                onTap: () {
                  onPressed;
                  //popUpDialog(context);
                },
                child: const Icon(
                  Icons.add_circle,
                  color: AppColors.darkGrey,
                  size: AppDimens.RADIUS_30,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(AppDimens.PADDING_10),
                child: Text(
                  "You've not joined any chats, tap on the add icon to create a chat.",
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
