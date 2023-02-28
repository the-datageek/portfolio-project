class SkillController < AppController

    set :views, './app/views'

    # @method: Display a small welcome message
    get '/hello' do
        "Our very first controller"
    end

    # @method: Add a new TO-DO to the DB
    post '/skill/create' do
        begin
            skill = Skill.create( self.data(create: true) )
            json_response(code: 201, data: skill)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    # @method: Display all skills
    get '/skill' do
        skill = Skill.all
        json_response(data: skills)
    end

    # @view: Renders an erb file which shows all skills
    # erb has content_type because we want to override the default set above
    get '/' do
        @skills = Skill.all.map { |todo|
          {
            skill: skill,
            badge: skill_status_badge(skill.status)
          }
        }
        @i = 1
        erb_response :skills
    end

    # @method: Update existing TO-DO according to :id
    put '/skill/update/:id' do
        begin
            skill = Skill.find(self.skill_id)
            skill.update(self.data)
            json_response(data: { message: "skill updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete TO-DO based on :id
    delete '/skill/destroy/:id' do
        begin
            skill = Skill.find(self.skill_id)
            skill.destroy
            json_response(data: { message: "skill deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end


    private

    # @helper: format body data
    def data(create: false)
        payload = JSON.parse(request.body.read)
        if create
            payload["createdAt"] = Time.now
        end
        payload
    end

    # @helper: retrieve to-do :id
    def skill_id
        params['id'].to_i
    end

    # @helper: format status style
    def skill_status_badge(status)
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