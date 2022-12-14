class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = Expense.where(category_id: params[:category_id]).order('created_at DESC')
    @id = params[:category_id]
  end

  # GET /entities/1 or /entities/1.json
  def show; end

  # GET /entities/new
  def new
    @expense = Expense.new
    @id = params[:category_id]
  end

  # GET /entities/1/edit
  def edit; end

  # POST /entities or /entities.json
  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    # @entity = Entity.new(entity_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to categories_url, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, :user_id, :category_id)
    # expense[:user_id] = current_user.id
    # expense
  end
end
