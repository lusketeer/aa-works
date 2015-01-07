module CatsHelper
  def toggle_order
      params[:order] == "asc" ? "desc" : "asc"
  end
end
