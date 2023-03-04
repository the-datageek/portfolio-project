class SkillController < AppController

    set :views, '../views/project.erb'


    post '/skills/create' do
        data = JSON.parse(request.body.read)

        begin
            skill = Skill.create(data)
            skill.to_json
        rescue => e
            { error: e.message }.to_json
        end
        
    end

    get '/skills' do 
        skills = Skill.all
        skills.to_json
    end

   

    # gets the sills of a certain user and limits them to max of 10
    get '/skills/:id' do
        user = User.find(self.user_id)
        skillSet = user.skills.first(2)
        skillSet.to_json
    end

    # adds a new skill for a specifies user
    post 'skill/create' do
        data = JSON.parse(request.body.read)

        begin
            skill = Skill.create(data)
            skill.to_json
        rescue => e
            { error: e.message }.to_json
        end
    end


    private

    def user_id
        params['id'].to_i
    end


end