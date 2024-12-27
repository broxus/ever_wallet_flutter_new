List<T> castJsonList<T>(dynamic json) {
  return (json as List<dynamic>).cast<T>();
}
