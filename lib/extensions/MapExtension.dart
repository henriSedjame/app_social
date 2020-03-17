
extension MapExtension<K,V> on Map<K,V> {

  Map<K,V> mergeIn(Map<K,V> receiver) {

    receiver.updateAll((key, value) => this[key] ?? value);

    this.forEach((key, value) => receiver.putIfAbsent(key, () => value));

    return receiver;
  }
}