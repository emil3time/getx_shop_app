class HttpExeption implements Exception {
  String message;

  HttpExeption({required this.message});

  @override
  String toString() {

    return message;
  }
}
