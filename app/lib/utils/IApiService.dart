abstract class IApiService {
  Future<dynamic> get(String endpoint);
  Future<dynamic> post(String endpoint, dynamic data);
  Future<dynamic> put(String endpoint, dynamic data);
  Future<dynamic> delete(String endpoint);
}
