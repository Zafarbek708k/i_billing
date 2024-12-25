final class ApiConst {
  static const Duration connectionTimeout = Duration(minutes: 1);
  static const Duration sendTimeout = Duration(minutes: 1);
  static const Duration receiveTimeout = Duration(minutes: 1);
  static const String baseUrl = "https://65ca48bb3b05d29307e0172d.mockapi.io";
  static const String apiBilling = "/product/contracts";
  static const String apiSavedData = "/product/savedContracts";




  static Map<String, String> geoCodeParam({required String city, int? limit}) => {"q": city, "limit": "${limit ?? 1}"};
  static Map<String, String> emptyParam() => {};
}
