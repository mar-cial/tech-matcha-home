package main

import (
	"log"
	"net/http"

	"github.com/mar-cial/home-app/internal/templates/pages"
)

func homepage(w http.ResponseWriter, r *http.Request) {
	if err := pages.Homepage().Render(r.Context(), w); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func register(w http.ResponseWriter, r *http.Request) {
	if err := pages.Register().Render(r.Context(), w); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func main() {
	mux := http.DefaultServeMux

	mux.HandleFunc("/", homepage)
	mux.HandleFunc("/register", register)

	server := &http.Server{
		Addr:    ":8080",
		Handler: mux,
	}

	log.Printf("Running on port %s\n", server.Addr)
	if err := server.ListenAndServe(); err != nil {
		log.Fatalln(err)
	}
}
