
-- eliminar navigation bars
-- delete lines below --

  #REGION_POSITION_07#
  <div class="t-Header-branding">
    <div class="t-Header-controls">
      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-controlsIcon" aria-hidden="true"></span></button>
    </div>
    <div class="t-Header-logo">
      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>
      #AFTER_LOGO#
    </div>
    <div class="t-Header-navBar">
      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>
      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>
      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>
    </div>
  </div>
  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>

-- delete lines above --

-- eliminar menu de navegacion
marcar Override User Interface Level

-- eliminar el footer release 1.0, copiar el codigo en css inline
.t-Footer{
  display: none;
}

-- o usando
footer{display:none!important}


-- en source html se cambia la immagen
<img src="#APP" widgt=200 height=60 </img>
-- ejemplo <img src="#APP_FILES#h-Photoroom.png" widgt=200 height=60 </img>

-- cargar video
<video src="URL">
<video src="" <>


-- menu posterior con accesos
<br>
<span class="fa fa-globe" aria-hidden="true"></span> ES &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span aria-hidden="true" class="fa fa-phone"></span> +121 123- 3223&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ayuda &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span aria-hidden="true" class="fa fa-user-circle"></span> Iniciar Sesion


-- sacar borders blancos de la region entrar a layout
-- en slot elegir full width content, en live edition marcar Remove Body Padding


-- crear un titulo en monospace con font definido negro y medio rustico
<div class="hero-containerr">

  <div class="hero-textt">
    <h1>Comentarios de Clientes</h1>
  </div>
</div>

<style>
  /* Contenedor principal del hero */
  .hero-containerr {
    position: relative;
    height: 15vh;
    width: 100%;
    overflow: hidden;
    display: flex;
    flex-direction: column;
  }

  /* Texto de bienvenida */
  .hero-textt {
    text-align: center;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    z-index: 5;
  }

  /* Título de bienvenida */
  .hero-textt h1 {
    font-size: 50px;
    font-family: 'Monospace', sans-serif;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
  }

</style>


-- nueva version
<div class="hero-containerr">

  <div class="hero-textt">
    <h1>Comentarios de Clientes</h1>
    <!-- Se añade la línea por debajo del texto -->
    <div class="underline"></div>
  </div>

</div>

<style>
  /* Contenedor principal del hero */
  .hero-containerr {
    position: relative;
    height: 15vh; /* Altura ajustada para que ocupe menos espacio */
    width: 100%;
    overflow: hidden;
    display: flex;
    flex-direction: column;
  }

  /* Contenedor del texto */
  .hero-textt {
    text-align: center;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 5;
    /* Color del texto modificado a negro */
    color: black;
  }

  /* Estilo del título */
  .hero-textt h1 {
    /* Tamaño de la fuente reducido */
    font-size: 24px; 
    /* Cambio a una fuente monospace */
    font-family: 'Courier New', Courier, monospace; 
    font-weight: bold;
    /* Se elimina el sombreado para un estilo más simple */
    text-shadow: none;
  }

  /* Línea por debajo del texto */
  .underline {
    width: 100px; /* Ancho de la línea */
    height: 2px;  /* Grosor de la línea */
    background-color: black; /* Color de la línea */
    margin: 10px auto 0; /* Centrada y con espacio por encima */
  }
</style>


