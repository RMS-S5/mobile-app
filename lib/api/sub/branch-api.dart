import '../apiConn.dart' show APIConn;

class BranchAPI {
  static final _conn = APIConn();

  // Getters
  Future<dynamic> getTableDataByVerificationCode(String verificationCode,
      {String? token}) async {
    try {
      var response = await _conn
          .get("/api/branch/get-table-by-verification/$verificationCode");
      return response;
    } catch (error) {
      throw error;
    }
  }
}
