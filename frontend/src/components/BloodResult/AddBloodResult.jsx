import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './AddBloodResult.css';
import ApiUrl from '../ApiURL/ApiURL';

const AddBloodResult = () => {
    const [patients, setPatients] = useState([]); // Hasta listesini tutacak
    const [selectedPatientId, setSelectedPatientId] = useState(null); // Seçilen hasta ID'si
    const [bloodSugar, setBloodSugar] = useState(0);
    const [bloodPressure, setBloodPressure] = useState(0);
    const [calcium, setCalcium] = useState(0);
    const [magnesium, setMagnesium] = useState(0);
    const [errors, setErrors] = useState({});
    const [responseData, setResponseData] = useState('');

    // Hastaları çekmek için bir API çağrısı
    useEffect(() => {
        const fetchPatients = async () => {
            try {
                const response = await axios.get(ApiUrl.getPatientsUrl());
                if (response.data.success) {
                    setPatients(response.data.data); // Hastaları kaydet
                }
            } catch (error) {
                console.error('Fetch patients error:', error);
            }
        };

        fetchPatients();
    }, []);

    const handleSave = async () => {
        const newErrors = {};

        if (!selectedPatientId) {
            newErrors.patient = 'You should select an patient.';
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

        if (Object.keys(newErrors).length === 0) {
            try {
                var url = ApiUrl.getBloodResultsUrl();
                const response = await axios.post(url, {
                    patientId: selectedPatientId,
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
        }
      
    };

    return (
        <div className="add-blood-result">
            <h2>Add Blood Result</h2>
            <div className="input-group">
                <div className="input-label">
                    <label >Patient </label>
                </div>
                <select
                    className="input-group-listview"
                    value={selectedPatientId || ''}
                    onChange={(e) => setSelectedPatientId(e.target.value)}
                >
                    <option value="">Select Patient</option>
                    {patients.map(patient => (
                        <option key={patient.id} value={patient.id}>
                            {patient.name} {patient.lastname}
                        </option>
                    ))}
                </select>
                {errors.patient && <span className="error">{errors.patient}</span>}
            </div>
            <div className="input-group">
                <div className="input-label">
                    <label >Blood Sugar (0-200) </label>
                </div>
                <input
                    type="number"
                    value={bloodSugar}
                    onChange={(e) => setBloodSugar(e.target.value)}
                    min="0"
                    max="200"
                />
                {errors.bloodSugar && <span className="error">{errors.bloodSugar}</span>}
            </div>
            <div className="input-group">
                <div className="input-label">
                    <label >Blood Pressure (0-200) </label>
                </div>
                <input
                    type="number"
                    value={bloodPressure}
                    onChange={(e) => setBloodPressure(e.target.value)}
                    min="0"
                    max="200"
                />
                {errors.bloodPressure && <span className="error">{errors.bloodPressure}</span>}
            </div>
            <div className="input-group">
                <div className="input-label">
                    <label >Calcium (0-200) </label>
                </div>
                <input
                    type="number"
                    value={calcium}
                    onChange={(e) => setCalcium(e.target.value)}
                    min="0"
                    max="200"
                />
                {errors.calcium && <span className="error">{errors.calcium}</span>}
            </div>
            <div className="input-group">
                <div className="input-label">
                    <label >Magnesium (0-200) </label>
                </div>
                <input
                    type="number"
                    value={magnesium}
                    onChange={(e) => setMagnesium(e.target.value)}
                    min="0"
                    max="200"
                />
                {errors.magnesium && <span className="error">{errors.magnesium}</span>}
            </div>
            <button onClick={handleSave}>Save</button>
            <label style={{ color: responseData && responseData.success === true ? 'green' : 'red' }}>
                {responseData && <p>{responseData.message}</p>}
            </label>
        </div>
    );
};

export default AddBloodResult;