const menu = require('./menu.json');
const express = require('express');
const cors = require("cors");
const app = express();
const port = 3000;
const mysql = require('mysql2');
const { json } = require('express');
const bcrypt = require('bcrypt');
const connection = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "rootroot",
  database: "burguertic"
});

app.use(express.json());
app.use(cors());

app.get('/menu', (req, res) => {
  connection.query("SELECT * FROM platos", (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    } else {
      res.json(rows);
    }
  })
});

app.get('/menu/:id', (req, res) => {
  const id = parseInt(req.params.id);
  connection.query("SELECT * FROM platos WHERE id = ?", [id], (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    } else {
      res.json(rows);
    }
  })
});

app.get('/combos', (req, res) => {
  connection.query("SELECT * FROM platos WHERE tipo = 'combo'", (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    } else {
      res.json(rows);
    }
  })
});

app.get('/principales', (req, res) => {
  connection.query("SELECT * FROM platos WHERE tipo = 'principal'", (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    } else {
      res.json(rows);
    }
  })
});

app.get('/postres', (req, res) => {
  connection.query("SELECT * FROM platos WHERE tipo = 'postre'", (err, rows) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
    } else {
      res.json(rows);
    }
  })
});

app.post('/pedido', (req, res) => {
  
  const{ productos } = req.body;
  const fecha = new Date();
  let insertPedidos = "INSERT INTO pedidos (id_usuario, fecha, estado) VALUES (1, ?, 'pendiente')";
  connection.query(insertPedidos, [fecha], (err, result) => {
    if (err) {
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
      return;
    }
    const insertId = result.insertId;
    let queryInsert = "INSERT INTO pedidos_platos (id_pedido, id_plato, cantidad) VALUES ";
    let values = [];
    productos.forEach((item, i) => {
      if (i != productos.length - 1)
      {
        queryInsert += "(?,?,?), ";
        values.push(insertId, item.id, item.cantidad);
      }
      else
      {
        queryInsert += "(?,?,?)";
        values.push(insertId, item.id, item.cantidad);
      }

    })
    connection.query(queryInsert, values, (err, result1) => {
      res.json({"id: ": insertId});
    }) 

  })

});

app.get("/pedidos/:id", (req, res) => {
  const id = req.params.id;
  let result = {};
  connection.query("SELECT * FROM pedidos INNER JOIN pedidos_platos ON pedidos.id = pedidos_platos.id_pedido INNER JOIN platos ON platos.id = pedidos_platos.id_plato WHERE id_usuario = ?", [id], (err, rows) => { //arreglar
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'Error en la consulta a la base de datos' });
      return;
    }
      const pedidosUnicos = [];

      rows.forEach(fila => {
        const pedidoExistente = pedidosUnicos.find(pedido => pedido.id === fila.id_pedido);
 
        if (!pedidoExistente) {
          pedidosUnicos.push({
            id: fila.id_pedido,
            fecha: fila.fecha,
            estado: fila.estado,
            id_usuario: fila.id_usuario,
            platos: [{
              id: fila.id_plato,
              nombre: fila.nombre_plato,
              precio: fila.precio,
              cantidad: fila.cantidad
            }]
          });
        } else {
          pedidoExistente.platos.push({
            id: fila.id_plato,
            nombre: fila.nombre_plato,
            precio: fila.precio,
            cantidad: fila.cantidad
          });
        }
      });
 
      res.json(pedidosUnicos);
    });
  });

  app.post("/usuarios", (req, res) => {
    console.log("Ok");
    const usuario = req.body;
    let contrasena = usuario.password;

    if (!usuario.password || !usuario.email || !usuario.apellido || !usuario.nombre){
      res.status(400).json({error:"El usuario no es valido"});
    }
    contrasena = bcrypt.hashSync(contrasena, 15);
    connection.query("INSERT INTO usuarios (nombre, apellido, email, password) VALUES (?, ?, ?, ?)", [usuario.nombre, usuario.apellido, usuario.email, contrasena], (err, result) => {
      if(err){
        res.status(500).json({error:"Error del servidor"});
      }
        resultID = result.insertId;
        res.json({"id": resultID});
    })
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ mensaje: 'Error interno del servidor' });
});

app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});
