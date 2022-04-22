const {Router} = require('express');
const router = Router();


const { getData, putData } = require('../controllers/solicitudesController');

router.get('/api/solicitudes', getData);
router.put('/api/solicitudes/uid/:codigo/estado/:estado',putData);

module.exports = router;