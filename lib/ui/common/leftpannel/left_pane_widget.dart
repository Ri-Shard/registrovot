import 'package:flutter/material.dart';
import 'package:registrovot/ui/common/leftpannel/main_nav_item.dart';

class LeftPane extends StatelessWidget {
  /// declaration of variables
  final int selected;
  final Function mainNavAction;
  const LeftPane(
      {Key? key, required this.selected, required this.mainNavAction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 130,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/vco_logo.png'),
                  fit: BoxFit.fill)),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            MainNavItem("Lideres", Icons.rocket_launch_outlined, selected == 0,
                '/leadersregister'),
            MainNavItem("Usuarios", Icons.person_2_outlined, selected == 1,
                '/usersregister'),
            MainNavItem("Puestos", Icons.verified_outlined, selected == 2,
                '/placesregister'),
            MainNavItem("Agenda", Icons.date_range_outlined, selected == 3,
                '/leadersregister'),
          ],
        )),
      ],
    );
  }
}
