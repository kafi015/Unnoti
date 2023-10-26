



class Urls {
  static String baseUrl = 'http://abdulazizhardware.com/api/';
  static String registrationUrl = '${baseUrl}register/';
  static String verigyOTPUrl = '${baseUrl}verify-otp/';
  static String logInUrl = '${baseUrl}login/';
  static String profileUrl = '${baseUrl}profile/';
  static String rechargeUrl = '${baseUrl}recharge/';
  static String productUrl = '${baseUrl}product/';
  static String lotteryUrl = '${baseUrl}lottery/';
  static String productPointUrl = '${baseUrl}productpoint/';
  static String profileByIDUrl(int id) => '${baseUrl}profile/$id';
}