class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :move_up, :move_down]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @task.task_list_id = params[:task_list_id]

  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task_list = @task.task_list
    @task.insert_at(1)
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_list_url(@task_list), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: task_list_url(@task_list) }
      else
        # format.html { redirect_to new_task_url(:params => { :list => @task_list.id }), notice: @task.errors.messages}
        format.html { render :new, error: @task.errors.messages.values}
        format.json { render json: @task.errors.messages.inspect, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      #new_name = { :name => params.require(:name) } 
      # @task.update_attributes(task_params)
      @task_list = @task.task_list
      if @task.update(task_params)
        format.html { redirect_to @task_list, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_list }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  #PATCH/PUT /tasks/1/move_up
  #PATCH/PUT /tasks/1/move_up.json
  # def move
  #   respond_to do |format|
  #     @task_list = @task.task_list
  #     @task.move_higher
  #     if @task.update(task_params)
  #       format.html { redirect_to @task_list, notice: 'Task was successfully moved up.' }
  #       format.json { render :show, status: :ok, location: @task_list }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @task.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #PATCH/PUT /tasks/1/move/up
  #PATCH/PUT /tasks/1/move/down.json
  def move
    respond_to do |format|
      move_params = params.require(:task).permit(:count)
      count = move_params[:count].to_i
      direction = params[:dir].to_sym

      if !@task
        @task = Task.find(params[:id])
      end

      @task_list = @task.task_list
      # @tasks = @task_list.tasks
      
      if direction == :up
        if @task.position - count > 0
          @task.insert_at(@task.position - count)
        end
      elsif direction == :down 
        @task.insert_at(@task.position + count)
      else
        raise ActionController::BadRequest.new "Move direction must be 'up' or 'down'."
      end

      save_successful = @task.save
      @tasks = @task.task_list.tasks
      if save_successful
        flash[:notice] = ['Successfully moved the task.']
        format.html { redirect_to @task_list, notice: 'Successfully moved the task.' }
        # format.html { render "task_lists/show" }
        format.json { render "task_lists/show", status: :ok }#, location: @task_list }
      else
        format.html { render "task_lists/show"}
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task_list = @task.task_list
    @task.destroy
    respond_to do |format|
      format.html { redirect_to task_list_url(@task_list), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task_list_id, :name, :description, :status, :position)
    end
end
