/*
SPRINT 3 Consultas + Modificación Base de datos TE LO VENDO
*/

# Cuál es la categoría de productos que más se repite.
Select categoria_productos, count(categoria_productos) as frecuencia from proveedor
GROUP BY categoria_productos
ORDER BY frecuencia desc
LIMIT 1;

# Cuáles son los productos con mayor stock
Select * from producto
ORDER BY stock desc;

# Qué color de producto es más común en nuestra tienda.
Select color, count(color) as frecuencia from producto
GROUP BY color
ORDER BY frecuencia desc
LIMIT 1;
# Cual o cuales son los proveedores con menor stock de productos.
Select producto_id, nombre_corporativo, precio, categoria, color, stock
FROM producto as prod JOIN proveedor  as prov ON prod.producto_id = prov.proveedor_id
ORDER BY stock
LIMIT 3;

# Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE proveedor
SET categoria_productos = 'Electrónica y computación'
WHERE categoria_productos ='Tecnología';