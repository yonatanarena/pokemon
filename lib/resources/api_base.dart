abstract class ApiBase {
  /// Get data from the backend
  Future get(String url, [bool overrideBaseUrl]);

  /// post new data to the backend
  Future post(String url, final dynamic data);

  /// update existing data to the backend
  Future put(String url, final dynamic data);

  /// update existing data from the backend
  Future delete(String url);
}