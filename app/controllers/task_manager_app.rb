require 'models/task_manager'
class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
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

  get '/tasks/:title' do |task|
    @task = task_manager.find(task)
    erb :show
  end

  def task_manager
    task_database = YAML::Store.new('to_do/task_manager')
    @manager ||= TaskManager.new(task_database)
  end
end
