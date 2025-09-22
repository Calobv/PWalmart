<%
    // Bloque de seguridad general
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
        // Usuario no logueado -> redirige al index
        response.sendRedirect("index.jsp");
        return; // Detiene el resto del JSP
    }
%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Órdenes - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
        <a href="home.jsp">Home</a>
        <a href="carrito.jsp">Mi Carrito</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>

    <div class="contenedor">
        <p class="titulo"><b>Mis Órdenes de Compra</b></p>

        <%
            String emailUsuario = (String) session.getAttribute("email");
            Dba db = null;
            ResultSet rs = null;
            boolean hayOrdenes = false;
            
            try {
                db = new Dba(application.getRealPath("/") + "daw.mdb");
                db.conectar();
                
                // Buscar órdenes del usuario actual
                String sql = "SELECT o.CodigoOrden, o.CodigoCliente, o.ProductosComprados, o.PromoCode, o.TotalPagado, o.FechaCompra " +
                            "FROM Ordenes o INNER JOIN Usuarios u ON o.CodigoCliente = u.Código " +
                            "WHERE u.Email = '" + emailUsuario + "' ORDER BY o.FechaCompra DESC";
                
                db.query.execute(sql);
                rs = db.query.getResultSet();
                
                if (rs.next()) {
                    hayOrdenes = true;
        %>
                    <table class="tabla-productos">
                        <thead>
                            <tr>
                                <th>Código de Orden</th>
                                <th>Productos Comprados</th>
                                <th>Promo Code</th>
                                <th>Total Pagado</th>
                                <th>Fecha</th>
                                <th>Detalles</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                    // Resetear el ResultSet
                    rs.beforeFirst();
                    while (rs.next()) {
                        String codigoOrden = rs.getString("CodigoOrden");
                        String productosComprados = rs.getString("ProductosComprados");
                        String promoCode = rs.getString("PromoCode");
                        if (promoCode == null || promoCode.trim().isEmpty()) {
                            promoCode = "Ninguno";
                        }
                        double totalPagado = rs.getDouble("TotalPagado");
                        String fechaCompra = rs.getString("FechaCompra");
        %>
                            <tr>
                                <td><%= codigoOrden %></td>
                                <td>
                                    <%
                                        // Mostrar nombres de productos en lugar de solo códigos
                                        if (productosComprados != null && !productosComprados.trim().isEmpty()) {
                                            String[] codigosProductos = productosComprados.split(",");
                                            StringBuilder nombresProductos = new StringBuilder();
                                            
                                            for (String codigoProducto : codigosProductos) {
                                                if (codigoProducto.trim().length() > 0) {
                                                    try {
                                                        String sqlProducto = "SELECT Nombre FROM Productos WHERE Codigo = '" + codigoProducto.trim() + "'";
                                                        Dba dbProducto = new Dba(application.getRealPath("/") + "daw.mdb");
                                                        dbProducto.conectar();
                                                        dbProducto.query.execute(sqlProducto);
                                                        ResultSet rsProducto = dbProducto.query.getResultSet();
                                                        
                                                        if (rsProducto.next()) {
                                                            if (nombresProductos.length() > 0) {
                                                                nombresProductos.append(", ");
                                                            }
                                                            nombresProductos.append(rsProducto.getString("Nombre"));
                                                        }
                                                        
                                                        rsProducto.close();
                                                        dbProducto.desconectar();
                                                    } catch (Exception e) {
                                                        // Si hay error, mostrar el código
                                                        if (nombresProductos.length() > 0) {
                                                            nombresProductos.append(", ");
                                                        }
                                                        nombresProductos.append("Producto " + codigoProducto.trim());
                                                    }
                                                }
                                            }
                                            out.print(nombresProductos.toString());
                                        } else {
                                            out.print("Sin productos");
                                        }
                                    %>
                                </td>
                                <td><%= promoCode %></td>
                                <td>L. <%= String.format("%.2f", totalPagado) %></td>
                                <td><%= fechaCompra != null ? fechaCompra : "N/A" %></td>
                                <td>
                                    <button type="button" onclick="verDetalleOrden('<%= codigoOrden %>')">Ver Detalle</button>
                                </td>
                            </tr>
        <%
                    }
        %>
                        </tbody>
                    </table>
        <%
                } else {
                    // No hay órdenes
        %>
                    <div class="mensaje-vacio">
                        <p>No tienes órdenes de compra registradas.</p>
                        <a href="home.jsp" class="btn-comprar">Ir a Comprar</a>
                    </div>
        <%
                }
                
            } catch (Exception e) {
                e.printStackTrace();
        %>
                <div class="mensaje-vacio">
                    <p style="color: red;">Error al cargar las órdenes: <%= e.getMessage() %></p>
                    <a href="home.jsp" class="btn-comprar">Volver al Inicio</a>
                </div>
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

        <!-- Botones de navegación -->
        <div style="margin-top: 20px; text-align: center;">
            <button onclick="location.href='home.jsp'">Continuar Comprando</button>
            <button onclick="location.href='carrito.jsp'">Ver Mi Carrito</button>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | <a
                href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas
                de Privacidad</a> |
            <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a>
        </p>
    </div>

    <script>
        function verDetalleOrden(codigoOrden) {
            alert("Detalle de la orden: " + codigoOrden + "\nPuedes implementar una ventana modal aquí para mostrar más información.");
        }
    </script>
</body>
</html>