-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 17-11-2023 a las 16:32:59
-- Versión del servidor: 5.7.17-log
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `burguertic`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(255) NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `id_usuario`, `fecha`, `estado`) VALUES
(6, 1, '2023-11-02', 'pendiente'),
(7, 1, '2023-11-02', 'pendiente'),
(8, 1, '2023-11-02', 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_platos`
--

CREATE TABLE `pedidos_platos` (
  `id` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_plato` int(11) NOT NULL,
  `cantidad` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos_platos`
--

INSERT INTO `pedidos_platos` (`id`, `id_pedido`, `id_plato`, `cantidad`) VALUES
(11, 6, 1, 3),
(12, 6, 2, 1),
(13, 7, 1, 3),
(14, 7, 2, 1),
(15, 8, 1, 3),
(16, 8, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `platos`
--

CREATE TABLE `platos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `precio` int(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `platos`
--

INSERT INTO `platos` (`id`, `nombre`, `tipo`, `precio`, `descripcion`) VALUES
(1, 'Combo Ivo', 'combo', 3000, 'Un sandwich de gallina, con papas y gaseosa. Si venis con 12 amigos te cobramos la mitad + 1'),
(2, 'Combo Chona', 'combo', 3100, 'Una FigmaBurger, con papas y gaseosa. Si queres una hamburguesa estética para subir a Instagram, esta es la tuya'),
(3, 'Combo Aro y Ranzo', 'combo', 4500, 'Una P.H.P. y un Em-Paty-Zando con 2 gaseosas y 2 porciones de papas. Ideal para compartir con tu pareja'),
(4, 'Combo M.E.P.', 'combo', 5000, 'Milanesa gigante, 3 empanadas y papas. Laburar? No, veni a compartir este combo con tus amigos y disfruta del tiempo libre'),
(5, 'Combo Nacho', 'combo', 3500, 'Un SQL, nachos con guacamole, gaseosa y de postre un vigilante. Si haces bien la request, te llega al instante'),
(6, 'Combo Jero', 'combo', 3100, 'Una milanesa Blender, bolsa de 3Ds y gaseosa. No se juega con la comida, pero podes jugar videojuegos mientras comes este combo'),
(7, 'Combo Daro', 'combo', 2900, 'Una hamburguesa eléctrica con pocas papas y un vaso de gaseosa, el dólar está muy alto y no nos aceptan más presupuesto. Nosotros los preparamos pero vos andá a buscarlo. Si no lo encontras, no hay reembolso'),
(8, 'Menu Infantil Luca', 'combo', 3500, 'Una caja de 10 nuggets y gaseosa. Para los más chicos de la casa, o para los que tengan muchos rulos'),
(9, 'FigmaBurger', 'principal', 2000, 'Hamburguesa de carne, con lechuga, tomate, cebolla, queso y salsa de la casa. Está separada en componentes, así que podes editarla a tu gusto'),
(10, 'P.H.P.', 'principal', 2500, 'Pan, hamburguesa, pan. La hamburguesa más simple, pero la más rica. No te dejes engañar por su simplicidad, es una de las mejores hamburguesas que vas a probar'),
(11, 'Milanesa Blender', 'principal', 3000, 'Milanesa de carne, con queso provolone y cebolla. Combina formas y texturas de manera increible, una foto con la iluminación correcta y esta milanesa parece un render'),
(12, 'Em-Paty-Zando', 'principal', 2500, 'Pedila como vos quieras, nosotros vamos a atender tus pedidos y armarla como necesites'),
(13, 'Sandwich de gallina', 'principal', 1500, 'Sandwich de gallina, con lechuga, tomate, cebolla y salsa de la casa. Sale siempre fría, nada como una de estas después de ganar algún partido por penales.'),
(14, 'Hamburguesa eléctrica', 'principal', 2000, 'Hamburguesa de carne, con lechuga, tomate, cebolla, queso y salsa de la casa (capaz alguna resistencia). No la comas descalzo, no queremos que te electrocutes'),
(15, 'SQL', 'principal', 2500, 'Salsa, Queso y Lomito. No vas a encontrar un lomito más rico que este, ni aunque hagas un \'select * from lomitos\''),
(16, 'Vigilante', 'postre', 1000, 'Queso y dulce de BATATA, no vendemos de membrillo. Un clásico de los postres, no puede faltar en tu pedido'),
(17, 'Pau-stre de chocolate', 'postre', 1500, 'Postre de chocolate, con dulce de leche y crema. Muy dulce, te va a hacer acordar al postre que te hacía tu mamá'),
(18, 'Helado', 'postre', 1000, 'Helado de crema, con dulce de leche y chocolate. Es helado, acá no se me ocurre nada'),
(19, 'TIC', 'postre', 1500, 'Torta Irresistible de Chocolate. Es la mejor elección sobre todo si estás en 2do.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `password`) VALUES
(1, 'Sofia', 'Rzondzinski', 'sof.rzo2006@gmail.com', 'Hola123'),
(2, 'Juan', 'Perez', 'juanperez@gmail.com', '$2b$15$oPiNbIehJLQaAPX0L0gOsu8If/XkwZj/4ZMFUHrbFbWE0bnS3P50K'),
(3, 'Juan', 'Perez', 'juanperez@gmail.com', '$2b$15$i5275GzxrQzzDCNHdNLr/.YxyUfRCw1HU8FW6kCb.dNd1D4HKMk.C');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ID de usuario` (`id_usuario`);

--
-- Indices de la tabla `pedidos_platos`
--
ALTER TABLE `pedidos_platos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ID de pedido` (`id_pedido`);

--
-- Indices de la tabla `platos`
--
ALTER TABLE `platos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `pedidos_platos`
--
ALTER TABLE `pedidos_platos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `platos`
--
ALTER TABLE `platos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `ID de usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos_platos`
--
ALTER TABLE `pedidos_platos`
  ADD CONSTRAINT `ID de pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
