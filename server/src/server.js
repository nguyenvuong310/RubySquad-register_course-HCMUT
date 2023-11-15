require("dotenv").config();
const express = require("express");
const cors = require("cors");
const initWebRoutes = require("./routes/web");
const cookieSession = require("cookie-session");
import viewEngine from "./config/viewEngine";

import initializeDatabase from "./Database/initalizeDatabase";
import bodyParser from "body-parser";
const app = express();

app.use(
  cookieSession({
    name: "session",
    keys: ["cyberwolve"],
    maxAge: 24 * 60 * 60 * 100,
  })
);

// app.use(passport.initialize());
// app.use(passport.session());

app.use(
  cors({
    origin: "http://localhost:3000",
    methods: "GET,POST,PUT,DELETE",
    credentials: true,
  })
);
// bodyParser giup lay data tu client to server
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
viewEngine(app);
initWebRoutes(app);
//database

initializeDatabase();

const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`Listenting on port ${port}...`));
