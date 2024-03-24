## Inicialización

***Flutter versión: 3.19.2***

- Sentry: darien.r.leiva@gmail.com

#### Pase a producción

- Actualizar en pubspec.yaml la versión del versionCode y versionName
- Actualizar en constants.dart el patchVersion a 0
- Crear el commit y subir a development
- Navegar a master y hacer un merge de development. Subir.
- Crear el tag de acuerdo a la versión actual. Ejem: v1.0.3+6
- En caso de compilado manual ejecutar el comando:
```
    shorebird release android --flavor production -t lib/main_production.dart
```
- A continuación usar el archivo .aab y subirlo al canal de producción de PlayStore
- En caso de compilado en la nube (Codemagic). Seleccionar la rama master, el workflow Release Android e iniciar el compilado.
- En firestore->configuration->android, actualizar version_number, version_string y ota_update de acuerdo a la configuración anterior.
- Regresar a la rama development

#### Publicación de parche

- Actualizar en constants.dart el patchVersion a 1 (Si anteriormente era 0)
- Crear el commit y subir a development
- Navegar a master y hacer un merge de development. Subir.
- Crear el tag de acuerdo a la versión actual. Ejem: v1.0.3+6-patch1
- En caso de compilado manual ejecutar el comando:
```
    shorebird patch android --flavor production -t lib/main_production.dart
```
- En caso de compilado en la nube (Codemagic). Seleccionar la rama master, el workflow Patch Android e iniciar el compilado.
- En ambos casos la publicación del parche se hace en automático luego de compilado.
- En firestore->configuration->android, actualizar ota_update de acuerdo a la configuración anterior. Ejemplo 3.1, 3.2, 3.3, etc.
- Regresar a la rama development
