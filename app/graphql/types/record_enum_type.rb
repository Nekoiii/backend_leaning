module Types
  class RecordEnumType < BaseEnum
    # BaseEnum: https://zenn.dev/nisitin/articles/ebb278cd92f69d
    Record::RECORD_TYPES.keys.each do |key|
      value key.to_s.upcase, "A record of type #{key}", value: key.to_s
    end
  end

  class RecordStatusEnumType < BaseEnum
    Record::RECORD_STATUS.keys.each do |key|
      value key.to_s.upcase, "A record with status #{key}", value: key.to_s
    end
  end
end
