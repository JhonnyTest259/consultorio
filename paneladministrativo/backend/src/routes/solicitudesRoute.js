const {Router} = require('express');
const router = Router();


const { getData, putData, getOne } = require('../controllers/solicitudesController');

router.get('/api/solicitudes', getData);
router.get('/api/solicitudes/:codigo',getOne);
router.put('/api/solicitudes/uid/:codigo/estado/:estado',putData);

module.exports = router;