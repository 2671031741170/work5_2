import 'package:flutter/material.dart';
import '../../../../../../models/airplane.dart';

class AirplaneCard extends StatelessWidget {
  final Airplane plane;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AirplaneCard({
    super.key,
    required this.plane,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.airplanemode_active, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    plane.flightNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _infoRow("รุ่นเครื่อง", plane.model),
            _infoRow("สายการบิน", plane.airline),
            _infoRow("ที่นั่ง", plane.seats),
            _infoRow("สถานะ", plane.status, isStatus: true),
            const SizedBox(height: 8),
            Text(
              "บันทึกเมื่อ: ${plane.addedAt.day}/${plane.addedAt.month}/${plane.addedAt.year}",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text("$label:", style: TextStyle(color: Colors.grey[600]))),
          isStatus
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: value == "พร้อมใช้งาน" ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(value, style: TextStyle(color: value == "พร้อมใช้งาน" ? Colors.green[800] : Colors.orange[800])),
                )
              : Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}