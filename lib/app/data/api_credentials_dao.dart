part of 'database.dart';

@DriftAccessor(tables: [ApiCredentials])
class ApiCredentialsDao extends DatabaseAccessor<AppStorage> with _$ApiCredentialsDaoMixin {
  ApiCredentialsDao(AppStorage db) : super(db);

  Future<ApiCredential> getApiCredential() async {
    return select(apiCredentials).getSingle();
  }

  Future<int> updateApiCredential(ApiCredentialsCompanion apiCredential) {
    return update(apiCredentials).write(apiCredential);
  }
}
