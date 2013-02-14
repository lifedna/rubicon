class MachinesController < ApplicationController
  def index
    @machines = Machine.all.sort_by(&:dns_name)
  end

  def new
    @machine = Machine.new
  end

  def edit
    @machine = Machine.find(params[:id])
  end

  def show
    @machine = Machine.find(params[:id])
  end

  def create
    @machine = Machine.new(params[:machine])

    respond_to do |format|
      if @machine.save
        format.html { redirect_to machines_url,
                      notice: 'Machine was successfully created.' }
        format.json { render json: @machine,
                             status: :created,
                             location: @machine }
      else
        flash.now[:error] = "There was a problem"
        format.html { render action: "new" }
        format.json { render json: @machine.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def update
    @machine = Machine.find(params[:id])

    respond_to do |format|
      if @machine.update_attributes(params[:machine])
        format.html { redirect_to machines_url,
                      notice: 'Machine was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @machine = Machine.find(params[:id])
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to machines_url }
      # format.json { head :ok }
    end
  end

end
