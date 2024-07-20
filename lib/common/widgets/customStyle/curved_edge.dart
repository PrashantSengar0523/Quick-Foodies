import 'package:flutter/material.dart';

import 'curved_widget.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key,this.child, required Color backgroundColor,
  });
    final Widget?child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdge(),
      child:child, 
    );
  }
}
