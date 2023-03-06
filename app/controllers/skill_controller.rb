class SkillController < AppController

    set :views, './app/views'
  
    # @method which will display a small welcome message
    get '/hello' do
      "You are in the Skill Controller go a head and add your skills"
    end
  
    # @method: Adds a new created skill to the DB
    post '/skills/create' do
      begin
        skill = Skill.create( self.data(create: true) )
        json_response(code: 201, data: skill)
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    end
  
  
    # @method which displays all skills in our DB
    get '/skills' do
      skills = Skill.all
      json_response(data: skills)
    end
  
    # @view that renders an erb file o/p if any and shows a list of all projects
    # erb has content_type because we want to override the deafult set above
    get '/' do
      @skills = Skill.all.map { |skill|
      {
        skill: skill,
        badge: skill_status_badge(Skill.status)
      }
      }
      @i = 1
      erb_response :skills
    end
  
    # @method which updates a specific skill using its :id as reference
    put '/skills/update/:id' do
      begin
        skill = Skill.find(self.skill_id)
        Skill.update(self.data)
        json_response(data: { message: 'Skill updated successfully' })
      rescue => e
          json_response(code: 422, data: { error: e.message })
      end
    end
  
    # @method that deletes a skill from the DB using its :id
    delete '/skills/destroy/:id' do
      begin
        skill = Skill.find(self.skill_id)
        Skill.destroy
        json_response(data: { message: 'Skill deleted successfully' })
      rescue => e
        json_response(code: 422, data: { error: e.message })
      end
    end
  
  
    private
  
    # @helper: format body data to JSON format
    def data(create: false)
      payload = JSON.parse(request.body.read)
      if create
        payload['createdAt'] = Time.now
      end
      payload
    end
  
    # @helper which assists in retreiving skill :id
    def skill_id
      params['id'].to_i
    end
  
    # @helper that formats status style
    def skill_status_badge(status)
      case status
      when 'CREATED'
        'bg-success'
      when 'ONGOING'
        'bg-suu-success'
      when 'CANCELLED'
        'bg-primary'
      when 'COMPLETED'
        'bg-warning'
      else
        'bg-dark'
      end
    end
  
  end