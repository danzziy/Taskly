import 'package:myapp/models/task_lists_model.dart';
import 'package:pocketbase/pocketbase.dart';

class UserSearchService {
  final PocketBase pb;

  UserSearchService({
    required this.pb
  });

  // TODO: Handle pagination in this function, it returns {"page":0,"perPage":0,"totalItems":0,"totalPages":0,"items":[]}.
  Future<ResultList> listUsers(String filter) async {
    if(filter.length < 3) {
      return ResultList();
    }

    final resultList = await pb.collection('users').getList(
      page: 1,
      perPage: 10,
      filter: 'username ~ "${filter}"',
    );

    return resultList;
  }

  Future<RecordModel> getFirstFriendRecord(String filter) async {
    return await pb.collection('friends_lists').getFirstListItem(
      'user.id = "${pb.authStore.model.id}" && friends.username ~ "${filter}"',
      expand: 'relField1,relField2.subRelField',
    );
  }
}
