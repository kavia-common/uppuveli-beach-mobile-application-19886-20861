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
  const [detailsOpen, setDetailsOpen] = useState(false);
  const [errorDetails, setErrorDetails] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  const [params] = useSearchParams();

  const extractToken = (data) => data?.token || data?.data?.token;

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setDetailsOpen(false);
    setErrorDetails("");
    setLoading(true);
    try {
      // Primary attempt: JSON /auth/login
      const res = await api.post(endpoints.login, { email, password });
      const token = extractToken(res.data);
      if (!token) throw new Error("Invalid login response");
      localStorage.setItem("authToken", token);
      const next = params.get("next") || "/bookings";
      navigate(next);
      return;
    } catch (err1) {
      // If endpoint mismatch or method not allowed, try OAuth2 password token flow as fallback
      const status = err1?.response?.status;
      const shouldFallback =
        status === 404 || status === 405 || status === 415 || status === 400 || typeof status === "undefined";
      // Capture error details for console and optional UI details
      const backendMsg = err1?.response?.data?.message || err1?.response?.data?.detail || err1?.message || "Login failed";
      setError(`Login failed: ${backendMsg}`);
      setErrorDetails(JSON.stringify(err1?.response?.data || { message: err1?.message }, null, 2));
      console.error("Login error (primary /auth/login):", err1);

      if (shouldFallback) {
        try {
          // form-encoded: username/password per OAuth2PasswordRequestForm
          const params = new URLSearchParams();
          params.append("username", email);
          params.append("password", password);
          const res2 = await api.post(endpoints.token, params, {
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
          });
          // Accept either {access_token, token_type} or same wrapped format
          const token =
            extractToken(res2.data) ||
            res2.data?.access_token ||
            res2.data?.data?.access_token;
          if (!token) throw new Error("Invalid token response");
          localStorage.setItem("authToken", token);
          const next = (new URLSearchParams(window.location.search)).get("next") || "/bookings";
          navigate(next);
          return;
        } catch (err2) {
          const backendMsg2 = err2?.response?.data?.message || err2?.response?.data?.detail || err2?.message || "Login failed";
          setError(`Login failed: ${backendMsg2}`);
          setErrorDetails(JSON.stringify(err2?.response?.data || { message: err2?.message }, null, 2));
          console.error("Login error (fallback /auth/token):", err2);
        }
      }
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
            autoComplete="username"
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
            autoComplete="current-password"
          />
        </div>
        {error && (
          <div style={{ color: "red", marginBottom: 12 }}>
            {error}
            {errorDetails && (
              <div style={{ marginTop: 8 }}>
                <button
                  type="button"
                  className="btn"
                  onClick={() => setDetailsOpen((v) => !v)}
                  style={{ background: "#6c757d" }}
                >
                  {detailsOpen ? "Hide details" : "Show details"}
                </button>
                {detailsOpen && (
                  <pre style={{ whiteSpace: "pre-wrap", background: "#f8f9fa", padding: 8, borderRadius: 6, marginTop: 8 }}>
                    {errorDetails}
                  </pre>
                )}
              </div>
            )}
          </div>
        )}
        <button className="btn" type="submit" disabled={loading} style={{ width: "100%", padding: 10 }}>
          {loading ? "Signing in..." : "Login"}
        </button>
        <div style={{ marginTop: 12, color: "#6c757d", fontSize: 12 }}>
          Ensure backend CORS allows http://localhost:3000 and REACT_APP_API_BASE_URL includes /api/v1.
        </div>
      </form>
    </div>
  );
}
