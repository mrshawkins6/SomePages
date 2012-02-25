class AnketaController < ApplicationController
	
  before_filter :require_signed_in

  # GET /anketa
  # GET /anketa.json
  def index
    @anketa = Anketum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @anketa }
    end
  end

  # GET /anketa/1
  # GET /anketa/1.json
  def show
  
    @anketum = Anketum.find(params[:id])
	
	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @anketum }
    end
  end

  # GET /anketa/new
  # GET /anketa/new.json
  def new
    @notebook = current_user.notebook
	@anketum = Anketum.new(:notebook_id => !@notebook != nil ? @notebook.id : nil )
	5.times{ @anketum.questions.build }
	
	  respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @anketum }
    end
  end

  # GET /anketa/1/edit
  def edit
    @anketum = Anketum.find(params[:id])
	
	querstions_size = @anketum.questions.count

	if querstions_size < 5 
	
		(5 - querstions_size).times{ @anketum.questions.build } 
	
	end
	
  end

  # POST /anketa
  # POST /anketa.json
  def create
    @anketum = Anketum.new(params[:anketum])

    respond_to do |format|
      if @anketum.save
        format.html { redirect_to @anketum, notice: 'Anketum was successfully created.' }
        format.json { render json: @anketum, status: :created, location: @anketum }
      else
        format.html { render action: "new" }
        format.json { render json: @anketum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /anketa/1
  # PUT /anketa/1.json
  def update
    @anketum = Anketum.find(params[:id])
	
	querstions_size = @anketum.questions.count

	if querstions_size < 5 
	
		(5 - querstions_size).times{ @anketum.questions.build } 
	
	end

    respond_to do |format|
      if @anketum.update_attributes(params[:anketum])
        format.html { redirect_to @anketum, notice: 'Anketum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @anketum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anketa/1
  # DELETE /anketa/1.json
  def destroy
    @anketum = Anketum.find(params[:id])
    @anketum.destroy

    respond_to do |format|
      format.html { redirect_to anketa_url }
      format.json { head :no_content }
    end
  end
end
