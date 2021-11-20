import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/person.dart';

class CreatePersonPage extends StatefulWidget {
  const CreatePersonPage({Key? key}) : super(key: key);

  @override
  _CreatePersonPageState createState() => _CreatePersonPageState();
}

class _CreatePersonPageState extends State<CreatePersonPage> {
  Person person = Person();
  String fecha = '';

  var textEditingControllerName = TextEditingController();
  var textEditingControllerLastName = TextEditingController();
  var textEditingControllerDireccion = TextEditingController();
  var textEditingControllerFechaNacimiento = TextEditingController();
  var textEditingControllerSalario = TextEditingController();
  var textEditingControllerFechaIngreso = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Formulario')),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextField(
                controller: textEditingControllerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'Ingresa tu nombre',
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerLastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'Ingresa tu apellido',
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerDireccion,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'fecha ingreso',
                ),
              ),
              SizedBox(height: 30.0),

              createImputDate(context),

              SizedBox(height: 30.0),
              TextField(
                controller: textEditingControllerSalario,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'Ingresa salario',
                ),
              ),
              SizedBox(height: 30.0),

              TextField(
                controller: textEditingControllerFechaIngreso,
                decoration: InputDecoration(
                  hintText: 'fecha ingreso:',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  labelText: 'fecha ingreso',
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screen2');
                    setState(() {});
                    callServiceCreatePerson(
                        textEditingControllerName.text,
                        textEditingControllerLastName.text,
                        textEditingControllerDireccion.text,
                        textEditingControllerFechaNacimiento.text,
                        textEditingControllerSalario.text,
                        textEditingControllerFechaIngreso.text);
                  },
                  child: Text('Crear persona')),

              //Crea el registro y todo pero me falta hacer que el cambio sea inmediato
            ],
          ),
        ),
      ),
    );

    // ignore: dead_code
  }

  Widget createImputDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: textEditingControllerFechaNacimiento,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: 'fecha nacimiento',
        hintText: 'Ingrese su fecha de nacimiento',
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        selectDate(context);
      },
    );
  }

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2022),
    );

    if (picked != null) {
      setState(() {
        fecha = picked.toString();

        textEditingControllerFechaNacimiento.text = fecha;
      });
    }
  }

  void callServiceCreatePerson(String name, String lastname, String direccion,
      String fechaNacimiento, String salario, String fechaIngreso) async {
    var person = Person(
        name: name,
        lastname: lastname,
        direccion: direccion,
        fechaNacimiento: fechaNacimiento,
        salario: salario,
        fechaIngreso: fechaIngreso);

    var url = Uri.parse('https://619040abf6bf450017484bb3.mockapi.io/Persons/');
    var personBody = jsonEncode(person);

    Response response = await http.post(
      url,
      body: personBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {
    } else {
      print("ñe");
    }
  }
}
