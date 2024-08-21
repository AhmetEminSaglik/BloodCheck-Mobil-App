// AddBloodResult.jsx
import React, { useState } from 'react';
import axios from 'axios'; 
import './AddBloodResult.css';
import ApiUrl from '../ApiURL/ApiURL';

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
            var url=`${ApiUrl.getPatientsUrl()}/${patientId}`;
            const response = await axios.get(url);
            
            if (response.data.success) {
                const data = response.data.data;
                setPatientName(`${data.name} ${data.lastname}`);
                setIsPatientFound(true);
            }
        } catch (error) {
            setIsPatientFound(false);
            console.error('Fetch error:', error);
            return null; 
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

            try {
                var url=ApiUrl.getBloodResultsUrl();
                const response = await axios.post(url,{
                    patientId:patientId,
                    bloodSugar: bloodSugar,
                    bloodPressure: bloodPressure,
                    calcium: calcium,
                    magnesium: magnesium,
                });

                const data = response.data;
                setResponseData(data);
            } catch (error) {
                console.error('Axios POST error:', error);
            }
        } else {
            alert("Please type available values");
        }
    };

    const isFormValid = Object.keys(errors).length === 0 && patientId > 0 && isPatientFound === true;

    const handleInputFocus = () => {
        setResponseData(null); 
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
                    onBlur={fetchPatientName} 
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
                    min="0"  
                    max="200"  
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
                    min="0"  
                    max="200"  
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
                    min="0" 
                    max="200"
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
                    min="0" 
                    max="200" 
                />
                {errors.magnesium && <span className="error">{errors.magnesium}</span>}
            </div>
            <button
                onClick={handleSave}>
                Save
            </button>
            <label style={{ color: responseData && responseData.success === true ? 'green' : 'red' }}>
                {responseData && <p>{responseData.message}</p>}
            </label>
        </div>
    );
};

export default AddBloodResult;