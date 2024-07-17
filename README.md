# Cat Breeds App

Cat Breeds App es una aplicación móvil desarrollada en Flutter que permite a los usuarios explorar diferentes razas de gatos. Los usuarios pueden ver detalles sobre cada raza, incluyendo una imagen, el origen y la inteligencia de cada raza.

## Arquitectura

La aplicación sigue una arquitectura modular y orientada a capas para asegurar una separación clara de responsabilidades y facilitar el mantenimiento y la escalabilidad del proyecto.

## Pantallas
### Splash Screen:
Muestra una imagen de carga y el título de la aplicación.
### Landing Page:
Lista todas las razas de gatos con una barra de búsqueda para filtrar por nombre.
### Detail Page:
Muestra detalles de una raza específica, incluyendo una imagen (que ocupa la mitad de la pantalla) y otra información relevante en una vista desplazable verticalmente.

## Funcionalidades
- Ver una lista de razas de gatos.
- Filtrar razas de gatos por nombre.
- Ver detalles de una raza específica, incluyendo imagen, origen e inteligencia.

## Api
La aplicación consume datos de The Cat API.

- Endpoint: https://api.thecatapi.com/v1/breeds
