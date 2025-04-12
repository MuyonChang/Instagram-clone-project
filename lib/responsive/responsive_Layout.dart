import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({super.key,
  required this.webScreenLayout,
  required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth>webScreensize){
        return webScreenLayout; 
      }
        return mobileScreenLayout;
    });
  }
}
