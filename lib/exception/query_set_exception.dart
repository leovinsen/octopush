
class QuerySetException implements Exception {
  final String msg;
  const QuerySetException(String methodSignature)
      : this.msg =
            "Result size for $methodSignature > 1";
}
