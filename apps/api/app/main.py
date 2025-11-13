from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI(title="Matrim API", version="0.1.0")


@app.get("/")
def root():
    return {"message": "Matrim API is running. Try /health or /hello."}


@app.get("/health")
def health():
    return JSONResponse({"status": "ok"})


@app.get("/hello")
def hello(name: str = "world"):
    return {"message": f"Hello, {name}!"}
