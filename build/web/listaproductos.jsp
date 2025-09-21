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
    <title>Listado de Productos</title>
    <link rel="stylesheet" href="walmart.css">
</head>

<body>
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
    </div>
    <h1>Listado de Productos</h1>

    <table>
        <tr>
            <th>Código</th>
            <th>Categoría</th>
            <th>Nombre y Descripción</th>
            <th>Imagen</th>
            <th>Precio</th>
            <th>ISV</th>
            <th>Acciones</th>
        </tr>
        <tr>
            <td>101</td>
            <td>Electrónica</td>
            <td>AudÃ­fonos Samsung galaxy buds3 inalámbricos colores surtidos</td>
            <td><img src="https://walmarthn.vtexassets.com/arquivos/ids/611346-500-auto?v=638738558486770000&width=500&height=auto&aspect=true"
                    width="50"></td>
            <td>L.3,395.00</td>
            <td>15%</td>
            <td><button onclick="location.href='listaproductos.jsp'">Eliminar</button></td>
        </tr>
        <tr>
            <td>102</td>
            <td>Electrónica</td>
            <td>Licuadora Hamilton Beach Sport - 20oz</td>
            <td><img src="https://walmarthn.vtexassets.com/arquivos/ids/621002-500-auto?v=638754582332100000&width=500&height=auto&aspect=true"
                    width="50"></td>
            <td>L.590.00</td>
            <td>12%</td>
            <td><button onclick="location.href='listaproductos.jsp'">Eliminar</button></td>
        </tr>
        <tr>
            <td>103</td>
            <td>Mascotas</td>
            <td>Snack Dogui Perro Adulto Sabor Pepperoni - 200g</td>
            <td><img src="https://walmarthn.vtexassets.com/arquivos/ids/396178-500-auto?v=638484361155230000&width=500&height=auto&aspect=true"
                    width="50"></td>
            <td>L.25.00</td>
            <td>12%</td>
            <td><button onclick="location.href='listaproductos.jsp'">Eliminar</button></td>
        </tr>
    </table>

    <br>
    <!-- BotÃ³n para regresar -->
        <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>
    <button onclick="location.href='adminproductos.jsp'">Crear otro producto</button>

</body>

</html>