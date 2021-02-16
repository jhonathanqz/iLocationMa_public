
class AddPaginas {

  String _nome;
  String _local;
  String _end;
  String _obs;

  AddPaginas();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : this._nome,
      "email" : this._local,
      "end": this._end,
      "obs": this._obs
    };

    return map;

  }

  String get end => _end;

  set end(String value) {
    _end = value;
  }

  String get local => _local;

  set local(String value) {
    _local = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get obs => _obs;

  set obs(String value) {
    _obs = value;
  }

}