class LogsController < ApplicationController
  before_action :current_user_must_be_log_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_log_user
    log = Log.find(params[:id])

    unless current_user == log.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.logs.ransack(params[:q])
      @logs = @q.result(:distinct => true).includes(:user, :symptom).page(params[:page]).per(10)

    render("logs/index.html.erb")
  end

  def show
    @log = Log.find(params[:id])

    render("logs/show.html.erb")
  end

  def new
    @log = Log.new

    render("logs/new.html.erb")
  end

  def create
    @log = Log.new

    @log.user_id = params[:user_id]
    @log.symptom_id = params[:symptom_id]

    save_status = @log.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/logs/new", "/create_log"
        redirect_to("/logs")
      else
        redirect_back(:fallback_location => "/", :notice => "Log created successfully.")
      end
    else
      render("logs/new.html.erb")
    end
  end

  def edit
    @log = Log.find(params[:id])

    render("logs/edit.html.erb")
  end

  def update
    @log = Log.find(params[:id])
    @log.symptom_id = params[:symptom_id]

    save_status = @log.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/logs/#{@log.id}/edit", "/update_log"
        redirect_to("/logs/#{@log.id}", :notice => "Log updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Log updated successfully.")
      end
    else
      render("logs/edit.html.erb")
    end
  end

  def destroy
    @log = Log.find(params[:id])

    @log.destroy

    if URI(request.referer).path == "/logs/#{@log.id}"
      redirect_to("/", :notice => "Log deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Log deleted.")
    end
  end
end
