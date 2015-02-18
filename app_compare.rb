#SQUADS
#------------------------------------------------
#POST, PUT, AND DESTROY ROUTES
#------------------------------------------------
post '/squads' do
  Squad.create params
  redirect '/squads'
end
#------------------------------------------------
put '/squads/:id' do
  s = Squad.find(params[:id].to_i)
  s.name = params[:name]
  s.mascot = params[:mascot]
  s.save
  redirect '/squads'
end
#------------------------------------------------
delete '/squads/:id' do
  Squad.find(params[:id].to_i).destroy
  redirect '/squads'
end
#STUDENTS
#------------------------------------------------
#POST, PUT, and DESTROY ROUTES
#------------------------------------------------
post '/squads/:squad_id/students' do
  @conn.exec('INSERT INTO students (name, age, spirit_animal, squad_id) values ($1,$2,$3,$4)', [ params[:name]  ,params[:age],params[:spirit], params[:squad_id]])
  redirect "/squads/#{params[:squad_id].to_i}"
end
#------------------------------------------------
put '/squads/:squad_id/students/:student_id' do
  id = params[:student_id].to_i
  @conn.exec('UPDATE students SET name=$1, age=$2, spirit_animal=$3 WHERE id = $4', [ params[:name], params[:age], params[:spirit], id ] )
  redirect "/squads/#{params[:squad_id].to_i}"
end
#------------------------------------------------
delete '/squads/:squad_id/students/:student_id' do
  id = params[:student_id].to_i
  @conn.exec('DELETE FROM students WHERE id = ($1)', [ id ] )
  redirect "/squads/#{params[:squad_id].to_i}"
end