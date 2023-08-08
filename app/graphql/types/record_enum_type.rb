# BaseEnum: https://zenn.dev/nisitin/articles/ebb278cd92f69d
module Types
  class RecordEnumType < BaseEnum
  # hygiene: 衛生, temperature: 温度, humidity: 湿度
  RECORD_TYPES = { hygiene: 0, temperature: 1, humidity: 2 }
    RECORD_TYPES.keys.each do |key|
      value key.to_s.upcase, "A record of type #{key}", value: key.to_s
    end
  end

  class RecordStatusEnumType < BaseEnum
  # normal: 正常, overflow: 逸脱, resolved: 対応済
  RECORD_STATUS = { normal: 0, overflow: 1, resolved: 2 }
    RECORD_STATUS.keys.each do |key|
      value key.to_s.upcase, "A record with status #{key}", value: key.to_s
    end
  end

end
