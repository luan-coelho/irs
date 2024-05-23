import React, { useState } from "react";

function MessageForm({ setMessages }) {
  const [content, setContent] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    let ip = "18.229.164.142";
    fetch(`http://${ip}:5000/api/messages`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ content }),
    })
      .then((response) => response.json())
      .then((message) => {
        setMessages((messages) => [...messages, message]);
        setContent("");
      })
      .catch((error) => console.error("Error posting message:", error));
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="Type a message"
      />
      <button type="submit">Send</button>
    </form>
  );
}

export default MessageForm;
