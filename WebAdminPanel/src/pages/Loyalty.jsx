import { useEffect, useState } from "react";
import api from "../api/client";
import { endpoints, withId } from "../api/endpoints";
import NavBar from "../components/NavBar";

// PUBLIC_INTERFACE
export default function Loyalty() {
  /** List loyalty accounts and allow updating points/tier */
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(null);
  const [form, setForm] = useState({ points: 0, tier: "Bronze" });

  const load = async () => {
    setLoading(true);
    try {
      const res = await api.get(endpoints.loyalty);
      const data = Array.isArray(res.data?.data) ? res.data.data : (Array.isArray(res.data) ? res.data : res.data?.data?.items || []);
      setItems(data);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, []);

  const startEdit = (row) => {
    setEditing(row.id);
    setForm({ points: row.points ?? 0, tier: row.tier || "Bronze" });
  };

  const save = async () => {
    if (!editing) return;
    try {
      await api.put(withId(endpoints.loyalty, editing), form);
      setEditing(null);
      load();
    } catch (e) {
      alert(e?.response?.data?.message || "Update failed");
    }
  };

  return (
    <>
      <NavBar />
      <div style={{ padding: 16 }}>
        <h2>Loyalty</h2>
        {loading ? <div>Loading...</div> : (
          <div style={{ overflowX: "auto" }}>
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>ID</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Guest ID</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Points</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Tier</th>
                  <th style={{ borderBottom: "1px solid #e9ecef" }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {items.map((row) => (
                  <tr key={row.id}>
                    <td>{row.id}</td>
                    <td>{row.guestId}</td>
                    <td>
                      {editing === row.id ? (
                        <input type="number" value={form.points} onChange={(e) => setForm({ ...form, points: Number(e.target.value) })} />
                      ) : row.points}
                    </td>
                    <td>
                      {editing === row.id ? (
                        <select value={form.tier} onChange={(e) => setForm({ ...form, tier: e.target.value })}>
                          <option>Bronze</option>
                          <option>Silver</option>
                          <option>Gold</option>
                          <option>Platinum</option>
                        </select>
                      ) : row.tier}
                    </td>
                    <td>
                      {editing === row.id ? (
                        <>
                          <button className="btn" onClick={save} style={{ marginRight: 8 }}>Save</button>
                          <button className="btn" onClick={() => setEditing(null)}>Cancel</button>
                        </>
                      ) : (
                        <button className="btn" onClick={() => startEdit(row)}>Edit</button>
                      )}
                    </td>
                  </tr>
                ))}
                {items.length === 0 && <tr><td colSpan="5" style={{ textAlign: "center", padding: 12 }}>No loyalty accounts found</td></tr>}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </>
  );
}
