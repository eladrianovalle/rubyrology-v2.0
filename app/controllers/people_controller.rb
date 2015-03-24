get '/people/:id' do
  @person = Person.find(params[:id])
  birthdate_string = @person.birthdate.strftime("%m%d%Y")
  birth_path_number = Person.get_birth_path_number(birthdate_string)
  @birthdate = @person.birthdate.strftime("%B %d, %Y")
  @message = Person.display_message(birth_path_number) 
  erb :"people/show"
end