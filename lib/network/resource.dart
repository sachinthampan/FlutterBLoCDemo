class Resource<T>{
  Status? status;
  int statusCode = -1;
  String? message;
  T? data;

  Resource(Status this.status, this.message, this.data);
}
enum Status {LOADING, SUCCESS, ERROR, NONE}
