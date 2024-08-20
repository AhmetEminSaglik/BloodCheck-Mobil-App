// AddBloodResult.jsx
import React, { useState } from 'react';
import './AddBloodResult.css';

const AddBloodResult = () => {
    const [patientId, setPatientId] = useState('');
    const [patientName, setPatientName] = useState('');
    const [isPatientFound, setIsPatientFound] = useState(null);
    const [bloodSugar, setBloodSugar] = useState(0);
    const [bloodPressure, setBloodPressure] = useState(0);
    const [calcium, setCalcium] = useState(0);
    const [magnesium, setMagnesium] = useState(0);
    const [errors, setErrors] = useState({});
    const [responseData, setResponseData] = useState('');

    const fetchPatientName = async () => {

        try {
            const response = await fetch(`http://localhost:8080/api/1.0/patients/${patientId}`);

            if (!response.ok) {
                setIsPatientFound(false);
                // throw new Error('Hasta bulunamadı');
                return null;
            }
            const data = await response.json();

            setPatientName(`${data.data.name} ${data.data.lastname}`);
            setIsPatientFound(true);

        } catch (error) {
            console.error('Fetch error:', error);
            return null; // Hata durumunda null döndür
        }
    };

    const handleSave = async () => {


        const newErrors = {};

        if (patientId <= 0) {
            newErrors.patientId = 'The Patient ID value must be at least 1.';
        }

        if (bloodSugar < 0 || bloodSugar > 200) {
            newErrors.bloodSugar = 'Blood sugar value must be between 0 and 200';
        }

        if (bloodPressure < 0 || bloodPressure > 200) {
            newErrors.bloodPressure = 'Blood pressure value must be between 0 and 200.';
        }

        if (calcium < 0 || calcium > 200) {
            newErrors.calcium = 'Calcium value must be between 0 and 200.';
        }

        if (magnesium < 0 || magnesium > 200) {
            newErrors.magnesium = 'Magnesium value must be between 0 and 200.';
        }

        setErrors(newErrors);

        if (Object.keys(newErrors).length === 0 && isPatientFound) {
            // Verileri kaydetmek için gerekli işlemleri burada yapın
            console.log({
                patientId,
                patientName,
                bloodSugar,
                bloodPressure,
                calcium,
                magnesium,
            });


            const response = await fetch('http://localhost:8080/api/1.0/bloodresults', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    bloodSugar: bloodSugar,
                    bloodPressure: bloodPressure,
                    calcium: calcium,
                    magnesium: magnesium,
                }),
            });

            const data = await response.json();
            setResponseData(data);
        }else{
            alert("Please type available values");
        }
    };

    const isFormValid = Object.keys(errors).length === 0 && patientId > 0 && isPatientFound === true;

    const handleInputFocus = () => {
        setResponseData(null); // İnput odaklandığında yanıt mesajını temizle
    };

    return (
        <div className="add-blood-result">
            <h2>Add Blood Result</h2>
            <div className="input-group">
                {/* <label>Patient Id (7 or bigger)</label> */}
                <label>Patient Id </label>
                <input
                    type="number"
                    min="1"
                    value={patientId}
                    onChange={(e) => setPatientId(e.target.value)}
                    onFocus={handleInputFocus}
                    onBlur={fetchPatientName} // Hasta ID'si girildiğinde adı getir
                />
                <label style={{ color: isPatientFound === true ? 'green' : isPatientFound === false ? 'red' : 'inherit' }}>
                    {isPatientFound === true ? `Found Patient: ${patientName}` : isPatientFound === false ? 'Patient is not Found' : ''}
                </label>
                <br />
                {errors.patientId && <span className="error">{errors.patientId}</span>}
            </div>
            <div className="input-group">
                <label>Blood Sugar (0-200)</label>
                <input
                    type="number"
                    value={bloodSugar}
                    onChange={(e) => setBloodSugar(e.target.value)}
                    onFocus={handleInputFocus}
                    min="0" // Minimum değer
                    max="200" // Maksimum değer
                />
                {errors.bloodSugar && <span className="error">{errors.bloodSugar}</span>}
            </div>
            <div className="input-group">
                <label>Blood Pressure (0-200)</label>
                <input
                    type="number"
                    value={bloodPressure}
                    onChange={(e) => setBloodPressure(e.target.value)}
                    onFocus={handleInputFocus}
                    min="0" // Minimum değer
                    max="200" // Maksimum değer
                />
                {errors.bloodPressure && (
                    <span className="error">{errors.bloodPressure}</span>
                )}
            </div>
            <div className="input-group">
                <label>Calcium (0-200)</label>
                <input
                    type="number"
                    value={calcium}
                    onChange={(e) => setCalcium(e.target.value)}
                    onFocus={handleInputFocus}
                    min="0" // Minimum değer
                    max="200" // Maksimum değer
                />
                {errors.calcium && <span className="error">{errors.calcium}</span>}
            </div>
            <div className="input-group">
                <label>Magnesium (0-200)</label>
                <input
                    type="number"
                    value={magnesium}
                    onChange={(e) => setMagnesium(e.target.value)}
                    onFocus={handleInputFocus}
                    min="0" // Minimum değer
                    max="200" // Maksimum değer
                />
                {errors.magnesium && <span className="error">{errors.magnesium}</span>}
            </div>
            <button
                onClick={handleSave}>
                Save
            </button>
            {/* {responseMessage && <p>{responseMessage}</p>} */}

            <label style={{ color: responseData && responseData.success === true ? 'green' : 'red' }}>
                {responseData && <p>{responseData.message}</p>}
            </label>
        </div>
    );
};

export default AddBloodResult;