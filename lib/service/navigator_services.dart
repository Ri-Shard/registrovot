import 'package:flutter/cupertino.dart';

class _NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future navigateTo(String routename){
    return navigatorKey.currentState!.pushNamed(routename);
  } 

  void goBack(String routename){
    return navigatorKey.currentState!.pop();
  }
  
}
final navigationService =  _NavigationService();