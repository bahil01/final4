class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.all

    render("symptoms/index.html.erb")
  end

  def show
    @symptom = Symptom.find(params[:id])

    render("symptoms/show.html.erb")
  end

  def new
    @symptom = Symptom.new

    render("symptoms/new.html.erb")
  end

  def create
    @symptom = Symptom.new

    @symptom.symptom_name = params[:symptom_name]

    save_status = @symptom.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/symptoms/new", "/create_symptom"
        redirect_to("/symptoms")
      else
        redirect_back(:fallback_location => "/", :notice => "Symptom created successfully.")
      end
    else
      render("symptoms/new.html.erb")
    end
  end

  def edit
    @symptom = Symptom.find(params[:id])

    render("symptoms/edit.html.erb")
  end

  def update
    @symptom = Symptom.find(params[:id])

    @symptom.symptom_name = params[:symptom_name]

    save_status = @symptom.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/symptoms/#{@symptom.id}/edit", "/update_symptom"
        redirect_to("/symptoms/#{@symptom.id}", :notice => "Symptom updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Symptom updated successfully.")
      end
    else
      render("symptoms/edit.html.erb")
    end
  end

  def destroy
    @symptom = Symptom.find(params[:id])

    @symptom.destroy

    if URI(request.referer).path == "/symptoms/#{@symptom.id}"
      redirect_to("/", :notice => "Symptom deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Symptom deleted.")
    end
  end
end
