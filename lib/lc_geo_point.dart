part of leancloud_storage;

/// 地理坐标
class LCGeoPoint {
  /// 纬度
  double latitude;

  /// 经度
  double longitude;

  /// 创建纬度 [latitude]，经度 [longitude] 的坐标对象
  LCGeoPoint(this.latitude, this.longitude);

  /// 原点坐标
  LCGeoPoint.origin() {
    latitude = 0;
    longitude = 0;
  }

  /// 到 [point] 的距离（单位：千米）
  double kilometersTo(LCGeoPoint point) {
    if (point == null) {
      throw new ArgumentError.notNull('point');
    }
    return radiansTo(point) * 6371.0;
  }

  /// 到 [point] 的距离（单位：英里）
  double milesTo(LCGeoPoint point) {
    return radiansTo(point) * 3958.8;
  }

  /// 到 [point] 的弧度
  double radiansTo(LCGeoPoint point) {
    if (point == null) {
      throw new ArgumentError.notNull('point');
    }
    double d2r = pi / 180.0;
    double lat1rad = latitude * d2r;
    double long1rad = longitude * d2r;
    double lat2rad = point.latitude * d2r;
    double long2rad = point.longitude * d2r;
    double deltaLat = lat1rad - lat2rad;
    double deltaLong = long1rad - long2rad;
    double sinDeltaLatDiv2 = sin(deltaLat / 2);
    double sinDeltaLongDiv2 = sin(deltaLong / 2);
    double a = sinDeltaLatDiv2 * sinDeltaLatDiv2 +
        cos(lat1rad) * cos(lat2rad) * sinDeltaLongDiv2 * sinDeltaLongDiv2;
    a = min(1.0, a);
    return 2 * sin(sqrt(a));
  }
}
