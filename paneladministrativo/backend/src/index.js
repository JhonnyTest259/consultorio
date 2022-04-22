const express = require('express');
const cors = require('cors');
const app = express();

app.use(express.urlencoded({extended: true}));
app.unsubscribe(express.json());
app.use(cors());
app.set('json spaces', 4);


app.set('port', process.env.PORT || 8090);
app.use(require('./routes/index'));
app.use(require('./routes/solicitudesRoute'));

app.listen(app.get('port'), function(){
    console.log('Escuchando por el puerto', app.get('port'));
});