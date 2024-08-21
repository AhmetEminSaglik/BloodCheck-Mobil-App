import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios'; 
import './Login.css'; 
import ApiUrl from '../ApiURL/ApiURL';

const Login = ({ setIsAuthenticated }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState(''); 
  const navigate = useNavigate(); 

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrorMessage(''); 
    try {
      var url=`${ApiUrl.getUsersUrl()}/login`;
      const response = await axios.post(url, {
        username,
        password,
      });

      if (response.status === 200) {
        setIsAuthenticated(true);
        navigate('/delete-account', { state: { username, password } });
      }
    } catch (error) {
      console.error('Login error:', error);
      setErrorMessage('Invalid Username or password.'); 
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
        {errorMessage && <p className="login-error-message">{errorMessage}</p>} 
      </div>
    </div>
  );
};

export default Login;