import React, { useState } from 'react';
import { useLocation } from 'react-router-dom';
import axios from 'axios';
import './DeleteAccount.css';
import ApiUrl from '../ApiURL/ApiURL';

const DeleteAccount = () => {
  const location = useLocation();
  const { username } = location.state || {};
  const [message, setMessage] = useState('');
  const [messageClass, setMessageClass] = useState('');

  const token = localStorage.getItem("token");

  const handleDelete = async () => {
    try {
      const token = localStorage.getItem("token");

      const response = await axios.delete(ApiUrl.getUsersUrl(), {
        data: { username },
        headers: {
          Authorization: `Bearer ${token}`
        }
      });

      if (response.status === 200) {
        setMessage("Account deleted");
      }
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <div className="delete-container">
      <div className="delete-card">
        <h2 className="delete-title">Delete Account</h2>
        <p>Are you sure you want to delete your account?</p>
        <p>(This process can not be undone.)</p>
        <button className="delete-button" onClick={handleDelete}>Delete My Account</button>
        {message && <p className={`delete-message ${messageClass}`}>{message}</p>} { }
      </div>
    </div>
  );
};

export default DeleteAccount;