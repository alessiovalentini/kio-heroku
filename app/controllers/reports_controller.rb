require 'date'

class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  # def show
  #   @report = Report.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @report }
  #   end
  # end

  # GET /reports/new
  # GET /reports/new.json
  # def new
  #   @report = Report.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @report }
  #   end
  # end

  # GET /reports/1/edit
  # def edit
  #   @report = Report.find(params[:id])
  # end

  # POST /reports
  # POST /reports.json
  def create

    begin

      report_list = params[:reportList]

      # create an object for each element of the array
      report_list.each do |object|
        # remove the sencha id
        object.delete(:id)

        # convert datetime in rails format (by Manuel Olvera)
        # dateAndTime  = object[:reportDate].split(' ')
        # dateOnly     = dateAndTime[0].split('/')
        # timeOnly     = dateAndTime[1].split(':')

        # heroku_date = dateOnly[2] + '-' + dateOnly[1] + '-' + dateOnly[0] + 'T' + timeOnly[0] + ':' + timeOnly[1] + ':00+00:00'
        # object[:reportDate] = DateTime.new(dateOnly[0],dateOnly[1],dateOnly[2],timeOnly[0],timeOnly[1],timeOnly[2])
        # object[:reportDate] = DateTime.parse(object[:reportDate])
        # object[:reportDate] = heroku_date
        # save record locally
        Report.create( object )
      end

      # set success status
      saved  = params[:reportList]
      @status = { :status => '200', :statusText => 'success', :saved => saved }

    rescue => e
      puts '> error saving reports ' + e.message
      # set error status
      @status = { :status => '500', :statusText => e.message, :saved => nil }
    end

    respond_to do |format|
      # if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        # format.json { render json: @report, status: :created, location: @report }
        format.json { render json: @status, status: :ok, location: @report }
      # else
      #   format.html { render action: "new" }
      #   format.json { render json: @report.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  # def update
  #   @report = Report.find(params[:id])

  #   respond_to do |format|
  #     if @report.update_attributes(params[:report])
  #       format.html { redirect_to @report, notice: 'Report was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @report.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /reports/1
  # # DELETE /reports/1.json
  # def destroy
  #   @report = Report.find(params[:id])
  #   @report.destroy

  #   respond_to do |format|
  #     format.html { redirect_to reports_url }
  #     format.json { head :no_content }
  #   end
  # end
end
