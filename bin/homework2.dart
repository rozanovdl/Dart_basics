import 'dart:async';
import 'dart:collection';
import 'dart:math';

void main() {
// задания №1 и №2
  var sam = DelimetersCalculator(10, 13, [1, 1, 0, 1]);
  sam.nodNok();
  sam.simpleM();
  sam.convToBin();
  sam.convToDec();
// задание №3
  var word = someWords();
  print(word.findNum('vsiakiy45 текст 33 65 2 98разный 987654'));
// задание №4
  word.wordCounter([
    'ddd',
    'ddd',
    'ddd',
    'door',
    'door',
    '123',
    '123',
    'asdasf',
    'asfdasd',
    'lkjh',
    'lkjh'
  ]);
// задание №5
  word.wordsToDigits(
      ['one, two, three, cat, dog, nine', 'one, two, zero, zero']);
// задание м №6
  var point1 = Point(5, 6, 7);
  var point2 = Point(2, 2, 2);
  var point3 = Point.origin();
  var point4 = Point.single();
  point2.distanceTo(point1);
  point2.distanceTo(point3);
  point3.distanceTo(point4);
// задание №7
  var Root = AnyRoot();
  Root.searchRoot(27, 3, 0.001);
// задание №8
  AdminUser('vasia',
      'tesr@pochta.com'); // задание №8 - значение из email, которое находится после @
  var man2 = GeneralUser('test', 'test@test.com');
  man2.printUser();
  var userMan = UserManager(); // добавляем, удаляем, проверяем
  userMan.addUser(man2);
  userMan.printMap();
  userMan.removeUser(man2);
  userMan.printMap();
}

//____________________________________________№1______________________________
class DelimetersCalculator {
  int x = 0;
  int y = 0;
  var z = [];

  DelimetersCalculator(int a, int b, list) {
    x = a;
    y = b;
    z = list;
  }

  void nodNok() {
    var list1 = [];
    var list2 = [];
    var compl = [];
    for (var i = 1; i <= x; i++) {
      if (x % i == 0) {
        list1.add(
            i); //выбираем для двух чисел те делители, для которых нет остатка
      }
    }
    for (var j = 1; j <= y; j++) {
      if (y % j == 0) {
        list2.add(
            j); //выбираем для двух чисел те делители, для которых нет остатка
      }
    }
    for (int nod in list1) {
      if (list2.contains(nod)) {
        compl.add(nod); //выбираем общие делители
      }
    }
    int finnod = compl.last; //выбираем последнее значение - НОД
    var finnok = x * y ~/ finnod; // НОК
    print('NOD = $finnod');
    print('NOK = $finnok');
  }

  void simpleM() {
    //простые множители
    int rez = x;
    var list3 = [];
    int div = 2;
    while (rez > 1) {
      while (rez % div == 0) {
        // множитель тот что без остатка начиная с 2
        list3.add(div);
        rez = rez ~/ div;
      }
      div++;
    }
    print(list3);
  }

//______________________________________№2__________________________
  void convToBin() {
    // в двоичную
    int dec = y;
    var bin = [];
    int base = 2;
    while (dec >= 1) {
      bin.add(dec % base);
      dec = dec ~/ base;
    }
    print(bin.reversed.join());
  }

  void convToDec() {
    //в десятичную
    var dec = 0;
    var sum = 0;
    var count = z.length;
    for (var i = 0; i < count; i++) {
      int base = 2;
      int val = 1;
      for (int j = count - 1; j > i; j--) {
        val *= base;
      }
      dec = z[i] * val;
      sum = sum + dec;
    }
    print(sum);
  }
}

//_____________________________№3___________________________
class someWords {
  findNum(str) {
    //выбираем числа из переданной строки и возвращаем их в строке
    var exp = RegExp(r'(\d+)');
    final num = exp.allMatches(str).map((m) => m.group(0)).toString();
    return num;
  }

//____________________________№4____________________________
  wordCounter(words) {
    var map = Map();
    words.forEach((word) {
      if (!map.containsKey(word)) {
        map[word] = 1;
      } else {
        map[word] += 1;
      }
    });
    print(map);
  }

//___________________________№5______________________________
  wordsToDigits(strings) {
    Map<String, int> pare = {
      'one': 1,
      'two': 2,
      'three': 3,
      'four': 4,
      'five': 5,
      'six': 6,
      'seven': 7,
      'eight': 8,
      'nine': 9,
      'zero': 0
    };

    var exp = RegExp(r'(\w+)');
    for (var i in strings) {
      var dig = [];
      var unicues = LinkedHashMap<String, bool>();
      final num = exp
          .allMatches(i.replaceAll(RegExp(r','), ''))
          .map((m) => m.group(0).toString());
      for (var s in num) {
        unicues[s] = true;
      }
      for (var w in unicues.keys) {
        if (pare.containsKey(w)) {
          dig.add(pare[w]);
        }
      }
      print(num);
      print(dig);
    }
  }
}

//_________________________________№6__________________________________
class Point {
  final double x;
  final double y;
  final double z;

  Point(this.x, this.y, this.z);

  factory Point.origin() {
    return Point(0, 0, 0);
  }

  factory Point.single() {
    return Point(1, 1, 1);
  }

  distanceTo(Point) {
    var difX = Point.x - x;
    var difY = Point.y - y;
    var difZ = Point.z - z;
    num dist = sqrt(pow(difX, 2) + pow(difY, 2) + pow(difZ, 2));
    print('Dist between points: $dist');
  }
}

//_______________________________№7________________________________
class AnyRoot {
  double numb = 0;
  int rootDegree = 1;
  double prec = 0;
} //точность

extension SearchRoot on AnyRoot {
  void searchRoot(double a, int b, double c) {
    numb = a;
    rootDegree = b;
    prec = c;
    double root = 20; //начальное значение для последующих итераций

    if (numb <= 0) {
      throw Exception(
          "Подкоренное выпражение должно быть положительным числом");
    } else {
      double power(double x, int n) {
        // возводим корень в степень n-1 для делителя внутри скобок
        double retval = 1;
        for (int i = 0; i < n; i++) {
          retval *= x;
        }
        return retval;
      }

      double temp = root - 1;
      while ((root - temp).abs() > prec) {
        temp = root;
        root = (1 / rootDegree) *
            ((rootDegree - 1) * temp + (numb / power(temp, rootDegree - 1)));
      }
      print('Корень степени $rootDegree из $numb = $root');
    }
  }
}

// ________________________________Задание №8_________________________________
class User {
  String username;
  String email;

  User(this.username, this.email);
}

class AdminUser extends User with GetMailSystem {
  AdminUser(String username, String email) : super(username, email) {
    print(getMailSystem(email));
  }
}

class GeneralUser extends User {
  GeneralUser(String username, String email) : super(username, email);

  printUser() {
    print('$username, $email');
  }
}

class UserManager<T extends User> {
  Map<String, String> map = {
    'ivan': 'ivan@mail.ru',
    'petr': 'petr@yandex.ru',
    'admin': 'admin@habr.com',
    'anna': 'anna@rambler.ru'
  };

  addUser(T) {
    map[T.username] = T.email;
  }

  removeUser(T) {
    map.remove(T.username);
  }

  printMap() {
    for (var entry in map.entries) {
      if (entry.key == 'admin') {
        print(
            '${entry.key}  ${entry.value.substring(entry.value.lastIndexOf("@") + 1)}');
      } else {
        print('${entry.key}   ${entry.value}');
      }
    }
  }
}

mixin GetMailSystem on User {
  getMailSystem(String email) {
    return (email.substring(email.lastIndexOf("@") + 1));
  }
}
