import "package:mobblazers/models/user.dart";
import 'package:http/http.dart' as http;


class RestService{
  Future<List<User>?> getUsers()async{
   var client= http.Client();
   var uri = Uri.parse("https://jsonplaceholder.typicode.com/users");

   var response= await client.get(uri);

   if(response.statusCode==200){
    return userFromJson(response.body);
   }

  }
}