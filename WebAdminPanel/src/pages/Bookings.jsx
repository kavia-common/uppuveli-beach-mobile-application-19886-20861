import { useEffect, useState } from "react";
import api from "../api/client";
import { endpoints, withId } from "../api/endpoints";
import NavBar from "../components/NavBar";

// PUBLIC_INTERFACE
export default function Bookings() {
  /** CRUD UI for bookings: list, create, update, delete */
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [form, setForm] = useState({ guestName: "", roomNumber: "", checkIn: "", checkOut: "", status: "booked" });
  const [editingId, setEditingId] = useState(null);

  const fetchBookings = async () => {
    setLoading(true);
    setError("");
    try {
      const res = await api.get(endpoints.bookings);
      const data = Array.isArray(res.data?.data) ? res.data.data : (Array.isArray(res.data) ? res.data : res.data?.data?.items || []);
      setBookings(data);
    } catch (e) {
      setError(e?.response?.data?.message || "Failed to load bookings");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchBookings();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (editingId) {
        await api.put(withId(endpoints.bookings, editingId), form);
      } else {
        await api.post(endpoints.bookings, form);
      }
      setForm({ guestName: "", roomNumber: "", checkIn: "", checkOut: "", status: "booked" });
      setEditingId(null);
      fetchBookings();
    } catch (e) {
      alert(e?.response?.data?.message || "Save failed");
    }
  };

  const handleEdit = (b) => {
    setEditingId(b.id);
    setForm({
      guestName: b.guestName || "",
      roomNumber: b.roomNumber || "",
      checkIn: (b.checkIn || "").slice(0, 10),
      checkOut: (b.checkOut || "").slice(0, 10),
      status: b.status || "booked",
    });
    window.scrollTo(0, 0);
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Delete this booking?")) return;
    try {
      await api.delete(withId(endpoints.bookings, id));
      fetchBookings();
    } catch (e) {
      alert(e?.response?.data?.message || "Delete failed");
    }
  };

  return (
    <>
      <NavBar />
      <div style={{ padding: 16 }}>
        <h2>Bookings</h2>

        <form onSubmit={handleSubmit} style={{ marginBottom: 16, border: "1px solid #e9ecef", padding: 12, borderRadius: 8 }}>
          <h3 style={{ marginTop: 0 }}>{editingId ? "Edit Booking" : "Create Booking"}</h3>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: 12 }}>
            <div>
              <label>Guest Name</label>
              <input value={form.guestName} onChange={(e) => setForm({ ...form, guestName: e.target.value })} required style={{ width: "100%" }} />
            </div>
            <div>
              <label>Room Number</label>
              <input value={form.roomNumber} onChange={(e) => setForm({ ...form, roomNumber: e.target.value })} required style={{ width: "100%" }} />
            </div>
            <div>
              <label>Check-in</label>
              <input type="date" value={form.checkIn} onChange={(e) => setForm({ ...form, checkIn: e.target.value })} required style={{ width: "100%" }} />
            </div>
            <div>
              <label>Check-out</label>
              <input type="date" value={form.checkOut} onChange={(e) => setForm({ ...form, checkOut: e.target.value })} required style={{ width: "100%" }} />
            </div>
            <div>
              <label>Status</label>
              <select value={form.status} onChange={(e) => setForm({ ...form, status: e.target.value })} style={{ width: "100%" }}>
                <option value="booked">booked</option>
                <option value="checked_in">checked_in</option>
                <option value="checked_out">checked_out</option>
                <option value="cancelled">cancelled</option>
              </select>
            </div>
          </div>
          <div style={{ marginTop: 12, display: "flex", gap: 8 }}>
            <button className="btn" type="submit">{editingId ? "Update" : "Create"}</button>
            {editingId && <button className="btn" type="button" onClick={() => { setEditingId(null); setForm({ guestName: "", roomNumber: "", checkIn: "", checkOut: "", status: "booked" }); }}>Cancel</button>}
          </div>
        </form>

        {loading ? <div>Loading...</div> : error ? <div style={{ color: "red" }}>{error}</div> : (
          <div style={{ overflowX: "auto" }}>
            <table style={{ width: "100%", borderCollapse: "collapse" }}>
              <thead>
                <tr>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>ID</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Guest</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Room</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Check-in</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Check-out</th>
                  <th style={{ borderBottom: "1px solid #e9ecef", textAlign: "left" }}>Status</th>
                  <th style={{ borderBottom: "1px solid #e9ecef" }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {bookings.map((b) => (
                  <tr key={b.id}>
                    <td>{b.id}</td>
                    <td>{b.guestName}</td>
                    <td>{b.roomNumber}</td>
                    <td>{(b.checkIn || "").slice(0, 10)}</td>
                    <td>{(b.checkOut || "").slice(0, 10)}</td>
                    <td>{b.status}</td>
                    <td>
                      <button className="btn" onClick={() => handleEdit(b)} style={{ marginRight: 8 }}>Edit</button>
                      <button className="btn" onClick={() => handleDelete(b.id)}>Delete</button>
                    </td>
                  </tr>
                ))}
                {bookings.length === 0 && (
                  <tr><td colSpan="7" style={{ textAlign: "center", padding: 12 }}>No bookings found</td></tr>
                )}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </>
  );
}
