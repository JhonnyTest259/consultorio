const { db } = require("../config/admin");

const getData = async (req, res) => {
    const solRef = db.collection('solicitudes');
    try{
            solRef.get().then((snapshot) => {
            const data = snapshot.docs.map((doc) => ({
            uid: doc.get('uid'),
            estado: doc.get('estado'),
            nombre: doc.get('nombre'),
            //...doc.data(),
        }));
            //console.log(data);
            return res.status(201).json(data);
        })
    } catch (error) {
        return res
        .status(500)
        .json({ general: "Something went wrong, please try again"});          
    }
};

const putData = async(req, res)=>{
    const cod = req.params.codigo;
    const estado = req.params.estado;
    const solRef = db.collection('solicitudes').doc(cod);
    //console.log(cod);
    try {
        const data = await solRef.update({
            estado: estado,
        });
        return res.status(200).json(data);
        
    } catch (error) {
        return res
        .status(400)
        .json({ general: "Invalid request"}); 
    }
}


module.exports = {
    getData,
    putData
};