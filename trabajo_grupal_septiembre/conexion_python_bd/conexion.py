import mysql.connector

# ---------- CONFIGURACIÓN DE CONEXIÓN ----------
# Diccionario con los parámetros necesarios para establecer la conexión con la BD.
DB_CONFIG = {
    "host": "localhost",      # Servidor donde corre MySQL (local en este caso)
    "user": "root",           # Usuario con permisos de acceso  
    "password": "Chupaelperro13", # Reemplaza con la contraseña real o déjalo vacío si no tiene
    "database": "edukit"      # Nombre de la base de datos a utilizar
    # "port": 3306,          # (Opcional) solo si tu MySQL usa un puerto distinto
}

# ---------- FUNCIÓN DE CONEXIÓN ----------
def conectar():
    """
    Crea y devuelve una conexión a MySQL usando los parámetros definidos en DB_CONFIG.
    Si la conexión falla, lanzará una excepción de tipo mysql.connector.Error.
    """
    return mysql.connector.connect(**DB_CONFIG)

# ---------- FUNCIONES PARA TABLA usuarios ----------
def sp_insertar_usuario(username: str, passwords: str, email: str, id_tipo_usuarios: int,
                       RUT: int, id_cargo: int, id_asignatura: int, id_instituciones: int, 
                       id_capacitaciones: int) -> bool:
    """
    Inserta un nuevo usuario llamando al procedimiento almacenado insertarUsuarios.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarUsuarios", [username, passwords, email, id_tipo_usuarios, 
                                         RUT, id_cargo, id_asignatura, id_instituciones, 
                                         id_capacitaciones])
        cnx.commit()
        print(f"✅ Usuario '{username}' insertado correctamente.")
        return True

    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_usuario:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_usuario(id_usuario: int):
    """
    Marca un usuario como eliminado lógicamente llamando a borradoLogicoUsuarios.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoUsuarios", [id_usuario])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al usuario ID {id_usuario}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_usuario:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_usuarios_activos():
    """
    Lista todos los usuarios activos llamando a usuariosActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("usuariosActivos")
        
        print("=== USUARIOS ACTIVOS ===")
        print(f"{'ID':<4} {'Username':<15} {'Email':<25} {'Tipo':<4} {'RUT':<10}")
        print("-" * 65)
        
        for result in cur.stored_results():
            for (id_, username, email, id_tipo, RUT, id_cargo, id_asignatura, 
                 id_instituciones, id_capacitaciones, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {username:<15} {email:<25} {id_tipo:<4} {RUT:<10}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_usuarios_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_todos_usuarios():
    """
    Lista todos los usuarios (activos e inactivos) llamando a todosUsuarios.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("todosUsuarios")
        
        print("=== TODOS LOS USUARIOS ===")
        print(f"{'ID':<4} {'Username':<15} {'Email':<25} {'Estado':<10} {'Tipo':<4}")
        print("-" * 65)
        
        for result in cur.stored_results():
            for row in result.fetchall():
                estado = "ACTIVO" if row[8] == 0 else "ELIMINADO"
                print(f"{row[0]:<4} {row[1]:<15} {row[3]:<25} {estado:<10} {row[9]:<4}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_todos_usuarios:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA historiales ----------
def sp_insertar_historial(promedio_mensual: int, fecha: str) -> bool:
    """
    Inserta un nuevo historial llamando a insertarHistoriales.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarHistoriales", [promedio_mensual, fecha])
        cnx.commit()
        print(f"✅ Historial con promedio {promedio_mensual} insertado correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_historial:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_historial(id_historial: int):
    """
    Marca un historial como eliminado lógicamente llamando a borradoLogicoHistoriales.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoHistoriales", [id_historial])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al historial ID {id_historial}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_historial:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_historiales_activos():
    """
    Lista todos los historiales activos llamando a historialesActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("historialesActivos")
        
        print("=== HISTORIALES ACTIVOS ===")
        print(f"{'ID':<4} {'Promedio':<10} {'Fecha':<12} {'Creado':<20}")
        print("-" * 50)
        
        for result in cur.stored_results():
            for (id_, promedio, fecha, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {promedio:<10} {fecha:<12} {created_at}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_historiales_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA personas ----------
def sp_insertar_persona(RUT: int, nombre: str, apellido: str, fecha_nac: str, 
                       direccion: str, id_historiales: int) -> bool:
    """
    Inserta una nueva persona llamando a insertarPersonas.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarPersonas", [RUT, nombre, apellido, fecha_nac, direccion, id_historiales])
        cnx.commit()
        print(f"✅ Persona {nombre} {apellido} insertada correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_persona:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_persona(RUT: int):
    """
    Marca una persona como eliminada lógicamente llamando a borradoLogicoPersonas.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoPersonas", [RUT])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado a la persona RUT {RUT}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_persona:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_personas_activas():
    """
    Lista todas las personas activas llamando a personasActivas.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("personasActivas")
        
        print("=== PERSONAS ACTIVAS ===")
        print(f"{'RUT':<10} {'Nombre':<15} {'Apellido':<15} {'Nacimiento':<12}")
        print("-" * 60)
        
        for result in cur.stored_results():
            for (RUT, nombre, apellido, fecha_nac, direccion, id_historiales, created_at, updated_at) in result.fetchall():
                print(f"{RUT:<10} {nombre:<15} {apellido:<15} {fecha_nac:<12}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_personas_activas:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA tipos_usuarios ----------
def sp_insertar_tipo_usuario(nombre_tipo: str, descripcion_tipo: str) -> bool:
    """
    Inserta un nuevo tipo de usuario llamando a insertarTipos_usuarios.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarTipos_usuarios", [nombre_tipo, descripcion_tipo])
        cnx.commit()
        print(f"✅ Tipo de usuario '{nombre_tipo}' insertado correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_tipo_usuario:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_tipo_usuario(id_tipo: int):
    """
    Marca un tipo de usuario como eliminado lógicamente llamando a borradoLogicoTipos_usuarios.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoTipos_usuarios", [id_tipo])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al tipo de usuario ID {id_tipo}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_tipo_usuario:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_tipos_usuarios_activos():
    """
    Lista todos los tipos de usuarios activos llamando a tipos_usuariosActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("tipos_usuariosActivos")
        
        print("=== TIPOS DE USUARIOS ACTIVOS ===")
        print(f"{'ID':<4} {'Tipo':<15} {'Descripción':<30}")
        print("-" * 55)
        
        for result in cur.stored_results():
            for (id_, nombre, descripcion, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<15} {descripcion:<30.30}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_tipos_usuarios_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA cargo ----------
def sp_insertar_cargo(nombre_cargo: str, descripcion_cargo: str) -> bool:
    """
    Inserta un nuevo cargo llamando a insertarCargo.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarCargo", [nombre_cargo, descripcion_cargo])
        cnx.commit()
        print(f"✅ Cargo '{nombre_cargo}' insertado correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_cargo:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_cargo(id_cargo: int):
    """
    Marca un cargo como eliminado lógicamente llamando a borradoLogicoCargo.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoCargo", [id_cargo])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al cargo ID {id_cargo}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_cargo:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_cargos_activos():
    """
    Lista todos los cargos activos llamando a cargoActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("cargoActivos")
        
        print("=== CARGOS ACTIVOS ===")
        print(f"{'ID':<4} {'Cargo':<15} {'Descripción':<20}")
        print("-" * 45)
        
        for result in cur.stored_results():
            for (id_, nombre, descripcion, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<15} {descripcion:<20}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_cargos_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA asignatura ----------
def sp_insertar_asignatura(nombre_asig: str, descripcion_asig: str) -> bool:
    """
    Inserta una nueva asignatura llamando a insertarAsignatura.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarAsignatura", [nombre_asig, descripcion_asig])
        cnx.commit()
        print(f"✅ Asignatura '{nombre_asig}' insertada correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_asignatura:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_asignatura(id_asignatura: int):
    """
    Marca una asignatura como eliminada lógicamente llamando a borradoLogicoAsignatura.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoAsignatura", [id_asignatura])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado a la asignatura ID {id_asignatura}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_asignatura:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_asignaturas_activas():
    """
    Lista todas las asignaturas activas llamando a asignaturaActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("asignaturaActivos")
        
        print("=== ASIGNATURAS ACTIVAS ===")
        print(f"{'ID':<4} {'Asignatura':<15} {'Descripción':<20}")
        print("-" * 45)
        
        for result in cur.stored_results():
            for (id_, nombre, descripcion, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<15} {descripcion:<20}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_asignaturas_activas:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA tipos_institucion ----------
def sp_insertar_tipo_institucion(nombre_tipo: str, descripcion_tipo: str) -> bool:
    """
    Inserta un nuevo tipo de institución llamando a insertarTipos_institucion.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarTipos_institucion", [nombre_tipo, descripcion_tipo])
        cnx.commit()
        print(f"✅ Tipo de institución '{nombre_tipo}' insertado correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_tipo_institucion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_tipo_institucion(id_tipo: int):
    """
    Marca un tipo de institución como eliminado lógicamente llamando a borradoLogicoTipos_institucion.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoTipos_institucion", [id_tipo])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al tipo de institución ID {id_tipo}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_tipo_institucion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_tipos_institucion_activos():
    """
    Lista todos los tipos de institución activos llamando a tipos_institucionActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("tipos_institucionActivos")
        
        print("=== TIPOS DE INSTITUCIÓN ACTIVOS ===")
        print(f"{'ID':<4} {'Tipo':<15} {'Descripción':<30}")
        print("-" * 55)
        
        for result in cur.stored_results():
            for (id_, nombre, descripcion, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<15} {descripcion:<30.30}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_tipos_institucion_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA instituciones ----------
def sp_insertar_institucion(nombre: str, direccion: str, email: str, id_tipos_institucion: int) -> bool:
    """
    Inserta una nueva institución llamando a insertarInstituciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarInstituciones", [nombre, direccion, email, id_tipos_institucion])
        cnx.commit()
        print(f"✅ Institución '{nombre}' insertada correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_institucion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_institucion(id_institucion: int):
    """
    Marca una institución como eliminada lógicamente llamando a borradoLogicoInstituciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoInstituciones", [id_institucion])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado a la institución ID {id_institucion}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_institucion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_instituciones_activas():
    """
    Lista todas las instituciones activas llamando a institucionesActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("institucionesActivos")
        
        print("=== INSTITUCIONES ACTIVAS ===")
        print(f"{'ID':<4} {'Nombre':<25} {'Email':<25} {'Tipo':<4}")
        print("-" * 65)
        
        for result in cur.stored_results():
            for (id_, nombre, direccion, email, id_tipo, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<25} {email:<25} {id_tipo:<4}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_instituciones_activas:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA tipo_capacitaciones ----------
def sp_insertar_tipo_capacitacion(nombre_tipo: str, descripcion_tipo: str) -> bool:
    """
    Inserta un nuevo tipo de capacitación llamando a insertarTipo_capacitaciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarTipo_capacitaciones", [nombre_tipo, descripcion_tipo])
        cnx.commit()
        print(f"✅ Tipo de capacitación '{nombre_tipo}' insertado correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_tipo_capacitacion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_tipo_capacitacion(id_tipo: int):
    """
    Marca un tipo de capacitación como eliminado lógicamente llamando a borradoLogicoTipo_capacitaciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoTipo_capacitaciones", [id_tipo])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado al tipo de capacitación ID {id_tipo}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_tipo_capacitacion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_tipos_capacitacion_activos():
    """
    Lista todos los tipos de capacitación activos llamando a tipo_capacitacionesActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("tipo_capacitacionesActivos")
        
        print("=== TIPOS DE CAPACITACIÓN ACTIVOS ===")
        print(f"{'ID':<4} {'Tipo':<15} {'Descripción':<20}")
        print("-" * 45)
        
        for result in cur.stored_results():
            for (id_, nombre, descripcion, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<15} {descripcion:<20}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_tipos_capacitacion_activos:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------- FUNCIONES PARA TABLA capacitaciones ----------
def sp_insertar_capacitacion(nombre: str, duracion_horas: str, id_tipo_capacitaciones: int) -> bool:
    """
    Inserta una nueva capacitación llamando a insertarCapacitaciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("insertarCapacitaciones", [nombre, duracion_horas, id_tipo_capacitaciones])
        cnx.commit()
        print(f"✅ Capacitación '{nombre}' insertada correctamente.")
        return True
    except mysql.connector.Error as e:
        print("❌ Error en sp_insertar_capacitacion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return False
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_borrado_logico_capacitacion(id_capacitacion: int):
    """
    Marca una capacitación como eliminada lógicamente llamando a borradoLogicoCapacitaciones.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("borradoLogicoCapacitaciones", [id_capacitacion])
        cnx.commit()
        print(f"✅ Borrado lógico aplicado a la capacitación ID {id_capacitacion}.")
    except mysql.connector.Error as e:
        print("❌ Error en sp_borrado_logico_capacitacion:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

def sp_listar_capacitaciones_activas():
    """
    Lista todas las capacitaciones activas llamando a capacitacionesActivos.
    """
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("capacitacionesActivos")
        
        print("=== CAPACITACIONES ACTIVAS ===")
        print(f"{'ID':<4} {'Nombre':<20} {'Duración':<15} {'Tipo':<4}")
        print("-" * 50)
        
        for result in cur.stored_results():
            for (id_, nombre, duracion, id_tipo, created_at, updated_at) in result.fetchall():
                print(f"{id_:<4} {nombre:<20} {duracion:<15} {id_tipo:<4}")

    except mysql.connector.Error as e:
        print("❌ Error en sp_listar_capacitaciones_activas:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------------- MENÚ PRINCIPAL ----------------
def menu():
    """
    Muestra un menú interactivo en consola que permite al usuario ejecutar
    las distintas operaciones CRUD a través de los procedimientos almacenados.
    """
    while True:
        # Muestra opciones disponibles
        print("\n" + "="*50)
        print("          SISTEMA EDUKIT - MENÚ PRINCIPAL")
        print("="*50)
        
        print("\n=== GESTIÓN DE USUARIOS ===")
        print("1) Insertar usuario")
        print("2) Listar usuarios ACTIVOS") 
        print("3) Listar usuarios (TODOS)")
        print("4) Borrado lógico de usuario")
        
        print("\n=== GESTIÓN DE PERSONAS ===")
        print("5) Insertar persona")
        print("6) Listar personas ACTIVAS")
        print("7) Borrado lógico de persona")
        
        print("\n=== GESTIÓN DE HISTORIALES ===")
        print("8) Insertar historial")
        print("9) Listar historiales ACTIVOS")
        print("10) Borrado lógico de historial")
        
        print("\n=== GESTIÓN DE TIPOS DE USUARIO ===")
        print("11) Insertar tipo de usuario")
        print("12) Listar tipos de usuario ACTIVOS")
        print("13) Borrado lógico de tipo de usuario")
        
        print("\n=== GESTIÓN DE CARGOS ===")
        print("14) Insertar cargo")
        print("15) Listar cargos ACTIVOS")
        print("16) Borrado lógico de cargo")
        
        print("\n=== GESTIÓN DE ASIGNATURAS ===")
        print("17) Insertar asignatura")
        print("18) Listar asignaturas ACTIVAS")
        print("19) Borrado lógico de asignatura")
        
        print("\n=== GESTIÓN DE INSTITUCIONES ===")
        print("20) Insertar institución")
        print("21) Listar instituciones ACTIVAS")
        print("22) Borrado lógico de institución")
        
        print("\n=== GESTIÓN DE TIPOS DE INSTITUCIÓN ===")
        print("23) Insertar tipo de institución")
        print("24) Listar tipos de institución ACTIVOS")
        print("25) Borrado lógico de tipo de institución")
        
        print("\n=== GESTIÓN DE CAPACITACIONES ===")
        print("26) Insertar capacitación")
        print("27) Listar capacitaciones ACTIVAS")
        print("28) Borrado lógico de capacitación")
        
        print("\n=== GESTIÓN DE TIPOS DE CAPACITACIÓN ===")
        print("29) Insertar tipo de capacitación")
        print("30) Listar tipos de capacitación ACTIVOS")
        print("31) Borrado lógico de tipo de capacitación")
        
        print("\n0) Salir")

        # Solicita la opción al usuario
        opcion = input("\nSelecciona una opción: ").strip()
        
        # --- Gestión de Usuarios ---
        if opcion == "1":
            print("\n--- INSERTAR NUEVO USUARIO ---")
            try:
                username = input("Username: ").strip()
                passwords = input("Password: ").strip()
                email = input("Email: ").strip()
                id_tipo = int(input("ID Tipo Usuario: ").strip())
                RUT = int(input("RUT: ").strip())
                id_cargo = int(input("ID Cargo: ").strip())
                id_asignatura = int(input("ID Asignatura: ").strip())
                id_instituciones = int(input("ID Institución: ").strip())
                id_capacitaciones = int(input("ID Capacitación: ").strip())
                
                sp_insertar_usuario(username, passwords, email, id_tipo, RUT, id_cargo, 
                                   id_asignatura, id_instituciones, id_capacitaciones)
            except ValueError:
                print("❌ Error: Todos los IDs deben ser números enteros.")
        
        elif opcion == "2":
            sp_listar_usuarios_activos()
        
        elif opcion == "3":
            sp_listar_todos_usuarios()
        
        elif opcion == "4":
            try:
                id_user = int(input("ID de usuario a eliminar lógicamente: ").strip())
                sp_borrado_logico_usuario(id_user)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Personas ---
        elif opcion == "5":
            print("\n--- INSERTAR NUEVA PERSONA ---")
            try:
                RUT = int(input("RUT: ").strip())
                nombre = input("Nombre: ").strip()
                apellido = input("Apellido: ").strip()
                fecha_nac = input("Fecha nacimiento (YYYY-MM-DD): ").strip()
                direccion = input("Dirección: ").strip()
                id_historiales = int(input("ID Historial: ").strip())
                
                sp_insertar_persona(RUT, nombre, apellido, fecha_nac, direccion, id_historiales)
            except ValueError:
                print("❌ Error: RUT e ID Historial deben ser números enteros.")
        
        elif opcion == "6":
            sp_listar_personas_activas()
        
        elif opcion == "7":
            try:
                RUT = int(input("RUT de la persona a eliminar lógicamente: ").strip())
                sp_borrado_logico_persona(RUT)
            except ValueError:
                print("❌ RUT inválido.")
        
        # --- Gestión de Historiales ---
        elif opcion == "8":
            print("\n--- INSERTAR NUEVO HISTORIAL ---")
            try:
                promedio = int(input("Promedio mensual (1-100): ").strip())
                fecha = input("Fecha (YYYY-MM-DD): ").strip()
                sp_insertar_historial(promedio, fecha)
            except ValueError:
                print("❌ Error: El promedio debe ser un número entero.")
        
        elif opcion == "9":
            sp_listar_historiales_activos()
        
        elif opcion == "10":
            try:
                id_hist = int(input("ID de historial a eliminar lógicamente: ").strip())
                sp_borrado_logico_historial(id_hist)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Tipos de Usuario ---
        elif opcion == "11":
            print("\n--- INSERTAR NUEVO TIPO DE USUARIO ---")
            nombre = input("Nombre del tipo: ").strip()
            descripcion = input("Descripción: ").strip()
            sp_insertar_tipo_usuario(nombre, descripcion)
        
        elif opcion == "12":
            sp_listar_tipos_usuarios_activos()
        
        elif opcion == "13":
            try:
                id_tipo = int(input("ID de tipo de usuario a eliminar lógicamente: ").strip())
                sp_borrado_logico_tipo_usuario(id_tipo)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Cargos ---
        elif opcion == "14":
            print("\n--- INSERTAR NUEVO CARGO ---")
            nombre = input("Nombre del cargo: ").strip()
            descripcion = input("Descripción: ").strip()
            sp_insertar_cargo(nombre, descripcion)
        
        elif opcion == "15":
            sp_listar_cargos_activos()
        
        elif opcion == "16":
            try:
                id_cargo = int(input("ID de cargo a eliminar lógicamente: ").strip())
                sp_borrado_logico_cargo(id_cargo)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Asignaturas ---
        elif opcion == "17":
            print("\n--- INSERTAR NUEVA ASIGNATURA ---")
            nombre = input("Nombre de la asignatura: ").strip()
            descripcion = input("Descripción: ").strip()
            sp_insertar_asignatura(nombre, descripcion)
        
        elif opcion == "18":
            sp_listar_asignaturas_activas()
        
        elif opcion == "19":
            try:
                id_asig = int(input("ID de asignatura a eliminar lógicamente: ").strip())
                sp_borrado_logico_asignatura(id_asig)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Instituciones ---
        elif opcion == "20":
            print("\n--- INSERTAR NUEVA INSTITUCIÓN ---")
            try:
                nombre = input("Nombre: ").strip()
                direccion = input("Dirección: ").strip()
                email = input("Email: ").strip()
                id_tipo = int(input("ID Tipo Institución: ").strip())
                sp_insertar_institucion(nombre, direccion, email, id_tipo)
            except ValueError:
                print("❌ Error: ID Tipo Institución debe ser un número entero.")
        
        elif opcion == "21":
            sp_listar_instituciones_activas()
        
        elif opcion == "22":
            try:
                id_inst = int(input("ID de institución a eliminar lógicamente: ").strip())
                sp_borrado_logico_institucion(id_inst)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Tipos de Institución ---
        elif opcion == "23":
            print("\n--- INSERTAR NUEVO TIPO DE INSTITUCIÓN ---")
            nombre = input("Nombre del tipo: ").strip()
            descripcion = input("Descripción: ").strip()
            sp_insertar_tipo_institucion(nombre, descripcion)
        
        elif opcion == "24":
            sp_listar_tipos_institucion_activos()
        
        elif opcion == "25":
            try:
                id_tipo = int(input("ID de tipo de institución a eliminar lógicamente: ").strip())
                sp_borrado_logico_tipo_institucion(id_tipo)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Capacitaciones ---
        elif opcion == "26":
            print("\n--- INSERTAR NUEVA CAPACITACIÓN ---")
            try:
                nombre = input("Nombre: ").strip()
                duracion = input("Duración (ej: '16 horas'): ").strip()
                id_tipo = int(input("ID Tipo Capacitación: ").strip())
                sp_insertar_capacitacion(nombre, duracion, id_tipo)
            except ValueError:
                print("❌ Error: ID Tipo Capacitación debe ser un número entero.")
        
        elif opcion == "27":
            sp_listar_capacitaciones_activas()
        
        elif opcion == "28":
            try:
                id_cap = int(input("ID de capacitación a eliminar lógicamente: ").strip())
                sp_borrado_logico_capacitacion(id_cap)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Gestión de Tipos de Capacitación ---
        elif opcion == "29":
            print("\n--- INSERTAR NUEVO TIPO DE CAPACITACIÓN ---")
            nombre = input("Nombre del tipo: ").strip()
            descripcion = input("Descripción: ").strip()
            sp_insertar_tipo_capacitacion(nombre, descripcion)
        
        elif opcion == "30":
            sp_listar_tipos_capacitacion_activos()
        
        elif opcion == "31":
            try:
                id_tipo = int(input("ID de tipo de capacitación a eliminar lógicamente: ").strip())
                sp_borrado_logico_tipo_capacitacion(id_tipo)
            except ValueError:
                print("❌ ID inválido.")
        
        # --- Salir ---
        elif opcion == "0":
            print("👋 Saliendo del sistema Edukit...")
            break
        
        # --- Opción no válida ---
        else:
            print("❌ Opción no válida. Intenta nuevamente.")

# Punto de entrada del programa
if __name__ == "__main__":
    menu()