
<%
    // Bloque de seguridad general
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
        // Usuario no logueado -> redirige al index
        response.sendRedirect("index.jsp");
        return; // Detiene el resto del JSP
    }
%>

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
        <a href="index.jsp">Cerrar Sesi�n</a>
    </div>

    <!-- Órdenes -->
    <div class="contenedor">
        <p class="titulo"><b>Mis �rdenes</b></p>

        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>C�digo de Orden</th>
                    <th>Productos</th>
                    <th>Promo Code</th>
                    <th>Total Pagado</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>ORD-1001</td>
                    <td>
                        Carb�n Great Value Vegetal Briquetas 100% Natural - 2 kg, Maleta Bob Esponja colores - 20
                        pulgadas
                        <br>
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/637163-500-auto?v=638781006135930000&width=500&height=auto&aspect=true"
                             width="60">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/642676-500-auto?v=638797851562100000&width=500&height=auto&aspect=true" 
                        width="60">
                    </td>
                    <td>DESC15</td>
                    <td>L. 0.00</td>
                </tr>
                <tr>
                    <td>ORD-1002</td>
                    <td>
                        L�mpara De Techo Ms 1lt Negra Sin Bomb
                        <br>
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/541285-500-auto?v=638682435012170000&width=500&height=auto&aspect=true"
                         width="60">
                    </td>
                    <td>NINGUNO</td>
                    <td>L. 0.00</td>
                </tr>
            </tbody>
        </table>

        <!-- Mensaje alternativo si no hay órdenes -->
        <p class="mensaje-vacio">No tienes �rdenes registradas.</p>
         <!-- Botón para regresar -->
<button onclick="location.href='home.jsp'">Regresar</button>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | <a href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">
                Pol�ticas de Privacidad</a> | 
            <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">T�rminos</a></p>
    </div>
</body>

</html>