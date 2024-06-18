'use strict'

   
// Copyright By Ilman Sunanuddin, M pedia
// Email : Ilmansunannudin2@gmail.com 
// website : https://m-pedia.co.id
// Whatsap : 6282298859671
// ------------------------------------------------------------------
// You are not allowed to share or sell this source code without permission.

const wa = require("./server/whatsapp");

require('dotenv').config()
const lib = require('./server/lib')
global.log = lib.log

/**
 * EXPRESS FOR ROUTING
 */
const express = require('express')
const app = express()
const http = require('http')
const server = http.createServer(app)

/**
 * SOCKET.IO
 */
const {Server} = require('socket.io');
const io = new Server(server)
const port = process.env.PORT_NODE
app.use((req, res, next) => {
    res.set('Cache-Control', 'no-store')
    req.io = io
    // res.set('Cache-Control', 'no-store')
    next()
})


const bodyParser = require('body-parser')

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false,limit: '50mb',parameterLimit: 100000 }))
// parse application/json
app.use(bodyParser.json())
app.use(express.static('src/public'))
app.use(require('./server/router'))

// console.log(process.argv)

// Global unhandled rejection handler
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

io.on('connection', (socket) => {
  socket.on('StartConnection', (data) => {
      wa.connectToWhatsApp(data, io).catch(err => {
          console.error('Error connecting to WhatsApp:', err);
      });
  })
  socket.on('LogoutDevice', (device) => {
      wa.deleteCredentials(device, io).catch(err => {
          console.error('Error logging out device:', err);
      });
  })
})

server.listen(port, () => console.log(`Server running and listening on port: ${port}`));


// Improve error handling inside the library
try {
  // Assume wa.connectToWhatsApp and wa.deleteCredentials are asynchronous functions
  wa.connectToWhatsApp().catch((err) => {
      console.error('WhatsApp Connection Error:', err);
  });

  wa.deleteCredentials().catch((err) => {
      console.error('WhatsApp Logout Error:', err);
  });
} catch (err) {
  console.error('Unexpected Error:', err);
}