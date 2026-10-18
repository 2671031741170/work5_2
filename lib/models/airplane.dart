class Airplane {
  final String id;
  final String flightNumber; // เที่ยวบิน
  final String model;        // รุ่นเครื่อง
  final String airline;      // สายการบิน
  final String seats;        // จำนวนที่นั่ง
  final String status;        // สถานะ
  final DateTime addedAt;     // วันที่บันทึก

  Airplane({
    required this.id,
    required this.flightNumber,
    required this.model,
    required this.airline,
    required this.seats,
    required this.status,
    required this.addedAt,
  });
}