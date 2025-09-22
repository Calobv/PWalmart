<%
    // Bloque de seguridad para administración
    String rol = (String) session.getAttribute("rol");
    if (rol == null || !rol.equals("admin")) {
        // No está logueado o no es admin -> redirige al index
        response.sendRedirect("index.jsp");
        return;
    }
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Producto - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
        <a href="homeadmin.jsp">Inicio Admin</a>
        <a href="adminusuarios.jsp">Usuarios</a>
        <a href="adminpromos.jsp">Promociones</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>
    
    <h1>Crear Nuevo Producto</h1>
    
    <form method="post" enctype="multipart/form-data" class="formulario">
        <label for="codigo">Código:</label>
        <input type="number" id="codigo" name="codigo" required><br><br>
        
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>
        
        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" required rows="3"></textarea><br><br>
        
        <label for="imagen">Imagen (URL):</label>
        <input type="url" id="imagen" name="imagen" placeholder="https://ejemplo.com/imagen.jpg"><br><br>
        
        <label for="precio">Precio (L.):</label>
        <input type="number" id="precio" name="precio" step="0.01" min="0" required><br><br>
        
        <label for="isv">ISV (%):</label>
        <input type="number" id="isv" name="isv" step="0.01" min="0" max="100" required 
               placeholder="Ej: 15 para 15%"><br><br>
        
        <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>
        <button type="submit" class="btn-guardar">Guardar Producto</button>
    </form>

    <%
        // Procesar el formulario cuando se envía
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String imagen = request.getParameter("imagen");
        String precioStr = request.getParameter("precio");
        String isvStr = request.getParameter("isv");

        if (codigo != null && nombre != null && descripcion != null && precioStr != null && isvStr != null) {
            String mensaje = "";
            
            try {
                // Validaciones
                if (!codigo.matches("\\d+")) {
                    mensaje = "El código debe contener solo números.";
                } else if (nombre.trim().isEmpty()) {
                    mensaje = "El nombre es requerido.";
                } else if (descripcion.trim().isEmpty()) {
                    mensaje = "La descripción es requerida.";
                } else {
                    double precio = Double.parseDouble(precioStr);
                    double isv = Double.parseDouble(isvStr);
                    
                    if (precio < 0) {
                        mensaje = "El precio debe ser mayor o igual a 0.";
                    } else if (isv < 0 || isv > 100) {
                        mensaje = "El ISV debe estar entre 0 y 100.";
                    } else {
                        // Insertar en la base de datos
                        Dba db = new Dba(application.getRealPath("/") + "daw.mdb");
                        db.conectar();
                        
                        // Verificar si el código ya existe
                        db.query.execute("SELECT Codigo FROM Productos WHERE Codigo='" + codigo + "'");
                        ResultSet rs = db.query.getResultSet();
                        
                        if (rs.next()) {
                            mensaje = "Ya existe un producto con ese código.";
                        } else {
                            // Si no hay imagen, usar una por defecto
                            if (imagen == null || imagen.trim().isEmpty()) {
                                imagen = "https://via.placeholder.com/200x200?text=Sin+Imagen";
                            }
                            
                            // Insertar producto
                            String sql = "INSERT INTO Productos (Codigo, Nombre, Descripcion, Imagen, Precio, ISV, EnCarrito) " +
                                        "VALUES ('" + codigo + "', '" + nombre + "', '" + descripcion + "', '" + 
                                        imagen + "', " + precio + ", " + isv + ", 0)";
                            
                            db.executeUpdate(sql);
                            db.commit();
                            mensaje = "Producto creado correctamente.";
                        }
                        
                        rs.close();
                        db.desconectar();
                    }
                }
            } catch (NumberFormatException e) {
                mensaje = "Error en los valores numéricos. Verifique precio e ISV.";
            } catch (Exception e) {
                mensaje = "Error al crear producto: " + e.getMessage();
                e.printStackTrace();
            }
            
            // Mostrar mensaje
            String color = mensaje.contains("correctamente") ? "green" : "red";
    %>
            <p style="color:<%= color %>; text-align:center; font-weight:bold;"><%= mensaje %></p>
    <%
        }
    %>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | Panel de administración</p>
    </div>
</body>
</html>