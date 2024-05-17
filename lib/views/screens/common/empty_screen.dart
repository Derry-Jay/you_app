import 'package:flutter/material.dart';

import '../../widgets/common/empty_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const EmptyWidget());
  }
}
