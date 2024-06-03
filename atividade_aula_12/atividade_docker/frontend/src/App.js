import React, { useEffect, useState } from "react";
import MessageForm from "./components/MessageForm";
import MessageList from "./components/MessageList";

function App() {
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    const baseUrl = process.env.REACT_APP_API_BASE_URL;
    fetch(`${baseUrl}/api/messages`)
      .then((response) => response.json())
      .then((data) => setMessages(data))
      .catch((error) => console.error("Error fetching messages:", error));
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Internal Communication App</h1>
      </header>
      <MessageForm setMessages={setMessages} />
      <MessageList messages={messages} />
    </div>
  );
}

export default App;
