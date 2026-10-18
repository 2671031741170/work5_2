import 'package:flutter/material.dart';
import '../../../../models/airplane.dart';

class AddEditAirplane extends StatefulWidget {
  final Airplane? existingPlane;

  const AddEditAirplane({super.key, this.existingPlane});

  @override
  State<AddEditAirplane> createState() => _AddEditAirplaneState();
}

class _AddEditAirplaneState extends State<AddEditAirplane> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _flightCtrl;
  late TextEditingController _modelCtrl;
  late TextEditingController _airlineCtrl;
  late TextEditingController _seatsCtrl;
  String _selectedStatus = "พร้อมใช้งาน";

  @override
  void initState() {
    super.initState();
    _flightCtrl = TextEditingController(text: widget.existingPlane?.flightNumber ?? "");
    _modelCtrl = TextEditingController(text: widget.existingPlane?.model ?? "");
    _airlineCtrl = TextEditingController(text: widget.existingPlane?.airline ?? "");
    _seatsCtrl = TextEditingController(text: widget.existingPlane?.seats ?? "");
    if (widget.existingPlane != null) {
      _selectedStatus = widget.existingPlane!.status;
    }
  }

  @override
  void dispose() {
    _flightCtrl.dispose();
    _modelCtrl.dispose();
    _airlineCtrl.dispose();
    _seatsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingPlane != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "แก้ไขข้อมูลเครื่องบิน" : "เพิ่มข้อมูลเครื่องบิน"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(_flightCtrl, "เที่ยวบิน เช่น TG123", Icons.flight_takeoff),
              _buildField(_modelCtrl, "รุ่นเครื่อง เช่น Boeing 777", Icons.model_training),
              _buildField(_airlineCtrl, "สายการบิน", Icons.business),
              _buildField(_seatsCtrl, "จำนวนที่นั่ง", Icons.event_seat),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(
                  labelText: "สถานะ",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.info),
                ),
                items: const [
                  DropdownMenuItem(value: "พร้อมใช้งาน", child: Text("พร้อมใช้งาน")),
                  DropdownMenuItem(value: "อยู่ระหว่างซ่อม", child: Text("อยู่ระหว่างซ่อม")),
                  DropdownMenuItem(value: "เลิกใช้งาน", child: Text("เลิกใช้งาน")),
                ],
                onChanged: (v) => setState(() => _selectedStatus = v!),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        "flightNumber": _flightCtrl.text.trim(),
                        "model": _modelCtrl.text.trim(),
                        "airline": _airlineCtrl.text.trim(),
                        "seats": _seatsCtrl.text.trim(),
                        "status": _selectedStatus,
                      });
                    }
                  },
                  child: Text(isEdit ? "บันทึกการแก้ไข" : "บันทึกข้อมูล", style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(icon),
        ),
        validator: (v) => v?.trim().isEmpty ?? true ? "กรุณากรอกข้อมูล" : null,
      ),
    );
  }
}