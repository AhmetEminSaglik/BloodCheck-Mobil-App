import React, {useState} from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import Login from './components/Login/Login'; // Login bileşenini içe aktar
import DeleteAccount from './components/DeleteAccount/DeleteAccount'; // DeleteAccount bileşenini içe aktar
import AddBloodResult from './components/BloodResult/AddBloodResult';
// import PatientInfo from './components/PatientInfo/PatientInfo'; 

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
// import React from 'react';
// import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
// import DeleteAccount from './DeleteAccount';
// import Login from './Login';
// function App() {
//   return (
//     <Router>
//       <div className="App">
//         <header className="App-header">
//         </header>
//         <Login/>
//       </div>
//     </Router>
//   );
// }

// export default App;
// import React from 'react';
// import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
// import DeleteAccount from './DeleteAccount';

// function App() {
//   return (
//     <Router>
//       <div className="App">
//         <header className="App-header">
//         </header>
//         <Routes>
//           <Route path="/accounts" element={<DeleteAccount />} />
//           {/* Tüm diğer URL'ler için yönlendirme */}
//           <Route path="*" element={<Navigate to="/accounts" replace />} />
//         </Routes>
//       </div>
//     </Router>
//   );
// }

// export default App;