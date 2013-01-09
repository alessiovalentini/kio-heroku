class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index


    begin

      if( params[:delimitationDate] == 'null' )
        @news = News.order("date DESC").limit(6) # Gets more news
        # @news = 'more'
      else
        # converts date
        # dateAndTime = params[:delimitationDate].split(' ')
        # onlyDate = dateAndTime[0].split('/')
        # onlyTime = dateAndTime[1].split(':')
        # delimitationDate = DateTime.new(onlyDate[0],onlyDate[1],onlyDate[2],onlyTime[0],onlyTime[1],onlyTime[2])

        puts params[:delimitationDate]

        if( params[:latestOrMore] == 'more' )
          @news = News.where("date < ?", params[:delimitationDate]).limit(6).order("date DESC") # Gets more news
          # News.where("date > ?", "2012-12-10 12:59:04").limit(4).order("date DESC")
          # @news = 'more'
        else
          # @news = 'less'
          @news = News.where("date > ?", params[:delimitationDate]).limit(100).order("date DESC") # Gets latest news
        end
      end

    rescue => e
      @news = nil;
      puts e.message
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end

  end

  # def get
  #   if( latestOrMore == '1' )
  #     @news = 'more'
  #   else
  #     @news = 'more'
  #   end
  # end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])

    puts params[:news]

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end
end
