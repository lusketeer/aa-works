module ApplicationHelper
  def authenticity_input(token)
    "<input type=\"hidden\" value=\"#{token}\" name=\"authenticity_token\">".html_safe
  end

  def bootstrap_class_for flash_type
    case flash_type
    when "notice"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-block"
    when "info"
      "alert-info"
    else
      flash_type.to_s
    end
  end
end
