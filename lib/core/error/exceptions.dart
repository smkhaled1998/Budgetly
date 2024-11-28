
class DatabaseInitializationException implements Exception {
  final String message;
  DatabaseInitializationException([this.message = "Failed to initialize or open database."]);
}

class SQLSyntaxException implements Exception {
  final String message;
  SQLSyntaxException([this.message = "SQL syntax error occurred."]);
}

class QueryExecutionException implements Exception {
  final String message;
  QueryExecutionException([this.message = "Failed to execute query on the database."]);
}

class DataInsertionException implements Exception {
  final String message;
  DataInsertionException([this.message = "Failed to insert data into the database."]);
}

class DataUpdateException implements Exception {
  final String message;
  DataUpdateException([this.message = "Failed to update data in the database."]);
}

class DataDeletionException implements Exception {
  final String message;
  DataDeletionException([this.message = "Failed to delete data from the database."]);
}

class DataRetrievalException implements Exception {
  final String message;
  DataRetrievalException([this.message = "Failed to retrieve data from the database."]);
}
