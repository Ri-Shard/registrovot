import 'package:flutter/material.dart';

class MainNavItem extends StatelessWidget {
  /// a. definition of variables
  final String title;
  final bool isSelected;
  final String page;
  final IconData? icon;
  const MainNavItem(this.title, this.icon, this.isSelected, this.page,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// b. returning a container
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),

      /// c. making the item clickable
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: isSelected ? Colors.deepPurple.withOpacity(0.15) : null,
        onPressed: () {
          // navigationService.navigateTo(page);
          Navigator.pushNamed(context, page);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
