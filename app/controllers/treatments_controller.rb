class TreatmentsController < ApplicationController
  def index
    @treatments = Treatment.all

    render("treatments/index.html.erb")
  end

  def show
    @treatment = Treatment.find(params[:id])

    render("treatments/show.html.erb")
  end

  def new
    @treatment = Treatment.new

    render("treatments/new.html.erb")
  end

  def create
    @treatment = Treatment.new

    @treatment.user_id = params[:user_id]
    @treatment.treatment_name = params[:treatment_name]

    save_status = @treatment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/treatments/new", "/create_treatment"
        redirect_to("/treatments")
      else
        redirect_back(:fallback_location => "/", :notice => "Treatment created successfully.")
      end
    else
      render("treatments/new.html.erb")
    end
  end

  def edit
    @treatment = Treatment.find(params[:id])

    render("treatments/edit.html.erb")
  end

  def update
    @treatment = Treatment.find(params[:id])

    @treatment.user_id = params[:user_id]
    @treatment.treatment_name = params[:treatment_name]

    save_status = @treatment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/treatments/#{@treatment.id}/edit", "/update_treatment"
        redirect_to("/treatments/#{@treatment.id}", :notice => "Treatment updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Treatment updated successfully.")
      end
    else
      render("treatments/edit.html.erb")
    end
  end

  def destroy
    @treatment = Treatment.find(params[:id])

    @treatment.destroy

    if URI(request.referer).path == "/treatments/#{@treatment.id}"
      redirect_to("/", :notice => "Treatment deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Treatment deleted.")
    end
  end
end
