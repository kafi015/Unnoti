



class Urls {
  static String baseUrl = 'https://abdulazizhardware.com/api/';
  static String registrationUrl = '${baseUrl}register/';
  static String verigyOTPUrl = '${baseUrl}verify-otp/';
  static String logInUrl = '${baseUrl}login/';
  static String profileUrl = '${baseUrl}profile/';
  static String rechargeUrl = '${baseUrl}recharge/';
  static String productUrl = '${baseUrl}product/';
  static String lotteryUrl = '${baseUrl}lottery/';
  static String productPointUrl = '${baseUrl}productpoint/';
  static String rechargeLogUrl = '${baseUrl}recharge_log/';
  static String notificationUrl = '${baseUrl}notice/';
  static String gellaryUrl = '${baseUrl}gallery/';
  static String addressUrl = '${baseUrl}address/';
  static String helpUrl = '${baseUrl}help/';
  static String offerUrl = '${baseUrl}offer/';
  static String certificateUrl = '${baseUrl}certificate/';
  static String insuranceUrl = '${baseUrl}insurance/';
  static String profileByIDUrl(int id) => '${baseUrl}profile/$id';
}