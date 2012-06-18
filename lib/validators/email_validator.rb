class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value and value.include? "@"
      record.errors[attribute] << "doesn't look like a valid email address"
    end
  end
end