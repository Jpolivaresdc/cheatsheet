# Cheatsheet para Buk/Webapp
Repositorio con scripts y comandos utiles, NO es una enciclopedia

# Comandos

## Iniciar Webpack
bin/webpack-dev-server 

## Iniciar postgres (si es que no está corriendo de antemano
sudo service postgresql start 

## Iniciar postgres y los jobs
sudo service postgresql start && bin/rails jobs:work

## Iniciar el servidor local matando otros procesos
pkill -9 -f puma ; spring stop ; bin/rails s 

## Si quiero correr los jobs permanentemente
bin/rails jobs:work  

## Si quiero que se ejecuten solo los jobs encolados
bin/rails jobs:workoff	

## Para pushear despues de un rebase (te permite forzar un push pero evitando pasar a llevar commits de otras personas)
git push --force-with-lease

## Para agregar linea por linea los cambios
git add -p <Ruta del archivo>

## Cambiar variables de año
FactoryBot.create(:variable, :updated_variable, start_date: Date.new(2024,1,1), estado: "abierto")

## Rehacer commit sin cambiar el mensaje
git commit --amend --no-edit

## Hacer rebase en la rama trayendo los cambios actuales de main
git pull origin master --rebase #cuidado si estas trabajando desde production

## Cargar un dump de datos
bin/restore-dump $archivo_dump buk_apartment

## Hacer un rebase
git rebase -i HEAD~3 #https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History

## Limpiar el queue de Jobs
rails jobs:clear


# Datos


## Puedes crear archivos .local que serán ignorados
- Esto es especialmente util para crear archivos .env.local (permite cambiar variables como el test runtime)


## Activar FF (por consola) 
Las FF siempre vendran apagadas en dumps por lo que hay que revisarlas (no así las generales)
En consola escribir: Buk::Feature.enable :<feature>
Para checkear si está habilitada: Buk::Feature.enabled? :<feature>
Finalmente: Buk::Feature.clear___feature_cache_cache_per_request
y reload!

## Para dejar operativo un usuario en ambientes de prueba que requieran acceso:
Dejar invitation token como nil.

## Para dejar todos los usuarios con contraseña password
TENANT={tenant} bin/rails users:change_passwords

## Mail que no han llegado
app > carpeta tmp > letter_opener

## Activar una General
General.find_or_initialize_by(nombre: :habilitar_tareas_pendientes).update!(valor: 'true')

## Cambiar tenant en scripts/consola
Apartment::Tenant.switch! :sibo #Ingresar nombre de tenant

## Testear en todos los países en una suite
CountrySti::Model::ACCEPTED_COUNTRIES.except(:brasil)

## Crear tenants default para cada país
bin/rails 'tenant:create_all_base_tenants[20, true]'
