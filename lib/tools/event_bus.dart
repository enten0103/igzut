typedef EventCallback = void Function(dynamic arg);

class EventBus {
  EventBus._internal();

  static final EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  final _emap = <dynamic, List<EventCallback>>{};

  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = [];
    } else {
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    List<EventCallback> tempList = List.from(list);
    for (var callback in tempList) {
      callback(arg);
    }
  }

  int getSubscriberCount(eventName) {
    var list = _emap[eventName];
    return list?.length ?? 0;
  }
}

class EventName {
  static const String loginEvent = 'loginEvent';
}
