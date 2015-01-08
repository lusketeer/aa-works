module ApplicationHelper
  def current_location
  #  city = request.location.city
  #  state = request.location.state
  #  city == "" ? "Nowhere" : "#{city}, #{state}"
   u = UserToken.find_by(session_token: session[:session_token])
   u.nil? ? " " : u.ip_address
  end
end
