class TaskManagerApp < Sinatra::Base

  get '/' do
    @tasks = task_manager.all
    erb :dashboard
  end

  get '/tasks' do
    @tasks = task_manager.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task_manager.create(params[:task])
    redirect '/tasks'
  end

  get '/tasks/:id' do
    @task = task_manager.find(params[:id].to_i)
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = task_manager.find(params[:id].to_i)
    erb :edit
  end

  put '/tasks/:id' do
    task_manager.update(params[:id].to_i, params[:task])
    redirect '/tasks'
  end

  delete '/tasks/:id' do
    task_manager.destroy(params[:id].to_i)
    redirect '/tasks'
  end

  def task_manager
    if ENV['RACK_ENV'] == 'test'
      task_database = YAML::Store.new("to_do/task_list_test")
    else
      task_database = YAML::Store.new("to_do/task_list")
    end
    @manager ||= TaskManager.new(task_database)
  end
end
