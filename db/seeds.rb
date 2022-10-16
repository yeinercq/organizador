['yeiner', 'andrea', 'leon', 'andres', 'natalia', 'camilo', 'rusbel', 'johan'].each do |name|
  User.create email: "#{name}@mail.com", password: '123456'
end
puts 'Users has been created'

['desarrollo', 'mercadeo', 'conceptualización', 'ejercicios'].each do |name|
  Category.create name: name, description: 'Description text'
end
puts 'Categories has been created'

owner = User.find_by(email: 'yeiner@mail.com')
[
  ['conceptualización', 'Bienvenida ', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', '¿Qué es ruby on rails y por qué usarlo?', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Entorno de desarrollo de RoR', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['ejercicios', 'Instalación de Ruby, RoR en windows y Linux', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Entender la web con rieles', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['ejercicios', 'Crear una nueva aplicación RoR ¡Hola Rails!', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['ejercicios', 'Manipular el patrón MVC', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', '¿Qué vamos a desarrollar?', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Crear la base de nuestra aplicación', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Los secretos de rails', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Assets y Layouts', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Diseñar el modelo de datos', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Agregar primer conjunto de scaffolds', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Cómo entender las migraciones', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Esteroides para tu desarrollo - HAML', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Esteroides para tu desarrollo - Simple Form', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Regenerando el primer conjunto de scaffolds', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Internacionalización de tu aplicación', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Esteroides para tu desarrollo - Debugging', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Agregar validaciones de modelo', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Añadiendo el concepto de usuario', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Añadir participantes a la tarea', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'CanCanCan ¿puedes hacerlo?', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Callbacks en Rails', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Enviar email a los participantes', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Añadir comentarios vía AJAX', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['desarrollo', 'Embellecer nuestra aplicación', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Desplegando a Heroku', ['yeiner:1', 'leon:2', 'andrea:random']],
  ['conceptualización', 'Conclusiones del curso', ['yeiner:1', 'leon:2', 'andrea:random']],
].each do |category, description, participant_set|
  participants = participant_set.map do |participant|
    user_name, raw_role = participant.split(':')
    role = raw_role == 'random' ? [1, 2].sample : raw_role
    Participant.new(
      user: User.find_by(email: "#{user_name}@mail.com"),
      role: role.to_i
    )
  end

  Task.create!(
    category: Category.find_by(name: category),
    name: "Tarea ##{Task.count + 1}",
    description: description,
    due_date: Date.today + 15.days,
    owner: owner,
    participating_users: participants
  )
end
puts 'Tasks has been created'
