get '/:birthdate' do 
    setup_index_view
end

get '/message/:birth_path_number' do
    birth_path_number = params[:birth_path_number].to_i
    @message = Person.display_message(birth_path_number)
    erb :index
end

get '/' do
    erb :form
end

post '/' do
    birthdate = params[:birthdate].gsub("-","")
    if Person.valid_birthdate(birthdate)
        birth_path_number = Person.get_birth_path_number(birthdate)
        redirect "/message/#{birth_path_number}"
    else
        @error = "Oops! You should enter a valid birthdate in the form of mmddyyyy. Try again!"
        erb :form
    end
end

def setup_index_view
    birthdate = params[:birthdate]
    birth_path_number = Person.get_birth_path_number(birthdate)
    @message = Person.display_message(birth_path_number) 
    erb :index
end