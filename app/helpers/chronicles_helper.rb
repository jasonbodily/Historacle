module ChroniclesHelper
  def get_chronicle_date(chronicle)
    first = chronicle.first_date
    last = chronicle.last_date
    _first = (first ? first.strftime("%Y") : "")
    _last = (last ? last.strftime("%Y") : "")
    "#{_first} - #{_last}"
  end

end
