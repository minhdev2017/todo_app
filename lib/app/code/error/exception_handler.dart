
import 'failure.dart';

Failure handleException(Exception e){
  return ServerUnknownFailure(message: e.toString());
}