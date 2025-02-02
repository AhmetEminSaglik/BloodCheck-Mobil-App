/*
class HttpUtil {
  static Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8'
  };
}
*/
class HttpUtil {
  static Map<String, String> getHeaders(String? token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}

