import 'package:conductor/conductor.dart';

typedef CallBackFunction = void Function();
typedef TValueCallBackFunction<T> = void Function(T value);
typedef TNValueCallBackFunction<T> = void Function(T? value);
typedef FutureCallBackFunction = Future<void> Function();
typedef PathFutureCallBackFunction = Future<void> Function(String path);
typedef PathNFutureCallBackFunction = Future<void> Function(String? path);
typedef FutureWidgetRefCallBackFunction = Future<void> Function(WidgetRef ref);
typedef WidgetCallBackFunction<T> = Widget Function(T value);
typedef WidgetNCallBackFunction<T> = Widget? Function(T? value);
typedef ContextCallBackFunction = void Function(BuildContext context);
typedef StringNCallBackFunction = void Function(String? value);
typedef MapStringStringCallBackFunction = void Function(
    Map<String, String> map);
typedef FromJsonFunction<T> = T Function(Map<String, Object?> json);
typedef DynamicInputGenericAsyncFunction<T> = Future<T?> Function(
    {Map<String, Object?>? json});
typedef MapStringDateTimeCallBackFunction = void Function(
    Map<String, DateTime?> map);
typedef DateTimeRangeCallBackFunction = void Function(DateTimeRange? map);
typedef DateTimeCallBackFunction = void Function(DateTime? map);
typedef BoolCallBackFunction = void Function(bool? map);
typedef IntCallBackFunction = void Function(int? value);
typedef RefReadProvider = T Function<T>(ProviderListenable<T> provider);
typedef NavigatorPopFunction = void Function<T extends Object?>([T? result]);
