
class Person {
  String? id;
  String? name;
  String? lastname;
  String? direccion;
  String? fechaNacimiento;
  dynamic salario;
  String? fechaIngreso;

  Person(
      {this.id,
      this.name,
      this.lastname,
      this.direccion,
      this.fechaNacimiento,
      this.salario,
      this.fechaIngreso});

  Person.fromJson(Map<String, dynamic> jsonperson) {
    id = jsonperson['id'];
    name = jsonperson['name'];
    lastname = jsonperson['lastname'];
    direccion = jsonperson['direccion'];
    fechaNacimiento = jsonperson['fechaNacimiento'];
    salario = jsonperson['salario'];
    fechaIngreso = jsonperson['fechaIngreso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['direccion'] = this.direccion;
    data['fechaIngreso'] = this.fechaIngreso;
    data['salario'] = this.salario;
    data['fechaIngreso'] = this.fechaIngreso;

    return data;
  }

}
