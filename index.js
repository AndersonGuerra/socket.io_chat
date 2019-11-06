var app = require('express')();
var http = require('http').createServer(app);
var io = require('socket.io')(http);

var port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
})

io.on('connection', (socket) => {
    console.log('alguem logou');
    socket.on('chat message', (msg) => {
        console.log(port);

        io.emit('chat message', msg);
    });
    socket.on('disconnect', () => {
        console.log('usuario desconectado');
    });
});


http.listen(port, () => {
    console.log("Ouvindo na porta " + port);
});