class ApiUrl {
    static localhost= "http://localhost:8081/";
    // static remotehost = "http://172.17.0.1:8081/";
    static remotehost = "http://remoteIp:8081/";
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
}

export default ApiUrl;