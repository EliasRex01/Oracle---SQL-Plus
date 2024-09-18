
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




