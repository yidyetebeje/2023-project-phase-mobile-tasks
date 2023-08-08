import 'failure.dart';

class NotFound extends Failure {
  NotFound({message = "Not Found"}) : super(message: message);
}