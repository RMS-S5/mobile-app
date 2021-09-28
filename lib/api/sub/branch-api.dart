import '../apiConn.dart' show APIConn;

class BranchAPI {
  static final _conn = APIConn();

  // Getters
  Future<dynamic> getTableDataByVerificationCode(String verificationCode,
      {String? token}) async {
    try {
      var response = await _conn
          .get("/api/branch/table-by-verification/$verificationCode");
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> getBranchTables({
    String? token,
    Map<String, dynamic>? query,
  }) async {
    try {
      var response = await _conn.get("/api/branch/branch-tables",
          query: query, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
