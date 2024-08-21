class ApiUrl {
    static localhost= "http://localhost:8080/api/1.0/";
    static remotehost = "http://remote_host_IP:8080/api/1.0/";
    static BASE_URL=this.localhost;
    // static BASE_URL=this.remotehost;

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