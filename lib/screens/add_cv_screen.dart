import 'package:dogs_db_pseb_bridge/db/database_helper.dart';
import 'package:dogs_db_pseb_bridge/models/cv.dart';
import 'package:dogs_db_pseb_bridge/screens/cv_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCVScreen extends StatefulWidget {
  const AddCVScreen({Key? key}) : super(key: key);

  @override
  State<AddCVScreen> createState() => _AddCVScreenState();
}

class _AddCVScreenState extends State<AddCVScreen> {
  late int data;
  late int km;
  late String tipus;
  late int concepte;
  late int quantitat;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Compra/Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Fecha',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir la fecha';
                    }

                    data = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Kilómetros',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir los kilómetros';
                    }

                    km = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    hintText: 'Tipo',
                  ),
                  items: [
                    DropdownMenuItem(value: 'combustible', child: const Text('Combustible')),
                    DropdownMenuItem(value: 'avaria', child: const Text('Avaria')),
                    DropdownMenuItem(value: 'assegurança', child: const Text('Assegurança')),
                    DropdownMenuItem(value: 'equipament', child: const Text('Equipament')),
                    DropdownMenuItem(value: 'altres', child: const Text('Altres')),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que seleccionar un tipo';
                    }

                    tipus = value;
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      tipus = value!;
                    });
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Concepte',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir el concepto';
                    }

                    concepte = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Quantitat',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tienes que introducir la cantidad';
                    }

                    quantitat = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),

                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var cove = CV(data: data, km: km, tipus: tipus, concepte: concepte, quantitat: quantitat);

                      var dbHelper =  DatabaseHelper.instance;
                      int result = await dbHelper.insertDog(cove);

                      if (result > 0) {
                        Fluttertoast.showToast(msg: 'Guardando despeses del cotxe...');
                      }
                    }
                  },
                  child: const Text('Guardar despeses del cotxe'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const CVListScreen();
                    }));
                  },
                  child: const Text('Ver listado de despeses'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
