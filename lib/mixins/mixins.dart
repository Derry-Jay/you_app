import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../extensions/extensions.dart';
// import '../utils/enums.dart';
import '../utils/keys.dart';
import '../utils/values.dart';

mixin FormValidationMixin on MaterialStateMixin, Form, State {
  BuildContext get bc =>
      navKey.currentContext ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? context);
}
