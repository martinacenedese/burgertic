const mysql = require("mysql2");
const menu = require('./menu.json');
const connection = mysql.createConnection({
    host:"localhost",
    user: "root",
    password: "rootroot",
    database: "burguertic"
});
menu.forEach((item) => {
    const insertQuery = 'INSERT INTO platos (nombre, tipo, precio, descripcion) VALUES (?, ?, ?, ?)';
    const values = [item.nombre, item.tipo, item.precio, item.descripcion];
    connection.query(insertQuery, values, (insertError, insertResults) => {
      if (insertError) {
        console.error('Error al insertar un registro:', insertError);
      } else {
        console.log('Registro insertado exitosamente:', insertResults);
      }
    });
});
connection.end();
