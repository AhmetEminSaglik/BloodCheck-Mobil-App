import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom'; // Yönlendirme için useNavigate kullanıyoruz
import axios from 'axios'; // Axios'u içe aktar
import './Login.css'; // CSS dosyasını içe aktar

const Login = ({ setIsAuthenticated }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState(''); // Hata mesajı durumu
  const navigate = useNavigate(); // Yönlendirme için useNavigate hook'u

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrorMessage(''); // Önceki hata mesajını temizle
    try {
      const response = await axios.post('http://localhost:8080/api/1.0/users/login', {
        username,
        password,
      });

      // Giriş başarılı ise DeleteAccount sayfasına yönlendir
      if (response.status === 200) {
        setIsAuthenticated(true);
        navigate('/delete-account', { state: { username, password } });
      }
    } catch (error) {
      console.error('Login error:', error);
      setErrorMessage('Invalid Username or password.'); // Hata mesajı
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <h2 className="login-title">Login</h2>
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            placeholder="Username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            className="login-input"
          />
          <input
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="login-input"
          />
          <button type="submit" className="login-button">Login</button>
        </form>
        {errorMessage && <p className="login-error-message">{errorMessage}</p>} {/* Hata mesajı göster */}
      </div>
    </div>
  );
};

export default Login;