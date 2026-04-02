
import 'package:auction_clean_arch/core/errors/exceptions.dart';
import 'package:auction_clean_arch/core/errors/failures.dart';
import 'package:auction_clean_arch/core/network/result.dart';

// Future<Result<R>>handleResult<R>({
//   required Future<R> Function() remoteCall,
//   // required R Function(T data) mapper,
// }) async {
//   try {
//     final result = await remoteCall();
//     return Result.success(result);
//   } on NetworkException catch (e) {
//     return Result.failure(Failure(e.errorModel.errorMessage));
//   } on ServerException catch (e) {
//     return Result.failure(Failure(e.errorModel.errorMessage));
//   } catch (e) {
//     return Result.failure(Failure(e.toString()));
//   }
// }

Future<Result<R>> handleResult<T, R>({
  required Future<T> Function() remoteCall,
  R Function(T data)? mapper, // optional
}) async {
  try {
    final result = await remoteCall();
    // إذا لم يُمرر mapper، اعتبر الـ result هو نفسه
    final mappedResult = mapper != null ? mapper(result) : result as R;
    return Result.success(mappedResult);
  } on NetworkException catch (e) {
    return Result.failure(Failure(e.errorModel.errorMessage));
  } on ServerException catch (e) {
    return Result.failure(Failure(e.errorModel.errorMessage));
  } catch (e) {
    return Result.failure(Failure(e.toString()));
  }
}




Future<Result<void>> handleResultVoid({
  required Future<void> Function() remoteCall
})async {
  try {
     await remoteCall();
    return Result.success(null);
  } on NetworkException catch (e) {
    return Result.failure(Failure(e.errorModel.errorMessage));
  } on ServerException catch (e) {
    return Result.failure(Failure(e.errorModel.errorMessage));
  } catch (e) {
    return Result.failure(Failure(e.toString()));
  }
}
