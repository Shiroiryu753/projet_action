from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "A LA HEH, Monsieur TRICARICO trouve le cours test tatata"

@app.route("/ping")
def ping():
    return "ping"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)