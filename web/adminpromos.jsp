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
    <title>Administrar Promo Codes - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png" 
             alt="Walmart Logo" class="logo">
        <br>
        <a href="homeadmin.jsp">Inicio Admin</a>
        <a href="adminproductos.jsp">Productos</a>
        <a href="adminusuarios.jsp">Usuarios</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>
    
    <!-- Crear Promo Code -->
    <div class="contenedor">
        <h2 class="titulo">Crear Promo Code</h2>
        
        <form method="post" class="formulario">
            <label>Código:</label><br>
            <input type="number" name="codigo" required><br><br>
            
            <label>Tipo:</label><br>
            <input type="radio" name="tipo" value="porcentaje" required> Porcentaje 
            <input type="radio" name="tipo" value="montoFijo" required> Monto fijo<br><br>
            
            <label>Descuento:</label><br>
            <input type="number" name="descuento" step="0.01" min="0" required 
                   placeholder="Ej: 15 (para 15% o L.15)"><br><br>
            
            <label>Restricción (número de usos, 0 = ilimitado):</label><br>
            <input type="number" name="restriccion" min="0" value="0" required><br><br>
            
            <label>Activo:</label><br>
            <input type="checkbox" name="activo" checked> Sí<br><br>
            
            <button type="submit" class="btn-guardar">Guardar Promo Code</button>
            <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>
        </form>
    </div>

    <%
        // Procesar el formulario cuando se envía
        String codigo = request.getParameter("codigo");
        String tipo = request.getParameter("tipo");
        String descuentoStr = request.getParameter("descuento");
        String restriccionStr = request.getParameter("restriccion");
        String activoStr = request.getParameter("activo");

        if (codigo != null && tipo != null && descuentoStr != null && restriccionStr != null) {
            String mensaje = "";
            
            try {
                // Validaciones
                if (!codigo.matches("\\d+")) {
                    mensaje = "El código debe contener solo números.";
                } else {
                    double descuento = Double.parseDouble(descuentoStr);
                    int restriccion = Integer.parseInt(restriccionStr);
                    boolean activo = (activoStr != null && activoStr.equals("on"));
                    
                    if (descuento < 0) {
                        mensaje = "El descuento debe ser mayor o igual a 0.";
                    } else if (restriccion < 0) {
                        mensaje = "La restricción debe ser mayor o igual a 0.";
                    } else {
                        // Insertar en la base de datos
                        Dba db = new Dba(application.getRealPath("/") + "daw.mdb");
                        db.conectar();
                        
                        // Verificar si el código ya existe
                        db.query.execute("SELECT Codigo FROM PromoteCode WHERE Codigo='" + codigo + "'");
                        ResultSet rs = db.query.getResultSet();
                        
                        if (rs.next()) {
                            mensaje = "Ya existe un promo code con ese código.";
                        } else {
                            // Insertar promo code
                            String sql = "INSERT INTO PromoteCode (Codigo, Tipo, Descuento, Restriccion, Activo) " +
                                        "VALUES ('" + codigo + "', '" + tipo + "', " + descuento + ", " + 
                                        restriccion + ", " + (activo ? "-1" : "0") + ")";
                            
                            db.executeUpdate(sql);
                            db.commit();
                            mensaje = "Promo Code creado correctamente.";
                        }
                        
                        rs.close();
                        db.desconectar();
                    }
                }
            } catch (NumberFormatException e) {
                mensaje = "Error en los valores numéricos.";
            } catch (Exception e) {
                mensaje = "Error al crear promo code: " + e.getMessage();
                e.printStackTrace();
            }
            
            // Mostrar mensaje
            String color = mensaje.contains("correctamente") ? "green" : "red";
    %>
            <p style="color:<%= color %>; text-align:center; font-weight:bold;"><%= mensaje %></p>
    <%
        }
    %>

    <!-- Lista de Promo Codes -->
    <div class="contenedor">
        <h2 class="titulo">Lista de Promo Codes</h2>
        
        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Tipo</th>
                    <th>Descuento</th>
                    <th>Restricción</th>
                    <th>Activo</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Dba db = null;
                    ResultSet rs = null;
                    try {
                        db = new Dba(application.getRealPath("/") + "daw.mdb");
                        db.conectar();
                        
                        db.query.execute("SELECT * FROM PromoteCode ORDER BY Codigo");
                        rs = db.query.getResultSet();
                        
                        boolean hayPromoCodes = false;
                        while (rs.next()) {
                            hayPromoCodes = true;
                            String tipoDB = rs.getString("Tipo");
                            double descuentoDB = rs.getDouble("Descuento");
                            int restriccionDB = rs.getInt("Restriccion");
                            boolean activoDB = rs.getBoolean("Activo");
                            
                            String tipoMostrar = tipoDB.equals("porcentaje") ? 
                                descuentoDB + "%" : "L. " + descuentoDB;
                            String restriccionMostrar = restriccionDB == 0 ? 
                                "Ilimitado" : restriccionDB + " usos";
                %>
                <tr>
                    <td><%= rs.getString("Codigo") %></td>
                    <td><%= tipoDB.equals("porcentaje") ? "Porcentaje" : "Monto Fijo" %></td>
                    <td><%= tipoMostrar %></td>
                    <td><%= restriccionMostrar %></td>
                    <td><%= activoDB ? "Sí" : "No" %></td>
                    <td>
                        <form action="eliminar_promocode.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="codigo" value="<%= rs.getString("Codigo") %>">
                            <button type="submit" onclick="return confirm('¿Está seguro de eliminar este promo code?')">Eliminar</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        
                        if (!hayPromoCodes) {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px;">
                        No hay promo codes registrados
                    </td>
                </tr>
                <%
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px;">
                        Error al cargar promo codes: <%= e.getMessage() %>
                    </td>
                </tr>
                <%
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (db != null) db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | 
        <a href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas de Privacidad</a> | 
        <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a></p>
    </div>
</body>
</html>