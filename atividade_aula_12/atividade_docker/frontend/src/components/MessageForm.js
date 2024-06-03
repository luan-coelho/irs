import React, { useState } from "react";

function MessageForm({ setMessages }) {
  const [content, setContent] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();

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
      <div>
        <input
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          type="text"
          value={content}
          onChange={(e) => setContent(e.target.value)}
          placeholder="Type a message"
        />
        <div className="flex justify-end mt-2">
          <button
            className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
            type="submit"
          >
            Send
          </button>
        </div>
      </div>
    </form>
  );
}

export default MessageForm;
