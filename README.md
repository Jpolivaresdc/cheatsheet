# Cheatsheet para Buk/Webapp
Repositorio con scripts y comandos utiles, NO es una enciclopedia

## Links utiles (TODO)
- [Testing basico :wrench:](https://github.com/bukhr/buk-webapp/blob/7c0613ed33ab56646657b3775bd993c243a6899f/docs/test.md)
- [PR's que tocan vacaciones](https://github.com/bukhr/buk-webapp/pulls?q=is%3Aopen+team-review-requested%3Abukhr%2Fcore-vacaciones+-author%3Abermuditas)

## Lectures Utiles

- [Carga cognitiva](https://minds.md/zakirullin/cognitive)

## Comandos

### Iniciar el ambiente :boot:

Iniciar webpack
``` 
bin/webpack-dev-server
``` 

Iniciar postgres (si es que no está corriendo de antemano)
``` 
sudo service postgresql start
``` 

Iniciar postgres y despues jobs (&& corre al terminar el primer comando)
``` 
sudo service postgresql start && bin/rails jobs:work
``` 

Iniciar el servidor local matando otros procesos:
``` 
pkill -9 -f puma ; spring stop ; bin/rails s
``` 

Iniciar con Active_Admin (por default se desactiva ya que consume recursos y no es practico)
``` 
DISABLE_ACTIVE_ADMIN=0 bin/rails s
``` 

Si quiero que se ejecuten solo los jobs encolados:
``` 
bin/rails jobs:workoff
``` 

### Para pushear despues de un rebase (te permite forzar un push pero evitando pasar a llevar commits de otras personas)
``` 
git push --force-with-lease
```

### Para agregar linea por linea los cambios
``` 
git add -p "Ruta del archivo"
```

### Cambiar variables de año
``` 
FactoryBot.create(:variable, :updated_variable, start_date: Date.new(2024,1,1), estado: "abierto")
```

### Rehacer commit sin cambiar el mensaje
``` 
git commit --amend --no-edit
```

### Hacer rebase en la rama trayendo los cambios actuales de main
``` 
git pull origin master --rebase # cuidado si estas trabajando desde production
```

### Cargar un dump de datos
``` 
bin/restore-dump $archivo_dump buk_apartment
```

### Hacer un rebase
``` 
git rebase -i HEAD~3 #https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
```

### Limpiar el queue de Jobs
``` 
rails jobs:clear
```

### Agregar Flaky
``` 
bin/rails "flaky_test:add_test[<relative_path>]"
```

### Nukear la BDD

- ```
  bin/rails db:drop:all
  ```
- ```
  bin/rails db:create
  ```
- ```
  bin/rails db:test:prepare
  ```
- ```
  bin/rails db:setup
  ```
- ```
  bin/restore-dump midump.dump buk_apartment
  ```
- ```
  bin/rails db:migrate
  ```
### Auto-login

Con el mail de un usuario y con un tenant en especifico:

```
http://localhost:3000/?tenant=<tenant>&auto_login=<user_email>
```

### Correr sorbet para actualizar archivos y pasar los pipes

```
DISABLE_ACTIVE_ADMIN=0 bin/tapioca dsl --workers 1
```

actualiza los rbi segun los cambios commiteados respecto a master
```
bin/update-changed-rbi committed
```

 actualiza los rbi segun los cambios que no han sido commiteados.
```
bin/update-changed-rbi uncommitted
```

actualiza segun todos los cambios.
```
bin/update-changed-rbi all
```

### Puedes crear archivos .local que serán ignorados
- Esto es especialmente util para crear archivos .env.local (permite cambiar variables como el test runtime)


### Activar FF (por consola) 
Las FF siempre vendran apagadas en dumps por lo que hay que revisarlas (no así las generales)

En consola escribir:
``` Buk::Feature.enable :<feature> ```

Para checkear si está habilitada: 

``` Buk::Feature.enabled? :<feature> ```

Finalmente: 
```  Buk::Feature.clear___feature_cache_cache_per_request ```

y 

``` 
reload!
``` 
### Para dejar operativo un usuario en ambientes de prueba que requieran acceso:
Dejar invitation token como nil.

### Para dejar todos los usuarios con contraseña password
``` 
TENANT={tenant} bin/rails users:change_passwords
```

### Mail que no han llegado
app > carpeta tmp > letter_opener

### Activar una General
``` 
General.find_or_initialize_by(nombre: :habilitar_tareas_pendientes).update!(valor: 'true')
```

### Cambiar tenant en scripts/consola
``` 
Apartment::Tenant.switch! :sibo #Ingresar nombre de tenant
```

### Testear en todos los países en una suite
Incluir en los tests
``` CountrySti::Model::ACCEPTED_COUNTRIES.except(:brasil) ```

### Crear tenants default para cada país
```
bin/rails 'tenant:create_all_base_tenants[20, true]'
```

### Ejecutar todo dentro de una transaction
```
ActiveRecord::Base.transaction do
  usuario = Usuario.create!(nombre: "Juan")
  pedido = Pedido.create!(usuario: usuario, total: 100.0)
end
```

### Ejemplo de como surfear en grafana una consulta de jobs

```
https://grafana.infra.buk.cl/explore?orgId=1&left=%7B%22datasource%22:%22logschile%22,%22queries%22:%5B%7B%22refId%22:%22A%22,%22editorMode%22:%22code%22,%22expr%22:%22%7Bnamespace%3D%5C%22enterprise-chile%5C%22%7D%20%7C%3D%20%5C%22delayed_jobs%5C%22%20%7C%3D%20%5C%22INSERT%5C%22%20%7C%3D%20%5C%22PendingTasks::MarkVacacionesPorVencerPendingTasksAsCompletedJob%5C%22%22,%22queryType%22:%22range%22%7D%5D,%22range%22:%7B%22from%22:%22now-5m%22,%22to%22:%22now%22%7D%7D
```

### Prioridad en modelos

- after_initialize ↓ (1)
- before_validation ↓ (2)
- after_validation ↓ (3)
- before_save ↓ (4) 
- before_create ↓ (5)
- after_create ↓ (6)
- after_save ↓ (7)
- after_commit ↓ (8)
