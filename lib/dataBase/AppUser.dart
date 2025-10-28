class AppUser{
  String? id;
  String? name ;
  String? email ;
  String? phone ;
  List<String>? favorites;

  AppUser({
    this.id, this.name, this.email, this.phone,
  });
  AppUser.fromMap(Map<String,dynamic>?map){
    this.id = map?["id"];
    this.name = map?["name"];
    this.email = map?["email"];
    this.phone = map?["phone"];
  }

  Map<String,dynamic>toMap(){
    return{
      "id":id,
      "name":name,
      "email":email,
      "phone":phone,
    };
  }
}