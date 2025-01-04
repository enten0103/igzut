List<T> diff<T>(List<T> source, List<T> target) {
  List<T> result = [];
  for (var i = 0; i < target.length; i++) {
    var element = target[i];
    if (!source.remove(element)) {
      result.add(element);
    }
  }
  return result;
}
