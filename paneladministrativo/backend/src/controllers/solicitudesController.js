const { db } = require("../config/admin");

const getData = async (req, res) => {
    const solRef = db.collection('solicitudes').orderBy("creado", "desc");
    try {
        solRef.get().then((snapshot) => {
            const data = snapshot.docs.map((doc) => ({
                /*   uid: doc.get('uid'),
                  estado: doc.get('estado'),
                  nombre: doc.get('nombre'), */
                ...doc.data(),
            }));
            //console.log(data);
            return res.status(201).json(data);
        })
    } catch (error) {
        return res
            .status(500)
            .json({ general: "Something went wrong, please try again" });
    }
};

const getOne = async (req, res) => {
    const cod = req.params.codigo;
    const solRef = db.collection('solicitudes').doc(cod);
    try {

        solRef.get().then((snapshot) => {
            const data = snapshot.data();

            const sol = {
                'uid': data.uid,
                'nombre': data.nombre,
                'salario': data.salario,
                'edad': data.edad,
                'identificacion': data.identificacion,
                'email': data.email,
                'barrio': data.barrio,
                'telefono': data.telefono,
                'estadoCivil': data.estadoCivil,
                'direccionCasa': data.direccionCasa,
                'direccionTrabajo': data.direccionTrabajo,
                'descripcionConsulta': data.descripcion,
            }

            if (!data == null) {
                console.log('No such document!');
            } else {
                return res.status(201).json(sol);
            }

        });

        /*   const doc = await solRef.get();
          
          if (!doc.exists) {
            console.log('No such document!');
          } else {
            return res.status(201).json(doc.data());
          } */

    } catch (error) {
        return res
            .status(500)
            .json({ general: "Something went wrong, please try again" });
    }
};
const putData = async (req, res) => {
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
            .json({ general: "Invalid request" });
    }
}


module.exports = {
    getData,
    putData,
    getOne
};