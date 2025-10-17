import { useState } from "react";
import { useNavigate, useSearchParams } from "react-router-dom";
import api from "../api/client";
import { endpoints } from "../api/endpoints";

// PUBLIC_INTERFACE
export default function Login() {
  /** Minimal login form that authenticates admin and stores JWT token. */
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [params] = useSearchParams();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setLoading(true);
    try {
      const res = await api.post(endpoints.login, { email, password });
      // Support both {token} and {status:'success',data:{token}}
      const token = res.data?.token || res.data?.data?.token;
      if (!token) {
        throw new Error("Invalid login response");
      }
      localStorage.setItem("authToken", token);
      const next = params.get("next") || "/bookings";
      navigate(next);
    } catch (err) {
      setError(err?.response?.data?.message || "Login failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ maxWidth: 360, margin: "80px auto", padding: 24, border: "1px solid #e9ecef", borderRadius: 8 }}>
      <h2 style={{ marginTop: 0 }}>Admin Login</h2>
      <form onSubmit={handleSubmit}>
        <div style={{ marginBottom: 12 }}>
          <label htmlFor="email">Email</label>
          <input
            id="email"
            type="email"
            placeholder="admin@example.com"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            style={{ width: "100%", padding: 8, marginTop: 4 }}
          />
        </div>
        <div style={{ marginBottom: 12 }}>
          <label htmlFor="password">Password</label>
          <input
            id="password"
            type="password"
            placeholder="••••••••"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            style={{ width: "100%", padding: 8, marginTop: 4 }}
          />
        </div>
        {error && <div style={{ color: "red", marginBottom: 12 }}>{error}</div>}
        <button className="btn" type="submit" disabled={loading} style={{ width: "100%", padding: 10 }}>
          {loading ? "Signing in..." : "Login"}
        </button>
      </form>
    </div>
  );
}
