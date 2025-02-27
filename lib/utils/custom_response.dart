class CustomResponse<T> {
  OperationStatus status;
  T? data;
  String? message;

  CustomResponse._({required this.status, this.data, required this.message});

  static CustomResponse<T> success<T>(T d, String m) {
    return CustomResponse._(
        status: OperationStatus.success, data: d, message: m);
  }

  static CustomResponse<T> fail<T>(T d, String? m) {
    return CustomResponse._(
        status: OperationStatus.fail,
        data: d,
        message: m ?? "Operation Failed!");
  }

  static CustomResponse<T> notFound<T>(T d, String? m) {
    return CustomResponse._(
        status: OperationStatus.notFound,
        data: d,
        message: m ?? "Data Not Found!");
  }
}

enum OperationStatus { success, fail, notFound }
