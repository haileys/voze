class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value and value.include? "@" and value.size >= 3
      record.errors[attribute] << "doesn't look like a valid email address"
    end
  end
end