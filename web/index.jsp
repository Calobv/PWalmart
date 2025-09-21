

<%@page import="paquete.Server"%>
<%@page import="paquete.ServerWalmartWS"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
    // Crear instancia del Web Service
    ServerWalmartWS servicio = new ServerWalmartWS();
    Server port = servicio.getServerPort();

    // Obtener redes sociales y artículos
    java.util.List<String> redes = port.getRedesSociales();
    java.util.List<String> articulos = port.getArticulosInfo();
%>




<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Walmart</title>
        <link rel="stylesheet" href="walmart.css">
    </head>

    <body>
        <header>
            <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
                 class="logo">
            <nav>
                <a href="index.jsp">Inicio</a> |
                <a href="login.jsp">Iniciar Sesión</a> |
                <a href="registro.jsp">Crear Cuenta</a> |

            </nav>
        </header>


        <main>
            <h1>¡Bienvenido a Walmart!</h1>

            <p>Tu hogar, tu estilo, tus compras... todo comienza en Walmart.</p>






            <!-- Banner Principal -->
            <section class="banner">

                <img src="https://tpc.googlesyndication.com/simgad/9916378866837394602?" alt="Promoción Walmart">
                </a>
                <div class="banner-texto">
                    <h1>Ahorra dinero. Vive mejor.</h1>
                    <p>Encuentra las mejores rebajas en línea solo en Walmart.</p>
                    <a href="" class="btn-banner">Ver productos</a>
                </div>
            </section>
            <section class="productos">
                <h2>Productos destacados</h2>
                <div class="grid">
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/347019-500-auto?v=638403790258930000&width=500&height=auto&aspect=true"
                             alt="Producto 1">
                        <h3>Pantalla LG LED Smart UHD 4K AI ThinQ 50UR7300PSA - 50 pulgadas</h3>
                        <hr>
                    </div>
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/664471-500-auto?v=638845143213370000&width=500&height=auto&aspect=true"
                             alt="Producto 2">
                        <h3>Celular Honor X5B Plus 4GB 256GB</h3>
                        <hr>
                    </div>
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/618334-500-auto?v=638749123169830000&width=500&height=auto&aspect=true"
                             alt="Producto 3">
                        <h3>Impresora Hp Printer Smart Tank 585 Aio Wls</h3>
                        <hr>
                    </div>
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/425422-500-auto?v=638561614294630000&width=500&height=auto&aspect=true"
                             alt="Producto 4">
                        <h3>Klip Headset Bt 40hrs Base On Ar Bu</h3>
                        <hr>
                    </div>
                </div>
            </section>
        </main>
        <!-- CategorÃ­as -->
        <section class="categorias">
            <h2>Categorías Populares</h2>
            <div class="grid">
                <div class="card">
                    <img src="https://tpc.googlesyndication.com/simgad/13989650293172783743?" alt="Electrónica">
                    <p>Electrónica</p>
                </div>
                <div class="card">
                    <img src="https://tpc.googlesyndication.com/simgad/5198672823379707499?" alt="Hogar">
                    <p>Hogar</p>
                </div>
                <div class="card">
                    <img src="https://tpc.googlesyndication.com/simgad/3555200206941966355?" alt="Frutas">
                    <p>Alimentos y Bebidas</p>
                </div>
                <div class="card">
                    <img src="https://tpc.googlesyndication.com/simgad/14241258419032207148?" alt="Mascotas">
                    <p>Mascotas</p>
                </div>
                <div class="card">
                    <img src="https://tpc.googlesyndication.com/simgad/14027619851017779501?" alt="BebÃ©s">
                    <p>Bebés</p>
                </div>
            </div>
        </section>
        <section class="frase">
            <br>
            <section class="ofertas">
                <h2>Ofertas del Día</h2>
                <div class="grid">
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/227354-500-auto?v=637865410871230000&width=500&height=auto&aspect=true"
                             alt="Oferta 1">
                        <hr>
                        <p><strong>Set Mainstays de sarten - 3 Pzas</strong><br>Antes L.12,000<br>Ahora L.8,999</p>
                    </div>
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/438727-500-auto?v=638580694440030000&width=500&height=auto&aspect=true"
                             alt="Oferta 2">
                        <hr>
                        <p><strong>Horno Tostador De 4 Rebanadas</strong><br>Antes L.1,499.00<br>Ahora L.1,195.00</p>
                    </div>
                    <div class="card">
                        <img src="https://walmarthn.vtexassets.com/arquivos/ids/519402-500-auto?v=638662927990900000&width=500&height=auto&aspect=true"
                             alt="Oferta 3">
                        <hr>
                        <p><strong>Smartwatch Samsung galaxy watch 6 con bluetooth - 40 mm</strong><br>Antes
                            L.7,994.00<br>Ahora L.6,995.00</p>
                    </div>
                </div>
            </section>
            <p>"En Walmart encontrarás todo lo que necesitas al mejor precio."</p>
        </section>
        <!-- Banners Peques -->
        <section class="promos">
            <h2>Promociones Destacadas</h2>
            <div class="grid-promos">
                <div class="promo-card">
                    <img src="https://tpc.googlesyndication.com/simgad/14625914663489518777?" alt="Chiky Mundo Secreto">
                    <a href="" class="btn-promo">Comprar aquí</a>
                </div>
                <div class="promo-card">
                    <img src="https://tpc.googlesyndication.com/simgad/5533006800294590531?" alt="Purina Dog Chow">
                    <a href="" class="btn-promo">Comprar aquí</a>
                </div>
                <div class="promo-card">
                    <img src="https://tpc.googlesyndication.com/simgad/16880264829540789636?" alt="Todo para tu mascota">
                    <a href="" class="btn-promo">Comprar aquí</a>
                </div>
                <div class="promo-card">
                    <img src="https://tpc.googlesyndication.com/simgad/10782434688240007092?" alt="Todo para tu bebé">
                    <a href="" class="btn-promo">Comprar aquí</a>
                </div>
            </div>


            <!-- Sección Artículos -->
            <section class="articulos">
                <h2>Artículos de Información</h2>
                <%
                    for (String art : articulos) {
                        String[] partes = art.split("\\|");
                %>
                <div class="articulo-card">
                    <h3><%= partes[0]%></h3>
                    <p><%= partes[1]%></p>
                    <p><strong>Producto Relacionado:</strong> <%= partes[2]%></p>
                </div>
                <%
                    }
                %>


            </section> <!-- Sección Redes Sociales -->

            <section class="redes-sociales">
                <h2>Síguenos en nuestras redes sociales</h2>

                <ul>
                    <%
                        for (String red : redes) {
                            String[] partes = red.split("\\|");
                    %>
                    <li><a href="<%= partes[1]%>" target="_blank"><%= partes[0]%></a></li>
                        <%
                            }
                        %>
                </ul>
            </section>



            <footer>
                <p>&copy; 2025 Walmart | <a
                        href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">
                        Políticas
                        de Privacidad</a> | <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a>
                </p>





                <!--<div class="redes">
                    <a href="https://facebook.com">Facebook</a> | 
                    <a href="https://twitter.com">Twitter</a> | 
                    <a href="https://instagram.com">Instagram</a>

                </div>-->



            </footer>
    </body>

</html>