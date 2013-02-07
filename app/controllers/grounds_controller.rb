class GroundsController < ApplicationController
  # GET /grounds
  # GET /grounds.json
  def index
    begin

      if( params[:lat] == 'null' ||   params[:lng] == 'null' )
        @grounds = Ground.order("\"groundName\" ASC") # gets all grounds ordered by name
      else
        all_grounds_order_by_name = Ground.where("\"groundName\" != 'Non League/Grassroots'").order("\"groundName\" ASC")
        other_ground = Ground.where("\"groundName\" = 'Non League/Grassroots'")
        nearest_grounds = Ground.near( [params[:lat], params[:lng]], 3, :order => :distance )
        @grounds = nearest_grounds + other_ground + (all_grounds_order_by_name - nearest_grounds)
      end

    rescue => e
      @grounds = nil;
      puts '> error getting grounds' + e.message
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grounds }
    end
  end

  # GET /grounds/1
  # GET /grounds/1.json
  def show
    @ground = Ground.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ground }
    end
  end

  # # GET /grounds/new
  # # GET /grounds/new.json
  # def new
  #   @ground = Ground.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @ground }
  #   end
  # end

  # # GET /grounds/1/edit
  # def edit
  #   @ground = Ground.find(params[:id])
  # end

  # # POST /grounds
  # # POST /grounds.json
  # def create
  #   @ground = Ground.new(params[:ground])

  #   respond_to do |format|
  #     if @ground.save
  #       format.html { redirect_to @ground, notice: 'Ground was successfully created.' }
  #       format.json { render json: @ground, status: :created, location: @ground }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @ground.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PUT /grounds/1
  # # PUT /grounds/1.json
  # def update
  #   @ground = Ground.find(params[:id])

  #   respond_to do |format|
  #     if @ground.update_attributes(params[:ground])
  #       format.html { redirect_to @ground, notice: 'Ground was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @ground.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /grounds/1
  # # DELETE /grounds/1.json
  # def destroy
  #   @ground = Ground.find(params[:id])
  #   @ground.destroy

  #   respond_to do |format|
  #     format.html { redirect_to grounds_url }
  #     format.json { head :no_content }
  #   end
  # end
end
