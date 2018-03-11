class CancersController < ApplicationController
  before_action :current_user_must_be_cancer_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_cancer_user
    cancer = Cancer.find(params[:id])

    unless current_user == cancer.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @cancers = current_user.cancer.page(params[:page]).per(10)

    render("cancers/index.html.erb")
  end

  def show
    @cancer = Cancer.find(params[:id])

    render("cancers/show.html.erb")
  end

  def new
    @cancer = Cancer.new

    render("cancers/new.html.erb")
  end

  def create
    @cancer = Cancer.new

    @cancer.user_id = params[:user_id]
    @cancer.cancer_name = params[:cancer_name]

    save_status = @cancer.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/cancers/new", "/create_cancer"
        redirect_to("/cancers")
      else
        redirect_back(:fallback_location => "/", :notice => "Cancer created successfully.")
      end
    else
      render("cancers/new.html.erb")
    end
  end

  def edit
    @cancer = Cancer.find(params[:id])

    render("cancers/edit.html.erb")
  end

  def update
    @cancer = Cancer.find(params[:id])
    @cancer.cancer_name = params[:cancer_name]

    save_status = @cancer.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/cancers/#{@cancer.id}/edit", "/update_cancer"
        redirect_to("/cancers/#{@cancer.id}", :notice => "Cancer updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Cancer updated successfully.")
      end
    else
      render("cancers/edit.html.erb")
    end
  end

  def destroy
    @cancer = Cancer.find(params[:id])

    @cancer.destroy

    if URI(request.referer).path == "/cancers/#{@cancer.id}"
      redirect_to("/", :notice => "Cancer deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Cancer deleted.")
    end
  end
end
