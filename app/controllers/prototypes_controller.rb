class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_edit,  except: [:index, :show, :new, :create, :destroy, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create 
    @prototype = Prototype.create(prototype_params)

    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

    if @prototype.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy

    redirect_to root_path
    
  end

  private

  def prototype_params
    params.require(:prototype).permit(:concept, :title, :catch_copy, :image).merge(user_id: current_user.id)
    #imageという名前で送られてきた画像の保存を許可する

  end

  def move_to_edit
    prototype = Prototype.new
    unless current_user.id == prototype.user_id 
      redirect_to action: :index
    end
  end

end
