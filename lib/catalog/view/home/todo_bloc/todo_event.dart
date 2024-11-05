
part of 'todo_bloc.dart';

abstract class TODOEvent extends Equatable {
  const TODOEvent();
  @override
  List<Object?> get props => [];
}
class DeleteTodo extends TODOEvent{
  final int id;
  const DeleteTodo(this.id);
}

class AddTodo extends TODOEvent{
  final ToDo newTodo;
  const AddTodo(this.newTodo);
}



/*
class DoOrderPayment extends TODOEvent {
  final String amount;
  final String cartId;
  final String orderId;
  final PaymentMethod paymentMethod;
  const DoOrderPayment({required this.amount,required this.cartId,required this.orderId,required this.paymentMethod});
}*/
