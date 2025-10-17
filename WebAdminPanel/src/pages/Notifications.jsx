import { useState } from "react";
import api from "../api/client";
import { endpoints } from "../api/endpoints";
import NavBar from "../components/NavBar";

// PUBLIC_INTERFACE
export default function Notifications() {
  /** Form to send notifications to a recipient or broadcast */
  const [form, setForm] = useState({ type: "info", message: "", recipientId: "" });
  const [status, setStatus] = useState("");

  const submit = async (e) => {
    e.preventDefault();
    setStatus("");
    try {
      await api.post(endpoints.notifications, form);
      setStatus("Notification sent");
      setForm({ type: "info", message: "", recipientId: "" });
    } catch (e2) {
      setStatus(e2?.response?.data?.message || "Failed to send");
    }
  };

  return (
    <>
      <NavBar />
      <div style={{ padding: 16, maxWidth: 640, margin: "0 auto" }}>
        <h2>Send Notification</h2>
        <form onSubmit={submit} style={{ border: "1px solid #e9ecef", padding: 12, borderRadius: 8 }}>
          <div style={{ marginBottom: 12 }}>
            <label>Type</label>
            <select value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} style={{ width: "100%" }}>
              <option value="info">info</option>
              <option value="promo">promo</option>
              <option value="alert">alert</option>
            </select>
          </div>
          <div style={{ marginBottom: 12 }}>
            <label>Message</label>
            <textarea rows="4" value={form.message} onChange={(e) => setForm({ ...form, message: e.target.value })} style={{ width: "100%" }} required />
          </div>
          <div style={{ marginBottom: 12 }}>
            <label>Recipient ID (leave empty for broadcast if supported)</label>
            <input value={form.recipientId} onChange={(e) => setForm({ ...form, recipientId: e.target.value })} style={{ width: "100%" }} />
          </div>
          <button className="btn" type="submit">Send</button>
          {status && <div style={{ marginTop: 12 }}>{status}</div>}
        </form>
      </div>
    </>
  );
}
