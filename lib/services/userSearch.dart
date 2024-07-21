import 'package:myapp/models/task_lists_model.dart';
import 'package:pocketbase/pocketbase.dart';

class UserSearchService {
  final PocketBase pb;

  UserSearchService({
    required this.pb
  });

  // Future<RecordModel> getFirstFriendRecord(String filter) {
  //   return await pb.collection('friends_list').getFirstListItem(
  //     ''
  //   );
  // }
}
