import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/database_helper.dart';
import '../models/cv.dart';

class UpdateCVScreen extends StatefulWidget {
  final CV cv;

  const UpdateCVScreen({Key? key, required this.cv}) : super(key: key);

  @override
  State<UpdateCVScreen> createState() => _UpdateCVScreenState();
}

class _UpdateCVScreenState extends State<UpdateCVScreen> {
  late int data;
  late int km;
  late String tipus;
  late int concepte;
  late int quantitat;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    data = widget.cv.data;
    km = widget.cv.km;
    tipus = widget.cv.tipus;
    concepte = widget.cv.concepte;
    quantitat = widget.cv.quantitat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Compra/Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.cv.data.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Data'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Proveea data';
                    }

                    data = int.parse(value);
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      data = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cv.km.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Kilómetros'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Proveea kilómetros';
                    }

                    km = int.parse(value);
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      km = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cv.tipus,
                  decoration: const InputDecoration(hintText: 'Tipus'),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        (value != 'combustible' &&
                            value != 'avaria' &&
                            value != 'assegurança' &&
                            value != 'equipament' &&
                            value != 'altres')) {
                      return 'Tienes que introducir uno de los siguientes valores: combustible, avaria, assegurança, equipament, altres';
                    }

                    tipus = value;
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      tipus = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cv.concepte.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Concepte'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Proveea concepte';
                    }

                    concepte = int.parse(value);
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      concepte = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.cv.quantitat.toString(),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Quantitat'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Proveea quantitat';
                    }

                    quantitat = int.parse(value);
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quantitat = int.parse(value);
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var cv = CV(
                        id: widget.cv.id,
                        data: data,
                        km: km,
                        tipus: tipus,
                        concepte: concepte,
                        quantitat: quantitat,
                      );

                      var dbHelper = DatabaseHelper.instance;
                      int result = await dbHelper.updateCV(cv);

                      if (result > 0) {
                        Fluttertoast.showToast(msg: 'CV Updated');
                        Navigator.pop(context, 'done');
                      }
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
