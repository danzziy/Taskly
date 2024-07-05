import 'package:pocketbase/pocketbase.dart';

class AuthService {
  final PocketBase pb;

  AuthService({
    required this.pb,
  });
  
  bool isUserLoggedIn() {
    return pb.authStore.model.id != '';
  }

  Stream<AuthStoreEvent> authStateChanged() {
    return pb.authStore.onChange;
  }

  createUser(email, password, confirmPassword) async {
    var data = {
      'email': email,
      'password': password, 
      'passwordConfirm': password,
      'emailVisibility': false,
    };
    var result = await pb.collection('users').create(body: data);
    print(result);
  }

  loginWithEmail(email, password) async {
    print(pb.authStore.model);
    var result = await pb.collection('users').authWithPassword(email, password);
    print(result);
  }

  loginWithGoogle() async {

  }

  loginWithInsta() async {

  }
}