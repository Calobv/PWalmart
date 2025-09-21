<%
    // Bloque de seguridad para administración
    String rol = (String) session.getAttribute("rol");

    if (rol == null || !rol.equals("admin")) {
        // No está logueado o no es admin -> redirige al index
        response.sendRedirect("index.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrar Promo Codes - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png" alt="Walmart Logo" class="logo">
        <br>
        <a href="adminproductos.jsp">Productos</a>
        <a href="adminusuarios.jsp">Usuarios</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>

    <!-- Crear Promo Code -->
    <div class="contenedor">
        <p class="titulo"><b>Crear Promo Code</b></p>
        <form action="admin_promos.jsp" method="post" class="formulario">
            <label>Código:</label><br>
            <input type="number" name="codigo" required><br><br>

            <label>Tipo:</label><br>
            <input type="radio" name="tipo" value="porcentaje"> Porcentaje 
            <input type="radio" name="tipo" value="monto"> Monto fijo<br><br>

            <label>Restricción (número de usos, 0 = ilimitado):</label><br>
            <input type="number" name="restriccion" required><br><br>

            <label>Activo:</label><br>
            <input type="checkbox" name="activo" checked> Sí­<br><br>

            <input type="submit" value="Guardar Promo Code" class="btn-guardar">
            <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>
        </form>
    </div>

    <!-- Lista de Promo Codes -->
    <div class="contenedor">
        <p class="titulo"><b>Lista de Promo Codes</b></p>
        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Tipo</th>
                    <th>Restricción</th>
                    <th>Activo</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1001</td>
                    <td>Porcentaje (15%)</td>
                    <td>5 usos</td>
                    <td>S+i­</td>
                    <td>
                        
                        <a href="adminpromos.jsp">Eliminar</a>
                    </td>
                </tr>
                <tr>
                    <td>2001</td>
                    <td>Monto fijo (L.500)</td>
                    <td>Ilimitado</td>
                    <td>No</td>
                    <td>
                        
                        <a href="adminpromos.jsp">Eliminar</a>
                    </td>
                </tr>
            </tbody>
        </table>
         <!-- BotÃ³n para regresar -->
<button onclick="location.href='index.jsp'">Regresar</button>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | <a href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">PolÃ­ticas 
            de Privacidad</a> | <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a></p>
    </div>
</body>
</html>