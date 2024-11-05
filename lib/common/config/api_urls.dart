import '../../catalog/enums/env_config.dart';
import '../../main.dart';

class APIUrls {

  static String get baseUrl  {
    switch(environmentType){
      case EnvironmentType.production:
        return "";
      case EnvironmentType.staging:
        return "";
      case EnvironmentType.testing:
        return "https://dummyjson.com";
    }
  }

  static const String withoutApiVersion = "/api/";
  static const String apiVersion1 = "/api/v1/";


  /// ****************  Auth & Profile ****************
  static const String login = "/auth/login";

/// ****************  TODOs ****************
  static const String todosList = "/todos";
  static const String delete = "/todos";
  static const String add = "/todos/add";


}