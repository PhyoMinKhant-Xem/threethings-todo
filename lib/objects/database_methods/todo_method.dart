import 'package:threethings/objects/database_methods/user_methods.dart';
import 'package:threethings/objects/todo.dart';
import 'package:threethings/objects/user.dart';
import 'package:threethings/utils/custom_response.dart';

Future<CustomResponse<Todo>> createTodo(Todo newTodo, User user) async {
  CustomResponse<Todo> response =
  CustomResponse.fail<Todo>("Error Message Not Provided!");

  try {
    user.todoList.add(newTodo);
    await updateUser(user);

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<Todo>> updateTodo(Todo updatedTodo, User user) async {
  CustomResponse<Todo> response =
  CustomResponse.fail<Todo>("Error Message Not Provided!");

  try {
    user.todoList.map((todo)=>{
      if(todo.todoId == updatedTodo.todoId){
        todo = updatedTodo
      }
    });
    await updateUser(user);

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<Todo>> deleteTodo(Todo todo, User user) async {
  CustomResponse<Todo> response =
  CustomResponse.fail<Todo>("Error Message Not Provided!");

  try {
    user.todoList.remove(todo);
    await updateUser(user);

    response = CustomResponse.fail("Method Not Handled Here!");
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

