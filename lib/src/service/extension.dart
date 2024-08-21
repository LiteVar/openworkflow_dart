extension MapContainsExtension on Map<String, dynamic> {
  bool containsStruct(Map<String, dynamic> other) {
    return _areMapsTypesEqual(this, other);
  }

  bool _areMapsTypesEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    var set1 = map1.keys.toSet();
    var set2 = map2.keys.toSet();

    if (!set2.containsAll(set1)) {
      return false;
    }

    for (var key in map1.keys) {
      if (!_areTypesEqual(map1[key], map2[key])) {
        return false;
      }
    }

    return true;
  }

  bool _areTypesEqual(dynamic value1, dynamic value2) {
    if (value1.runtimeType != value2.runtimeType) {
      return false;
    }

    if (value1 is Map<String, dynamic> && value2 is Map<String, dynamic>) {
      return _areMapsTypesEqual(value1, value2);
    } else if (value1 is List<dynamic> && value2 is List<dynamic>) {
      return _areListsTypesEqual(value1, value2);
    }

    return true;
  }

  bool _areListsTypesEqual(List<dynamic> list1, List<dynamic> list2) {
    if(list1.isNotEmpty && list2.isNotEmpty) {
      if (! _areTypesEqual(list1[0], list2[0])) {
        return false;
      }
    }
    return true;
  }
}

// void main() {
//   var map1 = {
//     'a': 1,
//     'b': 'hello',
//     'c': [1, 2, 3],
//     'd': {
//       'nestedKey': 3.14,
//     },
//   };
//
//   var map2 = {
//     'a': 42,
//     'b': 'world',
//     'c': [4, 5, 6, 7],
//     'd': {
//       'nestedKey': 2.71,
//     },
//     'e': 3
//   };
//
//   var map3 = {
//     'a': 42,
//     'b': 'world',
//     'c': [4, 5, 'different type'],
//     'd': {
//       'nestedKey': 'different type',
//     },
//   };
//
//   print(map1.equal(map2)); // true
//   print(map1.equal(map3)); // false
// }
