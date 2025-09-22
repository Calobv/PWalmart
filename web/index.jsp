<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Walmart Honduras</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <!-- Encabezado -->
    <header>
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png" 
             alt="Walmart Logo" class="logo">
        <nav>
            <a href="login.jsp">Iniciar Sesión</a>
            <a href="registro.jsp">Crear Cuenta</a>
        </nav>
    </header>

    <!-- Banner Principal -->
    <section class="banner">
        <img src="https://i.blogs.es/bd3ad0/walmart/1366_2000.jpg" alt="Banner principal">
        <div class="banner-texto">
            <h1>¡Ahorra más en Walmart!</h1>
            <p>Los mejores precios en productos de calidad</p>
            <a href="registro.jsp" class="btn-banner">Comenzar a Comprar</a>
        </div>
    </section>

    <!-- Frase Publicitaria -->
    <section class="frase">
        <h2>"Siempre precios bajos. Siempre."</h2>
    </section>

    <!-- Categorías -->
    <section class="categorias">
        <h2>Nuestras Categorías</h2>
        <div class="grid">
            <div class="card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227271-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Electrónicos">
                <h3>Electrónicos</h3>
                <p>Los mejores precios en tecnología</p>
            </div>
            <div class="card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227252-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Hogar">
                <h3>Hogar y Decoración</h3>
                <p>Todo para tu hogar</p>
            </div>
            <div class="card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227261-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Ropa">
                <h3>Ropa y Accesorios</h3>
                <p>Moda para toda la familia</p>
            </div>
            <div class="card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227266-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Alimentos">
                <h3>Alimentos</h3>
                <p>Frescos y de calidad</p>
            </div>
        </div>
    </section>

    <!-- Artículos de Información (datos estáticos temporales) -->
    <section class="ofertas">
        <h2>Información de Productos</h2>
        <div class="grid">
            <%
                // Datos estáticos temporales para reemplazar el Web Service
                String[][] articulos = {
                    {"Smartphones Samsung", "Los mejores smartphones con tecnología de última generación", "https://walmarthn.vtexassets.com/arquivos/ids/227271-800-auto?v=638086834259570000&width=800&height=auto&aspect=true"},
                    {"Televisores Smart TV", "Disfruta del mejor entretenimiento en casa", "https://walmarthn.vtexassets.com/arquivos/ids/227252-800-auto?v=638086834259570000&width=800&height=auto&aspect=true"},
                    {"Electrodomésticos", "Para hacer tu vida más fácil y cómoda", "https://walmarthn.vtexassets.com/arquivos/ids/227261-800-auto?v=638086834259570000&width=800&height=auto&aspect=true"},
                    {"Productos de Limpieza", "Mantén tu hogar siempre limpio", "https://walmarthn.vtexassets.com/arquivos/ids/227266-800-auto?v=638086834259570000&width=800&height=auto&aspect=true"}
                };
                
                for (int i = 0; i < articulos.length; i++) {
            %>
                <div class="card">
                    <img src="<%= articulos[i][2] %>" alt="<%= articulos[i][0] %>">
                    <h3><%= articulos[i][0] %></h3>
                    <p><%= articulos[i][1] %></p>
                </div>
            <%
                }
            %>
        </div>
    </section>

    <!-- Productos Destacados -->
    <section class="promos">
        <h2>Productos Destacados</h2>
        <div class="grid-promos">
            <div class="promo-card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227271-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Producto 1">
                <a href="login.jsp" class="btn-promo">Ver Producto</a>
            </div>
            <div class="promo-card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227252-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Producto 2">
                <a href="login.jsp" class="btn-promo">Ver Producto</a>
            </div>
            <div class="promo-card">
                <img src="https://walmarthn.vtexassets.com/arquivos/ids/227261-800-auto?v=638086834259570000&width=800&height=auto&aspect=true" alt="Producto 3">
                <a href="login.jsp" class="btn-promo">Ver Producto</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <%
            // Datos estáticos temporales para redes sociales
            String[][] redes = {
                {"Facebook", "https://www.facebook.com/WalmartHonduras"},
                {"Instagram", "https://www.instagram.com/walmarthn"},
                {"Twitter", "https://twitter.com/walmarthn"},
                {"YouTube", "https://www.youtube.com/user/walmart"}
            };
        %>
        
        <div>
            <h3>Síguenos en:</h3>
            <%
                for (int i = 0; i < redes.length; i++) {
            %>
                <a href="<%= redes[i][1] %>" target="_blank"><%= redes[i][0] %></a>
            <%
                }
            %>
        </div>
        
        <p>&copy; 2025 Walmart Honduras | 
           <a href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas de Privacidad</a> | 
           <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos y Condiciones</a>
        </p>
    </footer>
</body>
</html>