import 'package:edge_library_common/src/models/base_model.dart';

abstract class BaseResponse<T extends BaseModel> {
  const BaseResponse(this.data);

  final T data;
}

abstract class BaseListResponse<T extends List<BaseModel>> {
  const BaseListResponse(this.data);

  final T data;
}
