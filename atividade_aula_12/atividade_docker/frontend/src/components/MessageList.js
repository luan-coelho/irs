import React from "react";

function MessageList({ messages }) {
  return (
    <div>
      <ul>
        {messages.map((message) => (
          <li key={message._id}>
            {message.content} - {new Date(message.createdAt).toLocaleString()}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default MessageList;
