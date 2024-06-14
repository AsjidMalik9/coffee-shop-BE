class DealSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :overall_discount

  attribute :start_date do |object|
    format_date(object.start_date)
  end

  attribute :end_date do |object|
    format_date(object.end_date)
  end

  private

  def self.format_date(date)
    day = date.day
    suffix = case day % 10
             when 1 then (day % 100 == 11 ? 'th' : 'st')
             when 2 then (day % 100 == 12 ? 'th' : 'nd')
             when 3 then (day % 100 == 13 ? 'th' : 'rd')
             else 'th'
             end

    date.strftime("%-d#{suffix} %B %A")
  end
end
