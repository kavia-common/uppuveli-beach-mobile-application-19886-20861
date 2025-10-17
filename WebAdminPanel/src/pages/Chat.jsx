import { useEffect, useState } from "react";
import api from "../api/client";
import { endpoints } from "../api/endpoints";
import NavBar from "../components/NavBar";

// PUBLIC_INTERFACE
export default function Chat() {
  /** Simple chat page: lists recent messages and can send a message */
  const [messages, setMessages] = useState([]);
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(true);

  const load = async () => {
    setLoading(true);
    try {
      const res = await api.get(endpoints.chat);
      const data = Array.isArray(res.data?.data) ? res.data.data : (Array.isArray(res.data) ? res.data : res.data?.data?.items || []);
      setMessages(data);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, []);

  const send = async (e) => {
    e.preventDefault();
    if (!message.trim()) return;
    try {
      const res = await api.post(endpoints.chat, { message });
      const saved = res.data?.data || res.data;
      setMessages((prev) => [...prev, saved]);
      setMessage("");
    } catch (e2) {
      alert(e2?.response?.data?.message || "Send failed");
    }
  };

  return (
    <>
      <NavBar />
      <div style={{ padding: 16, maxWidth: 800, margin: "0 auto" }}>
        <h2>Chat</h2>
        <div style={{ border: "1px solid #e9ecef", borderRadius: 8, padding: 12, minHeight: 300, marginBottom: 12 }}>
          {loading ? "Loading..." : (
            <ul style={{ listStyle: "none", padding: 0, margin: 0 }}>
              {messages.map((m) => (
                <li key={m.id || m.timestamp} style={{ padding: "6px 0", borderBottom: "1px solid #f1f3f5" }}>
                  <div style={{ fontSize: 12, color: "#666" }}>{m.timestamp || ""}</div>
                  <div><strong>{m.senderId || "system"}:</strong> {m.message}</div>
                </li>
              ))}
              {messages.length === 0 && <li>No messages yet</li>}
            </ul>
          )}
        </div>
        <form onSubmit={send} style={{ display: "flex", gap: 8 }}>
          <input value={message} onChange={(e) => setMessage(e.target.value)} placeholder="Type a message..." style={{ flex: 1, padding: 8 }} />
          <button className="btn" type="submit">Send</button>
        </form>
      </div>
    </>
  );
}
