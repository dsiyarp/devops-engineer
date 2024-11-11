# Desafío 7: Creación de Cuenta + Gestión de Usuarios y Roles en AWS 🚀

## 🎯 Objetivo

En este ejercicio vamos a meter mano en **AWS IAM**, el servicio de gestión de identidades y accesos. El objetivo es que aprendas a crear usuarios y roles de forma segura, para que puedas administrar recursos en AWS sin problemas. 

### ¿Qué vamos a hacer?

- Crear una cuenta de AWS.
- Acceder a la consola de AWS.
- Crear un grupo con rol de **Administrador**.
- Crear usuarios con diferentes roles: **Administrador** y **Billing**.

---

## 🛠️ Tareas

### 1. Crear una Cuenta de AWS

1. Andá a [aws.amazon.com](https://aws.amazon.com) y hacé clic en "Create an AWS Account".
2. Completá el registro, incluyendo los datos de pago (AWS tiene una capa gratuita por un año para muchos servicios).
3. ¡Listo! Ahora te van a mandar un correo de verificación. Seguí las instrucciones para verificar tu cuenta.

### 2. Acceder a la Consola de AWS

1. Una vez verificada la cuenta, accedé a la consola en [aws.amazon.com/console](https://aws.amazon.com/console).
2. Iniciá sesión con las credenciales de tu cuenta raíz (**root user**). Ojo con esto, evitá usar esta cuenta para tareas diarias por temas de seguridad.

### 3. Crear un Grupo con Rol de Administrador

1. Desde la consola, buscá **IAM (Identity and Access Management)**.
2. Seleccioná "User groups" y hacé clic en "Create New Group".
3. Dale un nombre al grupo, por ejemplo: `AdminGroup`.
4. En la sección de permisos, elegí la política **AdministratorAccess**.
5. Completá el proceso de creación del grupo.

### 4. Crear un Usuario con Rol de Administrador

1. En IAM, seleccioná "Users" y hacé clic en "Add user".
2. Ingresá el nombre del usuario, por ejemplo: `AdminUser`.
3. Seleccioná **"Programmatic access"** y **"AWS Management Console access"**.
4. Configurá una contraseña para el usuario.
5. Asignalo al grupo `AdminGroup`.
6. Creá el usuario y **anotá las credenciales** para no perderlas.

### 5. Crear un Usuario con Rol de Billing

1. Volvé a "Users" y hacé clic en "Add user".
2. Poné el nombre `BillingUser` y seleccioná **"AWS Management Console access"**.
3. Configurá la contraseña para el usuario.
4. En "Set permissions", seleccioná **"Attach policies directly"**.
5. Buscá y elegí la política **Billing**.
6. Creá el usuario y **anotá las credenciales**.

### 6. Habilitar Acceso de Billing para el Usuario BillingUser

1. Andá a "My Account" > "Account settings".
2. Seleccioná "Edit" en **IAM User and Role Access to Billing Information**.
3. Habilitá el acceso marcando la casilla correspondiente.
4. Guardá los cambios.

---

## 📌 Notas

- **Seguridad ante todo**: Usá las credenciales de la cuenta raíz solo para configuraciones críticas.
- **Práctica real**: Este ejercicio te prepara para trabajar con cuentas reales y gestionar accesos de manera segura.
- Si te quedaste con dudas, revisá la [documentación oficial de AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).

---

## 💬 Feedback

Si encontrás errores o querés sugerir mejoras, no dudes en abrir un issue. ¡Estamos para aprender y mejorar juntos!

---

**Hecho con 💻 y ☕ desde Argentina**
