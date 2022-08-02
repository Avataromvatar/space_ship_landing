import 'package:flame/components.dart';

extension FlameProvider on Component {
  ///search
  T? searchInParent<T>() {
    Component? _tmp = parent;
    while (_tmp != null) {
      if (_tmp != null) {
        if (_tmp is T) {
          return _tmp as T;
        }
        _tmp = _tmp.parent;
      }
    }
  }

  T? searchInChildren<T>() {
    ComponentSet _tmp = children;

    for (var element in _tmp) {
      if (element is T) {
        return element as T;
      }
    }
    for (var element in _tmp) {
      var t = searchInChildren<T>();
      if (t != null) {
        return element as T;
      }
    }
  }
}
