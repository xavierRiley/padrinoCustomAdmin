Admin.controllers :musicians do

  get :index do
    @musicians = Musician.find(:all, :order => 'position')
    render 'musicians/index'
  end

  get :new do
    @musician = Musician.new
    render 'musicians/new'
  end

  post :create do
    @musician = Musician.new(params[:musician])
    if @musician.save
      flash[:notice] = 'Musician was successfully created.'
      redirect url(:musicians, :index)
    else
      render 'musicians/new'
    end
  end

  get :edit, :with => :id do
    @musician = Musician.find(params[:id])
    render 'musicians/edit'
  end

  put :update, :with => :id do
    @musician = Musician.find(params[:id])
    if @musician.update_attributes(params[:musician])
      flash[:notice] = 'Musician was successfully updated.'
      redirect url(:musicians, :index)
    else
      render 'musicians/edit'
    end
  end

  delete :destroy, :with => :id do
    musician = Musician.find(params[:id])
    if musician.destroy
      flash[:notice] = 'Musician was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Musician!'
    end
    redirect url(:musicians, :index)
  end
end
