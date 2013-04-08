class ChroniclesController < ApplicationController
  before_filter :authenticate_user!

  # GET /chronicles
  # GET /chronicles.json
  def index
    @chronicles = current_user.library.chronicles.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @chronicles }
    #end
  end

  # GET /chronicles/1
  # GET /chronicles/1.json
  def show
    @chronicle = Chronicle.find(params[:id])
    @events =  @chronicle.events.order(sort_column2 + " " + sort_direction2).paginate(:per_page =>10, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chronicle }
    end
  end

  # GET /chronicles/new
  # GET /chronicles/new.json
  def new
    @library = current_user.library
    @chronicle = @library.chronicles.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chronicle }
    end
  end

  # GET /chronicles/1/edit
  def edit
    @library = current_user.library
    @chronicle = Chronicle.find(params[:id])
  end

  # POST /chronicles
  # POST /chronicles.json
  def create
    @library = current_user.library
    @chronicle = @library.chronicles.build(params[:chronicle])

    respond_to do |format|
      if @chronicle.save
        format.html { redirect_to @chronicle, notice: 'Chronicle was successfully created.' }
        format.json { render json: @chronicle, status: :created, location: @chronicle }
      else
        format.html { render action: "new" }
        format.json { render json: @chronicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chronicles/1
  # PUT /chronicles/1.json
  def update
    @chronicle = Chronicle.find(params[:id])

    respond_to do |format|
      if @chronicle.update_attributes(params[:chronicle])
        format.html { redirect_to @chronicle, notice: 'Chronicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chronicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chronicles/1
  # DELETE /chronicles/1.json
  def destroy
    @chronicle = Chronicle.find(params[:id])
    @chronicle.destroy

    respond_to do |format|
      format.html { redirect_to library_path }
      format.json { head :no_content }
    end
  end

  #Railscasts 228
  helper_method :sort_column, :sort_direction
  private

  def sort_column
    (Chronicle.column_names.include?(params[:sort])) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column2
    (Event.column_names.include?(params[:sort])) ? params[:sort] : "title"
  end

  def sort_direction2
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
