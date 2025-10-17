import React, { useEffect, useState } from "react";
import { BrowserRouter, Navigate, Route, Routes, useLocation } from "react-router-dom";
import "./App.css";
import Login from "./pages/Login";
import Bookings from "./pages/Bookings";
import Loyalty from "./pages/Loyalty";
import Boutique from "./pages/Boutique";
import Notifications from "./pages/Notifications";
import Chat from "./pages/Chat";

// Protect routes that require auth
function ProtectedRoute({ children }) {
  const token = localStorage.getItem("authToken");
  const location = useLocation();
  if (!token) {
    return <Navigate to={`/login?next=${encodeURIComponent(location.pathname + location.search)}`} replace />;
  }
  return children;
}

// PUBLIC_INTERFACE
function App() {
  const [theme, setTheme] = useState("light");
  useEffect(() => {
    document.documentElement.setAttribute("data-theme", theme);
  }, [theme]);

  return (
    <div className="App">
      <BrowserRouter>
        <button
          className="theme-toggle"
          onClick={() => setTheme((t) => (t === "light" ? "dark" : "light"))}
          aria-label={`Switch to ${theme === "light" ? "dark" : "light"} mode`}
        >
          {theme === "light" ? "🌙 Dark" : "☀️ Light"}
        </button>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route
            path="/bookings"
            element={
              <ProtectedRoute>
                <Bookings />
              </ProtectedRoute>
            }
          />
          <Route
            path="/loyalty"
            element={
              <ProtectedRoute>
                <Loyalty />
              </ProtectedRoute>
            }
          />
          <Route
            path="/boutique"
            element={
              <ProtectedRoute>
                <Boutique />
              </ProtectedRoute>
            }
          />
          <Route
            path="/notifications"
            element={
              <ProtectedRoute>
                <Notifications />
              </ProtectedRoute>
            }
          />
          <Route
            path="/chat"
            element={
              <ProtectedRoute>
                <Chat />
              </ProtectedRoute>
            }
          />
          <Route path="/" element={<Navigate to="/bookings" replace />} />
          <Route path="*" element={<Navigate to="/bookings" replace />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
