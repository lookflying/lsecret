class RecordsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    if user_signed_in? 
      @expense = Record.sum(:expense)
      @income = Record.sum(:income)
      @balance = @income - @expense
      if params.has_key? :order
        session[:order] = params[:order]
      elsif session.has_key? :order
        params[:order] = session[:order]
      else
        params[:order] = :day
      end
      @fields = Record.column_names
      if !@fields.include? params[:order]
        redirect_to records_path(:order => :day)
      end
      @records = Record.order(params[:order]).reverse_order
    else
      @expense = Record.sum(:expense)
      @income = Record.sum(:income)
      @balance = @income - @expense
      @records = Record.order(:day).reverse_order.limit(10)
    end
  end

  def show
    @record = Record.find(params[:id])

  end

  def new
    @record = Record.new

  end

  def edit
    @record = Record.find(params[:id])
  end
  
  def create
    @record = Record.new(params[:record])

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render json: @record, status: :created, location: @record }
      else
        format.html { render action: "new" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
end
