class ApiUrl {
    // static localhost= "http://localhost:8081/";
    // static remotehost = "http://172.17.0.1:8081/";
    // static remotehost = "http://172.17.0.1:8081/";
    // static remotehost = "http://ws-bloodcheck:8081/";
    // static remotehost = "http://my-network:8081/";
    static remotehost = "https://bloodcheck.ahmeteminsaglik.com/api/1.0/";
    // static BASE_URL=this.localhost;
    static BASE_URL=this.remotehost;

    static getBloodResultsUrl() {
        return `${this.BASE_URL}bloodresults`;
    }

    static getPatientsUrl() {
        return `${this.BASE_URL}patients`;
    }

    static getUsersUrl() {
        return `${this.BASE_URL}users`;
    }
    
    static getLoginUrl() {
        return `${this.BASE_URL}login`;
    }
}

export default ApiUrl;