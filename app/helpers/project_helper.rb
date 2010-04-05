module ProjectHelper
  def convert_to_date(string_date)
    unless string_date.nil?
      return Date.parse(string_date)
    end
    return Date.today
  end
  def generate_check_box_tag(metric)
    if metric.mandatory == "yes"
      check_box_tag "metrics[#{metric.key}]", "yes", true, :disabled =>true
    else
      check_box_tag "metrics[#{metric.key}]", "yes", @project.metrics[metric.key]
    end
  end
  def generate_form_tag_for_property(property)
    if property.type == "date"
      date = convert_to_date(property.value)
      text_field_tag "properties[#{property.key}]", @project.properties[property.key], :class => "datepicker"
    else
      text_field_tag "properties[#{property.key}]", @project.properties[property.key]
    end
  end
end
