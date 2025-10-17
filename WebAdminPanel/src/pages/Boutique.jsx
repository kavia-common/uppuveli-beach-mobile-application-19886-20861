import { useEffect, useState } from "react";
import api from "../api/client";
import { endpoints, withId } from "../api/endpoints";
import NavBar from "../components/NavBar";

// PUBLIC_INTERFACE
export default function Boutique() {
  /** CRUD for boutique items */
  const [items, setItems] = useState([]);
  const [form, setForm] = useState({ name: "", description: "", price: 0, stock: 0 });
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(true);

  const load = async () => {
    setLoading(true);
    try {
      const res = await api.get(endpoints.boutique);
      const data = Array.isArray(res.data?.data) ? res.data.data : (Array.isArray(res.data) ? res.data : res.data?.data?.items || []);
      setItems(data);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { load(); }, []);

  const submit = async (e) => {
    e.preventDefault();
    try {
      if (editingId) {
        await api.put(withId(endpoints.boutique, editingId), form);
      } else {
        await api.post(endpoints.boutique, form);
      }
      setForm({ name: "", description: "", price: 0, stock: 0 });
      setEditingId(null);
      load();
    } catch (e2) {
      alert(e2?.response?.data?.message || "Save failed");
    }
  };

  const edit = (row) => {
    setEditingId(row.id);
    setForm({ name: row.name || "", description: row.description || "", price: row.price || 0, stock: row.stock || 0 });
  };

  const remove = async (id) => {
    if (!window.confirm("Delete this item?")) return;
    try {
      await api.delete(withId(endpoints.boutique, id));
      load();
    } catch (e) {
      alert(e?.response?.data?.message || "Delete failed");
    }
  };

  return (
    <>
      <NavBar />
      <div style={{ padding: 16 }}>
        <h2>Boutique</h2>

        <form onSubmit={submit} style={{ marginBottom: 16, border: "1px solid #e9ecef", padding: 12, borderRadius: 8 }}>
          <h3 style={{ marginTop: 0 }}>{editingId ? "Edit Item" : "Create Item"}</h3>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: 12 }}>
            <div>
              <label>Name</label>
              <input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} required style={{ width: "100%" }} />
            </div>
            <div>
              <label>Price</label>
              <input type="number" step="0.01" value={form.price} onChange={(e) => setForm({ ...form, price: Number(e.target.value) })} required style={{ width: "100%" }} />
            </div>
            <div style={{ gridColumn: "1 / span 2" }}>
              <label>Description</label>
              <textarea rows="3" value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} style={{ width: "100%" }} />
            </div>
            <div>
              <label>Stock</label>
              <input type="number" value={form.stock} onChange={(e) => setForm({ ...form, stock: Number(e.target.value) })} required style={{ width: "100%" }} />
            </div>
          </div>
          <div style={{ marginTop: 12, display: "flex", gap: 8 }}>
            <button className="btn" type="submit">{editingId ? "Update" : "Create"}</button>
            {editingId && <button className="btn" type="button" onClick={() => { setEditingId(null); setForm({ name: "", description: "", price: 0, stock: 0 }); }}>Cancel</button>}
          </div>
        </form>

        {loading ? <div>Loading...</div> : (
          <div style={{ overflowX: "auto" }}>
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>ID</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Name</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Price</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Stock</th>
                  <th style={{ borderBottom: "1px solid #e9ecef" }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {items.map((row) => (
                  <tr key={row.id}>
                    <td>{row.id}</td>
                    <td>{row.name}</td>
                    <td>{row.price}</td>
                    <td>{row.stock}</td>
                    <td>
                      <button className="btn" onClick={() => edit(row)} style={{ marginRight: 8 }}>Edit</button>
                      <button className="btn" onClick={() => remove(row.id)}>Delete</button>
                    </td>
                  </tr>
                ))}
                {items.length === 0 && <tr><td colSpan="5" style={{ textAlign: "center", padding: 12 }}>No items found</td></tr>}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </>
  );
}
