// A system package containing protocol access constructs
// Package objects referenced with 'http:' in code
import ballerina/http;
endpoint http:Listener listener {
    port: 9090
};

@http:ServiceConfig {
    basePath: "/"
}

// A service is a network-accessible API
// Advertised on '/hello', port comes from listener endpoint
service<http:Service> hello bind listener {

    # A resource is an invokable API method
    # Accessible at '/hello/sayHello
    #'caller' is the client invoking this resource 

    # + caller - Server Connector
    # + request - Request
    sayHello (endpoint caller, http:Request request) {

        // Create object to carry data back to caller
        http:Response response = new;


        json responseJson = {
            "message": "Hello Ballerina!"
        };
        http:Response res = new;

        res.setJsonPayload(untaint responseJson);

        // Send a response back to caller
        // Errors are ignored with '_'
        // -> indicates a synchronous network-bound call
        _ = caller -> respond(res);
    }
}
