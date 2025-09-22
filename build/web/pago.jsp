<%-- 
    Document   : pago
    Created on : 21/09/2025, 06:05:49 PM
    Author     : pc
--%>

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
<%@page import="java.util.Random"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Proceso de Pago - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
    <script>
        function validarPago() {
            var montoPagado = document.getElementById("montoPagado").value;
            var totalAPagar = document.getElementById("totalAPagar").value;
            
            if (montoPagado === "" || isNaN(montoPagado)) {
                alert("Por favor ingrese un monto válido");
                return false;
            }
            
            var monto = parseFloat(montoPagado);
            var total = parseFloat(totalAPagar);
            
            if (monto < total) {
                alert("El monto ingresado es menor al total a pagar. Total requerido: L. " + total.toFixed(2));
                return false;
            }
            
            if (monto > total) {
                var cambio = monto - total;
                if (!confirm("Cambio a entregar: L. " + cambio.toFixed(2) + "\n¿Confirmar pago?")) {
                    return false;
                }
            }
            
            return true;
        }
    </script>
</head>
<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
        <a href="home.jsp">Home</a>
        <a href="carrito.jsp">Volver al Carrito</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>

    <div class="contenedor">
        <p class="titulo"><b>Proceso de Pago</b></p>

        <%
            // Procesar pago si viene del formulario
            String montoPagadoStr = request.getParameter("montoPagado");
            String totalAPagarStr = request.getParameter("totalAPagar");
            String promoCode = request.getParameter("promoCodeUsado");
            
            if (montoPagadoStr != null && totalAPagarStr != null) {
                // Procesar la compra
                try {
                    double montoPagado = Double.parseDouble(montoPagadoStr);
                    double totalAPagar = Double.parseDouble(totalAPagarStr);
                    String emailUsuario = (String) session.getAttribute("email");
                    
                    if (montoPagado >= totalAPagar) {
                        // Pago válido, procesar la orden
                        Dba db = new Dba(application.getRealPath("/") + "daw.mdb");
                        db.conectar();
                        
                        // Obtener código del cliente
                        String sqlCliente = "SELECT Código FROM Usuarios WHERE Email = '" + emailUsuario + "'";
                        db.query.execute(sqlCliente);
                        ResultSet rsCliente = db.query.getResultSet();
                        String codigoCliente = "";
                        
                        if (rsCliente.next()) {
                            codigoCliente = rsCliente.getString("Código");
                        }
                        rsCliente.close();
                        
                        // Obtener productos en carrito
                        String sqlProductos = "SELECT Codigo FROM Productos WHERE EnCarrito = -1";
                        db.query.execute(sqlProductos);
                        ResultSet rsProductos = db.query.getResultSet();
                        
                        StringBuilder codigosProductos = new StringBuilder();
                        while (rsProductos.next()) {
                            if (codigosProductos.length() > 0) {
                                codigosProductos.append(",");
                            }
                            codigosProductos.append(rsProductos.getString("Codigo"));
                        }
                        rsProductos.close();
                        
                        // Generar código de orden aleatorio
                        Random random = new Random();
                        String codigoOrden = String.valueOf(100000 + random.nextInt(900000));
                        
                        // Obtener fecha actual
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String fechaActual = sdf.format(new Date());
                        
                        // Insertar orden
                        String promoCodeFinal = (promoCode != null && !promoCode.trim().isEmpty()) ? promoCode : null;
                        String sqlOrden = "INSERT INTO Ordenes (CodigoOrden, CodigoCliente, ProductosComprados, PromoCode, TotalPagado, FechaCompra) " +
                                         "VALUES ('" + codigoOrden + "', '" + codigoCliente + "', '" + codigosProductos.toString() + "', " +
                                         (promoCodeFinal != null ? "'" + promoCodeFinal + "'" : "NULL") + ", " + montoPagado + ", '" + fechaActual + "')";
                        
                        db.executeUpdate(sqlOrden);
                        
                        // Limpiar carrito - marcar productos como no en carrito
                        String sqlLimpiarCarrito = "UPDATE Productos SET EnCarrito = 0 WHERE EnCarrito = -1";
                        db.executeUpdate(sqlLimpiarCarrito);
                        
                        db.commit();
                        db.desconectar();
                        
                        // Mostrar confirmación de compra
                        double cambio = montoPagado - totalAPagar;
        %>
                        <div class="resumen-carrito">
                            <h2 style="color: green;">¡Compra Realizada Exitosamente!</h2>
                            <p><strong>Código de Orden:</strong> <%= codigoOrden %></p>
                            <p><strong>Total Pagado:</strong> L. <%= String.format("%.2f", montoPagado) %></p>
                            <% if (cambio > 0) { %>
                                <p><strong>Cambio:</strong> L. <%= String.format("%.2f", cambio) %></p>
                            <% } %>
                            <% if (promoCodeFinal != null) { %>
                                <p><strong>Promo Code Utilizado:</strong> <%= promoCodeFinal %></p>
                            <% } %>
                            <p><strong>Fecha:</strong> <%= fechaActual %></p>
                            
                            <div style="margin-top: 20px;">
                                <button onclick="location.href='oredenes.jsp'" class="btn-comprar">Ver Mis Órdenes</button>
                                <button onclick="location.href='home.jsp'" class="btn-comprar">Seguir Comprando</button>
                            </div>
                        </div>
        <%
                    } else {
                        // Monto insuficiente
        %>
                        <div style="color: red; text-align: center;">
                            <p>El monto ingresado es insuficiente. Se requieren L. <%= String.format("%.2f", totalAPagar) %></p>
                            <button onclick="history.back()">Volver</button>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
        %>
                    <div style="color: red; text-align: center;">
                        <p>Error al procesar el pago: <%= e.getMessage() %></p>
                        <button onclick="location.href='carrito.jsp'">Volver al Carrito</button>
                    </div>
        <%
                }
            } else {
                // Mostrar formulario de pago
                Dba db = null;
                ResultSet rs = null;
                double subtotal = 0.0;
                double totalIsv = 0.0;
                double total = 0.0;
                String promoCodeParam = request.getParameter("promocode");
                double descuento = 0.0;
                boolean hayProductos = false;

                try {
                    db = new Dba(application.getRealPath("/") + "daw.mdb");
                    db.conectar();
                    
                    // Verificar descuento si hay promo code
                    if (promoCodeParam != null && !promoCodeParam.trim().isEmpty()) {
                        String promoQuery = "SELECT Descuento, Tipo FROM PromoteCode WHERE Codigo = '" + promoCodeParam + "' AND Activo = -1";
                        db.query.execute(promoQuery);
                        ResultSet promoRs = db.query.getResultSet();
                        if (promoRs.next()) {
                            descuento = promoRs.getDouble("Descuento");
                        }
                        promoRs.close();
                    }
                    
                    // Calcular total del carrito
                    String query = "SELECT * FROM Productos WHERE EnCarrito = -1";
                    db.query.execute(query);
                    rs = db.query.getResultSet();

                    while (rs.next()) {
                        hayProductos = true;
                        double precioProducto = rs.getDouble("Precio");
                        double isvProducto = precioProducto * 0.15;
                        subtotal += precioProducto;
                        totalIsv += isvProducto;
                    }
                    
                    total = subtotal + totalIsv;
                    double finalTotal = total - (total * (descuento / 100));
                    
                    if (hayProductos) {
        %>
                        <div class="resumen-carrito">
                            <h2>Resumen de Compra</h2>
                            <p><strong>Subtotal:</strong> L. <%= String.format("%.2f", subtotal) %></p>
                            <p><strong>ISV (15%):</strong> L. <%= String.format("%.2f", totalIsv) %></p>
                            <% if (descuento > 0) { %>
                                <p><strong>Descuento (<%= String.format("%.0f", descuento) %>%):</strong> L. <%= String.format("%.2f", total * (descuento / 100)) %></p>
                            <% } %>
                            <p style="font-size: 1.2em; color: #0071ce;"><strong>Total a Pagar: L. <%= String.format("%.2f", finalTotal) %></strong></p>
                            
                            <hr>
                            
                            <form method="post" onsubmit="return validarPago()">
                                <h3>Información de Pago</h3>
                                <input type="hidden" name="totalAPagar" id="totalAPagar" value="<%= finalTotal %>">
                                <% if (promoCodeParam != null && !promoCodeParam.trim().isEmpty()) { %>
                                    <input type="hidden" name="promoCodeUsado" value="<%= promoCodeParam %>">
                                <% } %>
                                
                                <label for="montoPagado"><strong>Monto a Pagar (L.):</strong></label><br>
                                <input type="number" id="montoPagado" name="montoPagado" step="0.01" min="<%= finalTotal %>" 
                                       placeholder="<%= String.format("%.2f", finalTotal) %>" required style="width: 200px; padding: 8px; margin: 10px 0;">
                                <br>
                                
                                <p style="color: #666; font-size: 0.9em;">
                                    Ingrese el monto exacto o mayor. Si es mayor, se calculará su cambio.
                                </p>
                                
                                <div style="margin-top: 20px;">
                                    <button type="submit" class="btn-comprar">Confirmar Pago</button>
                                    <button type="button" onclick="location.href='carrito.jsp'" class="btn-comprar">Volver al Carrito</button>
                                </div>
                            </form>
                        </div>
        <%
                    } else {
        %>
                        <div class="mensaje-vacio">
                            <p>Su carrito está vacío. No hay productos para pagar.</p>
                            <button onclick="location.href='home.jsp'" class="btn-comprar">Ir a Comprar</button>
                        </div>
        <%
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace();
        %>
                    <div style="color: red; text-align: center;">
                        <p>Error al cargar información de pago: <%= e.getMessage() %></p>
                        <button onclick="location.href='carrito.jsp'">Volver al Carrito</button>
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
            }
        %>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | <a
                href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas
                de Privacidad</a> |
            <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a>
        </p>
    </div>
</body>
</html>