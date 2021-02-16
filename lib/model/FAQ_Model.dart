
class FAQmodel {

  String _nome;

  FAQmodel();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : this._nome,

    };

    return map;

  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

}