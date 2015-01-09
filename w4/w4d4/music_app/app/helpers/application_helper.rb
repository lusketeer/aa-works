module ApplicationHelper


  def authenticity_input(token)
    "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{token}\">".html_safe
  end

  def method_override(action)
    return "<input type=\"hidden\" name=\"_method\" value=\"patch\">".html_safe if action == "edit"
    "".html_safe
  end

  def bootstrap_class_for flash_type
    case flash_type
    when "notice"
      "alert-success"
    when "errors"
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
