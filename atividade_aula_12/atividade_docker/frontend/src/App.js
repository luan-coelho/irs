import React, { useEffect, useState } from "react";
import MessageForm from "./components/MessageForm";
import MessageList from "./components/MessageList";
import "./index.css";

function App() {
  const [messages, setMessages] = useState([]);
  const [baseUrl, setBaseUrl] = useState('');

  const fetchEnvVariables = async () => {
    try {
      const response = await fetch('/config.js');
      const text = await response.text();
      const regex = /REACT_APP_API_BASE_URL:\s*"([^"]+)"/;
      const match = text.match(regex);
      if (match) {
        const apiUrl = match[1];
        console.log(apiUrl);
        setBaseUrl(apiUrl);
      }
    } catch (error) {
      console.error("Error loading config:", error);
    }
  };

  useEffect(() => {
    fetchEnvVariables();

    if (baseUrl) {
      fetch(`${baseUrl}/api/messages`)
        .then((response) => response.json())
        .then((data) => setMessages(data))
        .catch((error) => console.error("Error fetching messages:", error));
    }
  }, [baseUrl]);

  return (
    <div className="App w-full h-screen bg-gray-100">
      <div className="container mx-auto p-3">
        <header className="text-center mb-6">
          <h1 className="text-3xl font-semibold text-gray-800">Internal Communication App</h1>
        </header>
        <div className="bg-white shadow-md rounded-lg p-6">
          <MessageForm setMessages={setMessages} />
        </div>
        <div className="mt-6">
          <MessageList messages={messages} />
        </div>
      </div>
    </div>
  );
}

export default App;
