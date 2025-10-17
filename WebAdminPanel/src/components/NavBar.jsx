import { Link, useLocation, useNavigate } from "react-router-dom";
import "./NavBar.css";

// PUBLIC_INTERFACE
export default function NavBar() {
  /** Top navigation for admin panel with active route highlighting and logout */
  const location = useLocation();
  const navigate = useNavigate();

  const logout = () => {
    localStorage.removeItem("authToken");
    navigate("/login");
  };

  const isActive = (path) => location.pathname.startsWith(path);

  return (
    <nav className="navbar">
      <div className="navbar__brand">
        <Link to="/">Uppuveli Admin</Link>
      </div>
      <ul className="navbar__links">
        <li className={isActive("/bookings") ? "active" : ""}><Link to="/bookings">Bookings</Link></li>
        <li className={isActive("/loyalty") ? "active" : ""}><Link to="/loyalty">Loyalty</Link></li>
        <li className={isActive("/boutique") ? "active" : ""}><Link to="/boutique">Boutique</Link></li>
        <li className={isActive("/notifications") ? "active" : ""}><Link to="/notifications">Notifications</Link></li>
        <li className={isActive("/chat") ? "active" : ""}><Link to="/chat">Chat</Link></li>
      </ul>
      <div className="navbar__actions">
        <button className="btn" onClick={logout}>Logout</button>
      </div>
    </nav>
  );
}
