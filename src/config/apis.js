// Vite expone solo variables con prefijo VITE_. En Docker o local, define estos valores en .env.
export const API_URLS = {
  ventas: import.meta.env.VITE_API_VENTAS || "/api/v1/ventas",
  despachos:
    import.meta.env.VITE_API_DESPACHOS || "/api/v1/despachos",
};
