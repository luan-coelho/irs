import React, { useState } from "react";

function MessageForm({ setMessages }) {
  const [content, setContent] = useState("");

  const handleSubmit = (event) => {
    const baseUrl = process.env.REACT_APP_API_BASE_URL;
    fetch(`${baseUrl}/api/messages`, {
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
