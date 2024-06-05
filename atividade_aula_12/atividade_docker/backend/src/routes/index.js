const express = require("express");
const router = express.Router();
const Message = require("../models/Message");

// Get all messages
router.get("/", async (req, res) => {
  try {
    res.json({ message: "Server running and accepting requests" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
