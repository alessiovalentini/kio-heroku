class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  # # GET /feedbacks/new
  # # GET /feedbacks/new.json
  # def new
  #   @feedback = Feedback.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @feedback }
  #   end
  # end

  # # GET /feedbacks/1/edit
  # def edit
  #   @feedback = Feedback.find(params[:id])
  # end

  # POST /feedbacks
  # POST /feedbacks.json
  def create

    begin

      feedback_list = params[:feedbackList]

      # create an object for each element of the array
      feedback_list.each do |object|
        # remove the sencha id
        object.delete(:id)
        # save record locally
        Feedback.create( object )
      end

      # set success status
      saved  = params[:feedbackList]
      @status = { :status => '200', :statusText => 'success', :saved => saved }

    rescue => e
      puts '> error saving feedbacks ' + e.message
      # set error status
      @status = { :status => '500', :statusText => e.message, :saved => nil }
    end

    respond_to do |format|
        format.html { redirect_to @feedbacks, notice: 'Feedback was successfully created.' }
        format.json { render json: @status, status: :ok, location: @feedbacks }
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  # def update
  #   @feedback = Feedback.find(params[:id])

  #   respond_to do |format|
  #     if @feedback.update_attributes(params[:feedback])
  #       format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @feedback.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  # def destroy
  #   @feedback = Feedback.find(params[:id])
  #   @feedback.destroy

  #   respond_to do |format|
  #     format.html { redirect_to feedbacks_url }
  #     format.json { head :no_content }
  #   end
  # end
end
