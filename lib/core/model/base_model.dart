
import 'package:google_sheet_test/core/entity/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  T toEntity();
}
