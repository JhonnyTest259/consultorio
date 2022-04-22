const {Router} = require('express');
const router = Router();

router.get('/', (req, res) => {
    res.send('Este es el back del consultorio');
});

module.exports = router;