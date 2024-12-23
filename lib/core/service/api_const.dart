final class ApiConst {
  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);
  static const Duration receiveTimeout = Duration(minutes: 1);
  static const String baseUrl = "https://65c717aae7c384aada6e2dae.mockapi.io";
  static const String apiBilling = "/billing";




  static Map<String, String> geoCodeParam({required String city, int? limit}) => {"q": city, "limit": "${limit ?? 1}"};
  static Map<String, String> emptyParam() => {};
}
