import 'package:myapp/models/task_lists_model.dart';
import 'package:pocketbase/pocketbase.dart';

class TaskListService {
  final PocketBase pb;

  TaskListService({
    required this.pb
  });

  // TODO: Refactor horribly named function that does too many things. 
  // This function subscribes to a list that outlines all the lists shared with a user and it
  // subscribes to all the lists. I did this because when a user is removed as a viewer of a list,
  // they do not receive an update about it as the status of that list no longer concerns them,
  // however the status does concern them as they need  to atleast see the list disappear from 
  // their home page.
  Future<List> subscribeToTaskLists(void Function(dynamic) onUpdate) async {
    print("SUBSCRIBE EVENT OCCURED");
    await pb.collection('shared_lists').subscribe('*', (e) {
      // print(e.action);
      // print(e.record);
      // print(e.toString());
      onUpdate(e);
    });

    await pb.collection('task_lists').subscribe('*', (e) {
      print(e.action);
      print(e.record);
      // print(e.toString());
      onUpdate(e);
    });
    
    return await pb.collection('task_lists').getFullList(sort: 'created');
  }

  Future<void> createTaskList(String listName, {int tasks = 0, int completedTasks = 0, List<String>? viewers}) async {
    print('create lists for ' + pb.authStore.model.id);
    viewers ??= [];
    final body = <String, dynamic>{
      'name': listName,
      'user': pb.authStore.model.id,
      'viewers': viewers,
      'tasks': tasks,
      'completed_tasks': completedTasks,
    };

    await pb.collection('task_lists').create(body: body);
  }
}
