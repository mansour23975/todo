
part of 'todo_bloc.dart';

abstract class TODOState extends Equatable {

  const TODOState();

  @override
  List<Object?> get props => [];

}

class TODOInitial extends TODOState {}

class TODOLoading extends TODOState {}

class RestaurantDoNotDeliverToYourLocation extends TODOState {
  final String? message;
  const RestaurantDoNotDeliverToYourLocation(this.message);


}



class TODOSuccessfully extends TODOState {
  final String orderId;
  const TODOSuccessfully(this.orderId);
}


class TODORestaurantNoDeliverToYourLocation extends TODOState {

}

class NeedToDoOnlinePayment extends TODOState {
  final String orderId;
  final String amountToPay;
  final String cartId;
  const NeedToDoOnlinePayment({required this.orderId, required this.amountToPay,required this.cartId});

  @override
  String toString() {
    return 'NeedToDoOnlinePayment{orderId: $orderId, amountToPay: $amountToPay, cartId: $cartId}';
  }
}

class DeleteTodoError extends TODOState {
  final String? message;
  const DeleteTodoError(this.message);
}
class DeleteTodoSuccessfully extends TODOState {}
class DeleteTodoLoading extends TODOState {}


class AddTodoError extends TODOState {
  final String? message;
  const AddTodoError(this.message);
}
class AddTodoSuccessfully extends TODOState {}
class AddTodoLoading extends TODOState {}