Admin.controllers :base do

  get :index, :map => "/" do
    render "base/index"
  end
  
  get :toggle, :map => "toggle/:model_name/:field_name/:id" do
    @currentModel = params[:model_name].singularize.camelize.constantize
    @currentModel.find(params[:id]).toggle!(params[:field_name])
    redirect "admin/" + params[:model_name]
  end

end
