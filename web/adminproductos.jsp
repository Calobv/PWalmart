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
    <title>Crear Producto</title>
    <link rel="stylesheet" href="walmart.css">
</head>

<body>
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
    </div>
    <h1>Crear Nuevo Producto</h1>

    <form>
        <label for="codigo">Código:</label>
        <input type="number" id="codigo" name="codigo"><br><br>

        <label for="categoria">Categoría:</label>
        <input type="text" id="nombre" name="nombre"><br><br>

        <label for="descripcion">Nombre y Descripción:</label>
        <input type="text" id="descripcion" name="descripcion"><br><br>

        <label for="precio">Precio:</label>
        <input type="number" id="precio" name="precio"><br><br>

        <label for="isv">ISV (%):</label>
        <input type="number" id="isv" name="isv"><br><br>
        <!-- BotÃ³n para regresar -->
        <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>
        <!-- BotÃ³n que simula guardar y redirige -->
        <button type="button" onclick="location.href='listaproductos.html'">Guardar Producto</button>

    </form>
</body>

</html>