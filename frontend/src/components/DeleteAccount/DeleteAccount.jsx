import React, { useState } from 'react';
import { useLocation } from 'react-router-dom'; // Kullanıcı bilgilerini almak için useLocation kullanıyoruz
import axios from 'axios'; // Axios'u içe aktar
import './DeleteAccount.css'; // CSS dosyasını içe aktar

const DeleteAccount = () => {
  const location = useLocation(); // Kullanıcı bilgilerini almak için kullanıyoruz
  const { username, password } = location.state || {}; // Kullanıcı adı ve şifreyi al
  const [message, setMessage] = useState('');
  const [messageClass, setMessageClass] = useState('');
  
  const handleDelete = async () => {
    try {
      const response = await axios.delete('http://localhost:8080/api/1.0/users', {
        data: {
          username,
          password,
        },
      });

      // Hesap silme işlemi başarılı ise mesaj göster
      if (response.status === 200) {
        setMessage('Your account has been successfully deleted.'); // Başarılı mesaj
        setMessageClass('success'); // Başarılı mesaj sınıfını ayarla
      }
    } catch (error) {
      console.error('Delete account error:', error);
      setMessage('Account is not found.'); // Hata mesajı
      setMessageClass('error'); // Hata mesajı sınıfını ayarla
    
  };
  };
 
  return (
    <div className="delete-container">
      <div className="delete-card">
        <h2 className="delete-title">Delete Account</h2>
        <p>Are you sure you want to delete your account?</p>
        <p>(This process can not be undone.)</p>
           <button className="delete-button" onClick={handleDelete}>Delete My Account</button>
        {message && <p className={`delete-message ${messageClass}`}>{message}</p>} {/* Mesajı göster */}
      </div>
    </div>
  );
};

export default DeleteAccount;