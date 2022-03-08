library(sf)
library(ggplot2)
library(tidyverse)
library(ggnewscale)
library(raster)
library(extrafont)      # custom font
library(hrbrthemes)     # to use import_roboto_condensed()
library(ggthemes)
library(elevatr)
library(tmap)
Venezuela<- getData('GADM', country='Venezuela', level=1) %>% st_as_sf()
Elev     <- getData('alt', country='Venezuela')
plot(Elev)

slope = terrain(Elev  , opt = "slope") 
aspect = terrain(Elev , opt = "aspect")
hill = hillShade(slope, aspect, angle = 40, direction = 270)

colss <-c("#001f54", "#1282a2", "#006400", "#007200", "#008000", "#55a630", "#80b918", "#aacc00", "#bfd200", "#d4d700", "#dddf00", "#eeef20", "#ffff3f")

Mapa= tm_shape(hill) +
  tm_raster(palette = gray(0:10 / 10), n = 100, legend.show = FALSE, alpha=0.8)+
  tm_shape(Elev) +
  tm_raster(alpha = 0.8, palette = colss ,n=10, style="cont",
            legend.show = T, title="Elevacion \n(m.s.n.m)")+
  tm_shape(Venezuela)+
  tm_borders("white",lwd=2)+
  tm_text("NAME_1",size = .8, col="black",shadow=TRUE,fontfamily = "Kefa", 
          fontface = "bold",
          bg.color="white", bg.alpha=.35)+
  tm_scale_bar(width = 0.25, text.size = 0.5, text.color = "black", color.dark = "lightsteelblue4", 
               position = c(.01, 0.005), lwd = 1, color.light= "black")+
  tm_compass(type="rose", position=c(.86, 0.05), text.color = "black")+
  tm_layout( title = "Google Earth Engine \nRelieve, \nModelo de Elevacion Digital",
             bg.color="white", 
             legend.title.size=.8,
             title.color  = "black",
             legend.bg.color = "#416076", 
             legend.text.color = "white",
             legend.title.color = "white",
             legend.position = c(0.005,0.10) , scale=0.61, legend.frame = T,
             fontface="bold",
             legend.format = c(text.align = "right", 
                               text.separator = "-"))+
  tm_credits("VENEZUELA:  Shaded \n     Relief map", position = c(.15, .3), col = "black", fontface="bold", size=2, fontfamily = "serif")+
  tm_credits("Data: https://www.https://code.earthengine.google.com/ \n#Aprende R desde Cero Para SIG \nGorky Florez Castillo", position = c(0.1, .04), col = "black", fontface="bold")+
  tm_logo(c("https://www.r-project.org/logo/Rlogo.png",
            system.file("img/tmap.png", package = "tmap")),height = 3, position = c(0.60, 0.05))+
  tm_grid(col = 'gray', alpha = 0.5)

tmap_save(Mapa, "Mapa/Venezuela.png", dpi = 1200, width = 9, height = 9)



