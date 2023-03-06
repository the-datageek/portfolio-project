class ProjectController < AppController

    set :views, './app/views'
  
    # a method to dispaly a small welcome message using a get method
    get '/hello' do
      "You are in the Project-Controller"
    end
  
    # @method: Add a new project to our DB
    post '/project/create' do
      begin
        project = Project.create( self.data(create:true) )
        json_response(code: 201, data: project)
      rescue => e
        json_response(code: 404, data: { error: e.message} )
      end
    end
  
    # @method that displays all the projects created by our post method
    get '/project' do
      project = Project.all
      json_response(code: 200, data: project)
    end
  
    # @view: this renders an erb file which shows all our projects
    # erb will have a content type because we want to override the default set above
    get 'view/project' do
      @project = Project.all.map { |project|
      {
        project: project,
        badge: project_status_badge(project.status)
      }
    }
    @i = 1
    erb_response :project
    end
  
    # @method which allows us to update the already created project according to the :id given to each item in the db
    put '/project/update/:id' do
      begin
        project = Project.find(self.project_id)
        project.update(self.data)
        json_response(data: { message: "project updated successfully" })
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    end
  
    # @method that deletes a project based on the :id selected
    delete '/project/destroy/:id' do
      begin
      project = Project.find(self.project_id)
      project.destroy
      json_response(data: { meassage: "project deleted successfully" })
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    end
  
  
    private
  
    # @helper: helps us to format body data
    def data(create: false)
      payload = JSON.parse(request.body.read)
      if create
        payload["createdAt"] = Time.now
      end
      payload
    end
  
    # @helper: helps us to retrieve project :id
    def project_id
      params['id'].to_i
    end
  
    # @helper: helps in formatting status style
    def project_status_badge(status)
      case status
      when 'CREATED'
        'bg-info'
      when 'ONGOING'
        'bg-success'
      when 'CANCELLED'
        'bg-primary'
      when 'COMPLETED'
        'bg-warning'
      else
        'bg-dark'
      end
    end
  
  end