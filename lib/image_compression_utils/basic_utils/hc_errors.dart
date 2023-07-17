class HcUnSupportError extends Error {
  final String message;

  HcUnSupportError(this.message);
}

class HcCompressError extends Error {
  final String message;

  HcCompressError(this.message);
}
