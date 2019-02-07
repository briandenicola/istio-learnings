package main

import (
	"encoding/json"
	"time"
	"os"
	"net/http"
	"fmt"
	"log"
	"runtime"
	"github.com/gorilla/mux"
	"github.com/rs/cors"

	"github.com/opentracing-contrib/go-stdlib/nethttp"
	opentracing "github.com/opentracing/opentracing-go"
	jaeger "github.com/uber/jaeger-client-go"
	"github.com/uber/jaeger-client-go/zipkin"
)

var version string = "v2"

type OS struct {
	Time string
    Host string
	OSType string
	Version string
}

type newAPIHandler struct { }
func (eh *newAPIHandler) getOperatingSystemHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	
	host, _ := os.Hostname()
	ostype := runtime.GOOS 
	
	msg := OS{ 
		time.Now().Format(time.RFC850), 
		host, 
		ostype,
		version}	

	json.NewEncoder(w).Encode(msg)
}

func (eh *newAPIHandler) optionsHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
}

func main() {
	handler := newAPIHandler{}

	r := mux.NewRouter()
	apirouter := r.PathPrefix("/api").Subrouter()
	apirouter.Methods("GET").Path("/jaeger").HandlerFunc(handler.getOperatingSystemHandler)
	apirouter.Methods("OPTIONS").Path("/jaeger").HandlerFunc(handler.optionsHandler)

	server := cors.Default().Handler(r)

	zipkinPropagator := zipkin.NewZipkinB3HTTPHeaderPropagator()
	injector := jaeger.TracerOptions.Injector(opentracing.HTTPHeaders, zipkinPropagator)
	extractor := jaeger.TracerOptions.Extractor(opentracing.HTTPHeaders, zipkinPropagator)
	zipkinSharedRPCSpan := jaeger.TracerOptions.ZipkinSharedRPCSpan(true)

	sender, _ := jaeger.NewUDPTransport("jaeger-agent.istio-system:5775", 0)
	tracer, closer := jaeger.NewTracer(
		"whatos",
		jaeger.NewConstSampler(true),
		jaeger.NewRemoteReporter(
			sender,
			jaeger.ReporterOptions.BufferFlushInterval(1*time.Second)),
		injector,
		extractor,
		zipkinSharedRPCSpan,
	)
	defer closer.Close()

	port := ":8081"
	if os.Getenv("AES_KEYS_PORT") != "" {
		port = os.Getenv("AES_KEYS_PORT")
	} 

	fmt.Print("Listening on ", port)
	log.Fatal(http.ListenAndServe(
		port, 
		nethttp.Middleware(tracer, server)))
}
