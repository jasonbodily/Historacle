class EventsController < ApplicationController
  before_filter :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @chronicle = @event.chronicle
    @events = @chronicle.events.order(sort_column2 + " " + sort_direction2).paginate(:per_page =>10, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render :show }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @chronicle = Chronicle.find(params[:chronicle_id])
    @event = @chronicle.events.build

    respond_to do |format|
      format.js { render :new }
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @chronicle = Chronicle.find(params[:chronicle_id])
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @chronicle = Chronicle.find(params[:chronicle_id])
    @events = @chronicle.events.order(sort_column2 + " " + sort_direction2).paginate(:per_page =>10, :page => params[:page])
    @event = @chronicle.events.build(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @chronicle, notice: 'Event was successfully created.' }
        format.js { render :show, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @chronicle = Chronicle.find(params[:chronicle_id])
    @events = @chronicle.events.order(sort_column2 + " " + sort_direction2).paginate(:per_page =>10, :page => params[:page])
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @chronicle, notice: 'Event was successfully updated.' }
        format.js { render :show, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @chronicle = Chronicle.find(params[:chronicle_id])
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to @chronicle, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def import
    @chronicle = Chronicle.find(params[:chronicle_id])
    Event.import(params[:file], @chronicle)
    redirect_to @chronicle, notice: "Events Imported"
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
