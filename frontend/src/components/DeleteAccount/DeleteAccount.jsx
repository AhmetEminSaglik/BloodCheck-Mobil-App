import React, { useState } from 'react';
import { useLocation } from 'react-router-dom';
import axios from 'axios'; 
import './DeleteAccount.css'; 
import ApiUrl from '../ApiURL/ApiURL';

const DeleteAccount = () => {
  const location = useLocation(); 
  const { username, password } = location.state || {}; 
  const [message, setMessage] = useState('');
  const [messageClass, setMessageClass] = useState('');
  
  const handleDelete = async () => {
    try {
      const response = await axios.delete(ApiUrl.getUsersUrl(), {
        data: {
          username,
          password,
        },
      });

      if (response.status === 200) {
        setMessage('Your account has been successfully deleted.'); 
        setMessageClass('success'); 
      }
    } catch (error) {
      console.error('Delete account error:', error);
      setMessage('Account is not found.'); 
      setMessageClass('error');
    
  };
  };
 
  return (
    <div className="delete-container">
      <div className="delete-card">
        <h2 className="delete-title">Delete Account</h2>
        <p>Are you sure you want to delete your account?</p>
        <p>(This process can not be undone.)</p>
           <button className="delete-button" onClick={handleDelete}>Delete My Account</button>
        {message && <p className={`delete-message ${messageClass}`}>{message}</p>} {}
      </div>
    </div>
  );
};

export default DeleteAccount;