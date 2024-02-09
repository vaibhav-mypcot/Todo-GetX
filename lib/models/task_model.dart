class TaskModel {
  int? id;
  String? task;
  String? reminder;

  TaskModel({
    this.id,
    this.task,
    this.reminder,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    reminder = json['reminder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task'] = this.task;
    data['reminder'] = this.reminder;
    return data;
  }
}
