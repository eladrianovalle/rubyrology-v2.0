# my code

get '/people' do
  @people = Person.all
  erb :"/people/index"
end

get '/people/new' do
  @person = Person.new
  erb :"/people/new"
end

post '/people' do
  if params[:birthdate].include?("-")
    birthdate = params[:birthdate]
  elsif (params[:birthdate].length == 8 && !params[:birthdate].match(/^[0-9]+[0-9]$/).nil?)
    birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
  else
    birthdate = params[:birthdate]
  end

  @person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}."
    end
    erb :"/people/new"
  end
end

get '/people/:id/edit' do
  @person = Person.find(params[:id])
  erb :"/people/edit"
end

put '/people/:id' do
  # get the record and update the first_name and last_name here...
  @person = Person.find(params[:id])
  @person.first_name = params[:first_name]
  @person.last_name = params[:last_name]
  @person.birthdate = params[:birthdate]
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}"
    end
    erb :"/people/edit"
  end
end

delete '/people/:id' do
  person = Person.find(params[:id])
  person.delete
  redirect "/people"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birth_path_num = Person.get_birth_path_num(@person.birthdate.strftime("%m%d%Y"))
  @birthdate = @person.birthdate.strftime("%B %d, %Y")
  @message = Person.get_message(birth_path_num) 
  erb :"people/show"
end

#solution code

# get '/people' do
#   @people = Person.all
#   erb :"/people/index"
# end

# get '/people/new' do
#   @person = Person.new
#   erb :"/people/new"
# end

# post '/people' do
#   if params[:birthdate].include?("-")
#     birthdate = params[:birthdate]
#   else
#     birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
#   end
  
#   person = Person.create(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
#   redirect "/people/#{person.id}"
# end

# get '/people/:id/edit' do
#   @person = Person.find(params[:id])
#   erb :"/people/edit"
# end

# put '/people/:id' do
#   person = Person.find(params[:id])
#   person.first_name = params[:first_name]
#   person.last_name = params[:last_name]
#   person.birthdate = params[:birthdate]
#   person.save
#   redirect "/people/#{person.id}"
# end

# delete '/people/:id' do
#   person = Person.find(params[:id])
#   person.delete
#   redirect "/people"
# end

# get '/people/:id' do
#   @person = Person.find(params[:id])
#   birth_path_num = Person.get_birth_path_num(@person.birthdate.strftime("%m%d%Y"))
#   @message = Person.get_message(birth_path_num)  
#   erb :"/people/show"
# end


