# Frontend Despacho

Frontend web para administrar compras y despachos del sistema.

## Que hace

Esta aplicacion React permite:

- listar compras pendientes de despacho
- generar un despacho para una compra
- listar despachos creados
- cerrar o editar un despacho

La interfaz consume dos APIs:

- `/api/v1/ventas`
- `/api/v1/despachos`

En produccion, Nginx actua como reverse proxy y redirige esas rutas hacia los backends.

## Estructura principal

- `src/main.jsx`: punto de entrada de React
- `src/Routes/AppRoutes.jsx`: rutas de la app
- `src/componentes/CrudAdmin.jsx`: pantalla principal del panel
- `src/componentes/CrudAdmin/TableCompras.jsx`: tabla de compras
- `src/componentes/CrudAdmin/FormDespacho.jsx`: formulario para generar despacho
- `src/componentes/CrudAdmin/TableDespachos.jsx`: tabla de despachos
- `src/componentes/CrudAdmin/FormCierreDespacho.jsx`: formulario para cerrar despacho
- `src/config/apis.js`: URLs de API
- `Dockerfile`: construccion multi-stage y runtime con Nginx
- `docker-compose.yml`: ejecucion local del frontend
- `nginx.conf`: configuracion del servidor web y proxy

## Requisitos

- Node.js 20 o superior, si lo ejecutas fuera de Docker
- npm
- Docker y Docker Compose, si lo ejecutas con contenedores

## Ejecucion local sin Docker

```powershell
npm install
npm run dev
```

La aplicacion queda disponible en el puerto que indique Vite.

## Variables de entorno

Vite solo expone variables que empiezan con `VITE_`.

En este proyecto se usan:

- `VITE_API_VENTAS`
- `VITE_API_DESPACHOS`

Si no se definen, el frontend usa por defecto:

- `/api/v1/ventas`
- `/api/v1/despachos`

## Ejecucion con Docker

Construccion y prueba local:

```powershell
docker compose up --build
```

El contenedor expone:

- frontend: `http://localhost:3000`

## Flujo de la interfaz

1. El usuario entra a la ruta `/`.
2. `CrudAdmin` arma la pantalla principal.
3. `TableCompras` consulta las ventas disponibles.
4. El usuario genera un despacho con `FormDespacho`.
5. `TableDespachos` lista los despachos creados.
6. `FormCierreDespacho` permite actualizar el estado final del despacho.

## Dockerfile

El `Dockerfile` usa multi-stage build:

1. Primera etapa: construye la app con Node.
2. Segunda etapa: sirve el resultado con Nginx unprivileged.

Esto reduce el tamano final de la imagen y evita correr el servidor como root.

## Despliegue

En CI/CD, este repo usa GitHub Actions para:

1. construir la imagen
2. publicarla en Docker Hub
3. conectarse por SSH a la EC2 del frontend
4. ejecutar `docker compose pull` y `docker compose up -d`

Los secrets esperados estan documentados en [deploy/README.md](../deploy/README.md).
