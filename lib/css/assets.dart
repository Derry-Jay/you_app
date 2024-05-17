import '../utils/values.dart';

class Assets {
  static final Assets _singleton = Assets._internal();

  factory Assets() {
    return _singleton;
  }

  Assets._internal();

  final 
  //splashImage = '${acf.assetImagePath}splash_img.png',
      plus = '${acf.assetImagePath}plus.jpg';
}
