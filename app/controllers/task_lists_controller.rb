class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show, :edit, :update, :destroy]

  # GET /task_lists
  # GET /task_lists.json
  def index # TODO: SELECT * FROM task_lists WHERE user_id = <authenticated_user_id>
    @task_lists = TaskList.where(user_id: session[:user_id]).order(:name)
    if !self.logged_in?
      respond_to do |format|
        flash[:error] = "You must be logged in to go to that page"
        format.html { redirect_to new_session_url }
        format.json { render "sessions/new", status: :unauthorized, location: :session}
      end
    end
    #@task_lists = TaskList.all.order(:name)
  end

  # GET /task_lists/1
  # GET /task_lists/1.json
  def show
    # @task_list = TaskList.find(params[:id])
    @tasks = TaskList.find(params[:id]).tasks
  end

  # GET /task_lists/new
  def new
    @task_list = TaskList.new
  end

  # GET /task_lists/1/edit
  def edit
  end

  # POST /task_lists
  # POST /task_lists.json
  def create
    @task_list = TaskList.new(task_list_params)
    @task_list[:user_id] = current_user().id
    logger.debug 'task_lists#create called'
    logger.debug @task_list.inspect
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to @task_list, notice: 'Task list was successfully created' }
        format.json { render :show, status: :created, location: @task_list }
      else
        format.html do 
          flash[:error] = @task_list.errors.messages.values
          render :new, error: @task_list.errors

        end
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_lists/1
  # PATCH/PUT /task_lists/1.json
  def update
    respond_to do |format|
      if @task_list.update(task_list_params)
        format.html { redirect_to @task_list, notice: 'Task list was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_list }
      else
        format.html { render :edit }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_lists/1
  # DELETE /task_lists/1.json
  def destroy
    @task_list.destroy
    respond_to do |format|
      format.html { redirect_to task_lists_url, notice: 'Task list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_list_params
      params.require(:task_list).permit(:name)
    end
end
