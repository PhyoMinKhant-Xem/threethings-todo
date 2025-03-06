import 'package:threethings/methods/database_methods/user_methods.dart';
import 'package:threethings/objects/todo.dart';
import 'package:threethings/objects/app_user.dart';
import 'package:threethings/utils/custom_response.dart';

Future<CustomResponse<Todo>> createTodo(Todo newTodo, AppUser user) async {
  CustomResponse<Todo> response =
      CustomResponse.fail<Todo>("Error Message Not Provided!");

  try {
    user.todoList.add(newTodo);
    user.numbersOfTodosOwn++;
    final status = await updateUser(user);

    if (status.status == OperationStatus.success) {
      response = CustomResponse.success(newTodo, "New Todo Created!");
    } else {
      response = CustomResponse.fail("Todo Creation Failed");
    }
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<Todo>> updateTodo(Todo updatedTodo, AppUser user) async {
  CustomResponse<Todo> response =
      CustomResponse.fail<Todo>("Error Message Not Provided!");

  try {
    user.todoList.map((todo) => {
          if (todo.todoId == updatedTodo.todoId) {todo = updatedTodo}
        });
    final status = await updateUser(user);

    if (status.status == OperationStatus.success) {
      response = CustomResponse.success(updatedTodo, "New Todo Updated!");
    } else {
      response = CustomResponse.fail("Todo Update Failed");
    }
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}

Future<CustomResponse<bool>> deleteTodo(int todoId, AppUser user) async {
  CustomResponse<bool> response =
      CustomResponse.fail<bool>("Error Message Not Provided!");

  try {
    user.todoList.removeWhere((todo) => todo.todoId == todoId);
    user.numbersOfTodosOwn--;
    final status = await updateUser(user);

    if (status.status == OperationStatus.success) {
      response = CustomResponse.success(true, "Todo Deleted!");
    } else {
      response = CustomResponse.fail("Todo Deletion Failed");
    }
  } catch (error) {
    response = CustomResponse.fail(error.toString());
  }

  return response;
}
