const firebase = require('firebase');

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyD5fGvAhMbbAL-yPzjlHbDa44LEC-bn0Kg",
  authDomain: "consultorio-39ee2.firebaseapp.com",
  projectId: "consultorio-39ee2",
  storageBucket: "consultorio-39ee2.appspot.com",
  messagingSenderId: "829658588099",
  appId: "1:829658588099:web:4b042cff3b6d2cb6f11376"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
module.exports = {firebase}; //export the app