class Exam {
  final String name;
  final DateTime dateTime;
  final List<String> rooms;

  Exam({required this.name, required this.dateTime, required this.rooms});
}
List<Exam> exams = [
  Exam(name: "Математика 1", dateTime: DateTime(2025, 11, 09, 9, 0), rooms: ["Лаб01"]),
  Exam(name: "Физика", dateTime: DateTime(2025, 11, 20, 10, 30), rooms: ["Лаб13"]),
  Exam(name: "Веб програмирање", dateTime: DateTime(2025, 11, 21, 12, 0), rooms: ["Лаб02"]),
  Exam(name: "Професионални вештини", dateTime: DateTime(2025, 11, 22, 14, 0), rooms: ["Лаб12"]),
  Exam(name: "Алгебра", dateTime: DateTime(2025, 11, 23, 8, 0), rooms: ["Лаб07"]),
  Exam(name: "Статистика", dateTime: DateTime(2025, 11, 24, 9, 30), rooms: ["Лаб06"]),
  Exam(name: "Бази на податоци", dateTime: DateTime(2025, 11, 25, 11, 0), rooms: ["Лаб04"]),
  Exam(name: "Мобилни информациски системи", dateTime: DateTime(2025, 11, 26, 13, 0), rooms: ["Лаб01"]),
  Exam(name: "Веб дизајн", dateTime: DateTime(2025, 11, 27, 15, 0), rooms: ["Лаб08"]),
  Exam(name: "Дизајн на образовен софтвер", dateTime: DateTime(2025, 11, 28, 16, 0), rooms: ["Лаб02"]),
];
