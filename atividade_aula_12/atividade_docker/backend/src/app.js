const express = require("express");
const cors = require("cors");
const index = require("./routes/index");
const messageRoutes = require("./routes/messages");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/", index);
app.use("/api/messages", messageRoutes);

module.exports = app;
