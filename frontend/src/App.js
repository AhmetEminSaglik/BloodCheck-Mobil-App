import React, {useState} from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import Login from './components/Login/Login'; 
import DeleteAccount from './components/DeleteAccount/DeleteAccount'; 
import AddBloodResult from './components/BloodResult/AddBloodResult';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  return (
    <Router>
      <Routes>
        <Route path="/login" 
        element={<Login setIsAuthenticated={setIsAuthenticated} />} />
       <Route path="/blood-results/add"
       element={<AddBloodResult/>}/>
          {/* <Route path="/patient-info" */}
       {/* element={<PatientInfo/>}/> */}
        <Route path="/delete-account" 
        element={isAuthenticated ? <DeleteAccount /> : <Navigate to="/login" replace />} />
        <Route path="*" element={<Navigate to="/login" replace />} />
      </Routes>
    </Router>
  );
}

export default App;