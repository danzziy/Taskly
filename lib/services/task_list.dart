import 'package:pocketbase/pocketbase.dart';

class TaskListService {
  final PocketBase pb;

  TaskListService({
    required this.pb
  });

  Future<List<RecordModel>>  viewLists() async {
    print("###################################HERE##############################");
    print(pb.authStore.model);

    return await pb.collection('taskLists').getFullList(sort: 'created');
  }
}