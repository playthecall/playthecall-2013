class PagesController < InheritedResources::Base
  layout 'static'

  def show
    @page = Page.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') if @page.locale.to_sym != locale
    super
  end
end
