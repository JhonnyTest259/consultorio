
var admin = require("firebase-admin");

var serviceAccount = require("./consultorio-39ee2-firebase-adminsdk-cei3q-74bb0d5e83.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
module.exports = {admin, db};
