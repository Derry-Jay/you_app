import '../../utils/enums.dart';

class RouteArgument {
  final int? id;
  final dynamic param;
  final TransitionType? type;

  RouteArgument({this.id, this.param, this.type});
}
