const menu = require('./menu.json');
const express = require('express');
const cors = require("cors");
const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());

app.get('/menu', (req, res) => {
  res.json(menu);
});

app.get('/menu/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const plato = menu.find(item => item.id === id);
  if (plato) {
    res.json(plato);
  } else {
    res.status(404).json({ mensaje: 'Plato no encontrado' });
  }
});

app.get('/combos', (req, res) => {
  const combos = menu.filter(item => item.tipo === 'combo');
  res.json(combos);
});

app.get('/principales', (req, res) => {
  const principales = menu.filter(item => item.tipo === 'principal');
  res.json(principales);
});

app.get('/postres', (req, res) => {
  const postres = menu.filter(item => item.tipo === 'postre');
  res.json(postres);
});

app.post('/pedido', (req, res) => {
  const pedidoItems = req.body.productos;

  if (!Array.isArray(pedidoItems) || pedidoItems.length === 0) {
    res.status(400).json({ mensaje: 'El cuerpo de la solicitud debe contener un array de productos' });
    return;
  }

  let pedidoTotal = 0;
  pedidoItems.forEach(item => {
    const plato = menu.find(menuItem => menuItem.id === parseInt(item.id));
    if (plato) {
      pedidoTotal += plato.precio * parseInt(item.cantidad);
    }
  });

  if (pedidoTotal === 0) {
    res.status(404).json({ mensaje: 'No se encontraron platos válidos en el pedido' });
    return;
  }

  res.json({ msg: 'Pedido recibido', precio: pedidoTotal });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ mensaje: 'Error interno del servidor' });
});

app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});
