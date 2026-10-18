import 'package:flutter/material.dart';
import '../../models/airplane.dart';
import 'add_edit/add_edit_airplane.dart';  // ไม่มี ..
import 'widgets/airplane_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Airplane> _planes = [];

  void _addPlane(Airplane newPlane) {
    setState(() => _planes.insert(0, newPlane));
  }

  void _updatePlane(int index, Airplane updated) {
    setState(() => _planes[index] = updated);
  }

  void _deletePlane(int index) {
    setState(() => _planes.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("ลบข้อมูลเครื่องบินเรียบร้อยแล้ว"), backgroundColor: Colors.red),
    );
  }

  String _genId() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลเครื่องบิน"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _planes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.airplanemode_inactive, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("ยังไม่มีข้อมูลเครื่องบิน", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  Text("กดปุ่ม + เพื่อเพิ่มรายการ", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _planes.length,
              itemBuilder: (_, i) => AirplaneCard(
                plane: _planes[i],
                onEdit: () async {
                  final res = await Navigator.push(context, MaterialPageRoute(
                    builder: (_) => AddEditAirplane(existingPlane: _planes[i]),
                  ));
                  if (res != null) {
                    _updatePlane(i, Airplane(
                      id: _planes[i].id,
                      flightNumber: res["flightNumber"],
                      model: res["model"],
                      airline: res["airline"],
                      seats: res["seats"],
                      status: res["status"],
                      addedAt: _planes[i].addedAt,
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("แก้ไขข้อมูลเรียบร้อยแล้ว"), backgroundColor: Colors.green),
                    );
                  }
                },
                onDelete: () => _deletePlane(i),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.push(context, MaterialPageRoute(
            builder: (_) => const AddEditAirplane(),
          ));
          if (res != null) {
            _addPlane(Airplane(
              id: _genId(),
              flightNumber: res["flightNumber"],
              model: res["model"],
              airline: res["airline"],
              seats: res["seats"],
              status: res["status"],
              addedAt: DateTime.now(),
            ));
          }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}