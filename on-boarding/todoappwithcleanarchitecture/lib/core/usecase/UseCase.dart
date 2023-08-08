import 'package:dartz/dartz.dart';
import 'package:todoappwithcleanarchitecture/core/failure/failure.dart';

abstract class UseCase<T, P> {
  T call(P params);
}