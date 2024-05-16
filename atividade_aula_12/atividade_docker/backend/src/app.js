const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const messageRoutes = require("./routes/messages");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/messages", messageRoutes);

module.exports = app;
