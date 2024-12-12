# Cheatsheet para Buk/Webapp
Repositorio con scripts y comandos utiles, NO es una enciclopedia

## Links utiles (TODO)
- [Testing basico :wrench:](https://github.com/bukhr/buk-webapp/blob/7c0613ed33ab56646657b3775bd993c243a6899f/docs/test.md)


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

### Nukear la BDD

- ``` bin/rails db:drop:all ```
- ``` bin/rails db:create ```
- ``` bin/rails db:test:prepare ```
- ``` bin/rails db:setup ```
- ``` bin/restore-dump midump.dump buk_apartment ```
- ``` bin/rails db:migrate ```

### Correr sorbet para actualizar archivos y pasar los pipes

```
DISABLE_ACTIVE_ADMIN=0 bin/tapioca dsl --workers 1
```

### Puedes crear archivos .local que serán ignorados
- Esto es especialmente util para crear archivos .env.local (permite cambiar variables como el test runtime)


### Activar FF (por consola) 
Las FF siempre vendran apagadas en dumps por lo que hay que revisarlas (no así las generales)
En consola escribir: ``` Buk::Feature.enable :<feature> ```
Para checkear si está habilitada: ``` Buk::Feature.enabled? :<feature> ```
Finalmente: ```  Buk::Feature.clear___feature_cache_cache_per_request ```
y reload!

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
``` bin/rails 'tenant:create_all_base_tenants[20, true]' ```

### Prioridad en modelos

- after_initialize ↓ (1)
- before_validation ↓ (2)
- after_validation ↓ (3)
- before_save ↓ (4) 
- before_create ↓ (5)
- after_create ↓ (6)
- after_save ↓ (7)
- after_commit ↓ (8)
